// Copyright (c) 2020 SRI International All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.


//This pass uses SVF to generate Value Flow Graph (VFG). Starting from argv, it marks the objects (allocas, mallocs), which are directly or indirectly related to argv, as annotated by setting their metadata to tracked by using the VFG. Loops that uses these configuration objects are annotated by placing a function call (loop_unroll) as the first statement of the loop, so that the ConstantFolding pass knows which loops are to be unrolled.

#include "AnnotateNew.h"
#include "Debug.h"

#include "llvm/ADT/DenseMap.h"
#include "llvm/IR/IRBuilder.h"

#include <algorithm>
#include <climits>
#include <set>
#include <map>
#include "WPA/Andersen.h"
#include "Graphs/PAG.h"
#include "MSSA/SVFGBuilder.h"
#include "SVF-FE/PAGBuilder.h"
#include "MSSA/MemSSA.h"
#include "SVF-FE/LLVMModule.h"
#include "llvm/Analysis/AssumptionCache.h"
#include "LoopUnroller.h"
#include <chrono>
#include <fstream>

//getLoopIterator -> genericScalarDfsBackward -> isLoad (Memoized)
//getBranchMemory -> genericScalarDfsBackward -> isLoadOrArgc (Memoized)
//getSourceAllocas -> backwardDfsLambda -> backwardDfsCondition

//getMemoryFlow ->  forwardDfsLambda -> forwardDfsCondition
//getLoadsOnSlps -> genericScalarDfs -> isLoadOnSingleLevelPointer
//getBbsTillJoin -> forwardBBDfs -> lambdaCondition
static cl::opt<std::string> argvName("argvName",
    cl::desc("global to track"));
static cl::opt<int> argvId("argvId",
    cl::desc("global to track"));
static cl::opt<int> isTest("isTest",
    cl::desc("true if running tests"));
static cl::opt<int> isAnnotated("isAnnotated",
    cl::desc("is code annotated e.g. loops"));

static cl::opt<bool> isLimitedDepth("isLimitedDepth",cl::init(false),
    cl::desc("do we want to limit forward dfs to limited CFG depth"));


static cl::opt<int> depthLimit("depthLimit", cl::init(1));

static cl::opt<bool> isLoadsLimited("isLoadsLimited",cl::init(false),
    cl::desc("do we want to consider only a limited \% of the sources sorted on number of loads dependent on them"));

static cl::opt<int> loadPercent("loadPercent", cl::init(100));

struct DfsDepthInfo {
  SVFGNode* node;
  int depth; // remaining depth last observed
  DfsDepthInfo(SVFGNode* node, int depth): node(node), depth(depth) {}
};



PAG* globPag = NULL;
SVFG* globSvfg = NULL;
// SVFGOPT* globSvfg = NULL;
set<SVFGNode*> forwardDp;
map<SVFGNode* ,DfsDepthInfo*> forwardDepthDp;
set<Value*> slpLoadDp;
set<SVFGNode *> backwardDp;
set<const Function *> depthFunctions;
map<const SVFGNode*, int > LoadsOnSource;

map<Value*, const SVFGNode*> valToNode; 

/**
 * Statistics to start tracking
 * 1) Alloca used in how many functions
 * 2) How many loads on an Alloca(More loads -> probably config variable)
 * 3) How many stores on an Alloca (Most stores in one function -> config parsing function -> config variable)
 * 4) Whether function stores on alloca
 *
 * How to do?
 * 1) Add current Alloca/Value global variable
 * 2) For each value in data flow graph of current Value, check:
 *      i)   What's the parent function (For 1)
 *      ii)  Whether it's a load (For 2)
 */
struct Stat {
  set<Value *> loads;
  set<Value *> stores;
  set<Value *> branches;
  Value *value;
};


map<Value *, Stat > statMap;
Value *currentValue;

using namespace std;
// using namespace analysisUtil;
using namespace llvm;

char AnnotateNew::ID = 0;

void dfsLoads(const SVFGNode* src,set<const Instruction*>& Loads, set<const SVFGNode*> &visited){
  if(visited.find(src) != visited.end())
    return;

  visited.insert(src);
  if(auto* LI = dyn_cast<LoadSVFGNode>(src)){
    Loads.insert(LI->getInst());
  }


  for(auto it = src->OutEdgeBegin(), end = src->OutEdgeEnd(); it != end; ++it){
    SVFGNode* succ = (*it)->getDstNode();
    dfsLoads(succ, Loads, visited);
  }

}


bool myComparator(Value* valA, Value* valB){
  const SVFGNode* srcNodeA = valToNode[valA];
  const SVFGNode* srcNodeB = valToNode[valB];



  if(LoadsOnSource.find(srcNodeA) == LoadsOnSource.end() ||
      LoadsOnSource.find(srcNodeB) == LoadsOnSource.end()){
    debug(Yes)<<"\n in CMP, one node doesn't have a source\n";
  }
  return (LoadsOnSource[srcNodeA] > LoadsOnSource[srcNodeB]);

}

// For a given callgraph depths, 'Mark' all reachable functions within a given depth
void AnnotateNew::setDepthFunctions(int depth, set<const Function *> & depthCG, const Function* F){

  if(!depth)
    return;

  static map<const Function*, int> depthMap;

  if(depthMap.find(F) != depthMap.end()){
    int oldDepth = depthMap[F];
    if(oldDepth >= depth){ // Already visited this function with higher depth remaining
      return;
    }
  }

  depthMap[F] = depth;

  int newDepth = depth-1;


  for(auto & BB: *F){
    for(auto &I : BB){
      if(auto* CI  = dyn_cast<CallInst>(&I)){
        const Function* Callee = CI->getCalledFunction();

        if(Callee){
          depthCG.insert(Callee);
          setDepthFunctions(newDepth, depthCG, Callee);
        }
      }
    }
  }

}

void AnnotateNew::getSlpStores(set<const Value *>& singleLevelPointers, set<Value*>& stores) {
  set<Value*> scalars; //these are esentially normal llvm scalar values, tracked through use def chains
  //Handle single level pointers
  for(auto &pointer: singleLevelPointers) {
    getLoadsOnSlps((Value*) pointer, scalars); 
  }
  for(auto &scalar: scalars) {
    getScalarStores(scalar, stores); 
  }
}

bool isMemTransfer(const Value *inst) {
  if(dyn_cast<StoreInst>(inst))
    return true;

  if(dyn_cast<MemCpyInst>(inst))
    return true;

  if(auto casted =dyn_cast<CallInst>(inst)) {
    if(casted->getCalledFunction())
      debug(Yes) << casted->getCalledFunction()->getName() << "\n"; 

    if(casted->getCalledFunction() && (casted->getCalledFunction()->getName() == "strncpy" || casted->getCalledFunction()->getName() == "strcpy"))
      return true;
  }

  return false;
}

void AnnotateNew::trackStats(Value *val) {
  if(!val || !currentValue)
    return;
  if(isMemTransfer(val))
    statMap[currentValue].stores.insert(val);

  if(dyn_cast<LoadInst>(val))
    statMap[currentValue].loads.insert(val);

  if(dyn_cast<BranchInst>(val))
    statMap[currentValue].branches.insert(val);
  statMap[currentValue].value = currentValue;
}

void AnnotateNew::trackStats(SVFGNode *node) {
  if(auto stmt = dyn_cast<StmtSVFGNode>(node))
    trackStats((Value *) stmt->getInst());
}

GlobalValue* getArgv(string argvName, Module &M) {
  if(argvName.size())
    return M.getNamedValue(argvName);
  return NULL;  
}

static RegisterPass<AnnotateNew> X("annotateNew", "Constant Folding for strings", false, false);

const BasicBlock *AnnotateNew::partOfLoop(const BasicBlock *BB) {
  if(loopHeaders.find(BB) != loopHeaders.end())
    return loopHeaders[BB];

  return NULL;
}

void AnnotateNew::checkIfLoop(SVFGNode *node) {
  if(auto stmt = dyn_cast<StmtSVFGNode>(node)) {
    if(stmt->getInst()) {
      const BasicBlock * data = partOfLoop(stmt->getInst()->getParent());
      if(data) {
        if(markedLoops.insert(data).second) {
          debug(Yes) << "(LOG) (LOOP) Marking loop for BB " <<  data->getName() << " in function " <<  data->getParent()->getName() << " for instruction " << *stmt->getInst() << "\n";
        }
      }
    }
  }
}

void AnnotateNew::checkIfLoop(Value *node) {
  if(auto inst = dyn_cast<Instruction>(node)) {
    const BasicBlock *data = partOfLoop(inst->getParent());
    if(data) {
      if(markedLoops.insert(data).second) {
        debug(Yes) << "(LOG) (LOOP) Marking loop for BB " << data->getName() << " in function " << data->getParent()->getName() << " for instruction " << *inst << "\n";
      }
    }
  }
}



set<SVFGNode*> *AnnotateNew::dfs_rec(SVFGNode* root, std::function<vector<SVFGNode*> (SVFGNode*)> nextNodes, std::function<bool (SVFGNode*)> condition, set<SVFGNode*> &visited, map<SVFGNode*, set<SVFGNode*>* > *dpData, bool trackLoops) {
  //static map<T, set<T>* > dpData;
  dpData = NULL;
  if(visited.find(root) != visited.end()) {
    return NULL;
  }
  debug(Yes)<<"dfs_rec\n";

  visited.insert(root);
  if(dpData && dpData->find(root) != dpData->end()) {
    debug(Yes) << "Found in dp svfg" << "\n";
    set<SVFGNode*> *temp = dpData->find(root)->second;
    return temp;
  }

  if(trackLoops)
    checkIfLoop(root);

  trackStats(root);

  set<SVFGNode*> *output = new set<SVFGNode*>;

  if(condition(root)) {
    debug(Yes)<<"Adding root to output\n";
    output->insert(root);
  }

  vector<SVFGNode*> children = nextNodes(root);
  for(auto child : children) {
    set<SVFGNode*> *childOutput = dfs_rec(child, nextNodes, condition, visited, NULL , trackLoops);
    if(childOutput)
      output->insert(childOutput->begin(), childOutput->end());
     }
  if(dpData)
    (*dpData)[root] = output;

  return output;
}


set<SVFGNode*> *AnnotateNew::dfs_rec_limit(SVFGNode* root, std::function<vector<SVFGNode*> (SVFGNode*,int)> nextNodes, std::function<bool (SVFGNode*)> condition, set<SVFGNode*> &visited,int depth ,map<SVFGNode*, set<SVFGNode*>* > *dpData, bool trackLoops) {
  dpData = NULL;
  debug(Yes)<<"dfs_rec_limit with depth: "<<depth<<"\n";


  if(dpData && dpData->find(root) != dpData->end()) {
    debug(Yes) << "Found in dp svfg" << "\n";
    set<SVFGNode*> *temp = dpData->find(root)->second;
    return temp;
  }

  if(trackLoops)
    checkIfLoop(root);

  trackStats(root);

  set<SVFGNode*> *output = new set<SVFGNode*>;


  debug(Yes)<<"\n";
  if(auto rootStmt = dyn_cast<StmtSVFGNode>(root)){
    debug(Yes)<<"\nRoot is a StmtSVFGNode!\n";
    auto* inst = rootStmt->getInst();

    if(inst == NULL){//Function argument?
      debug(Yes)<<"Roots value is null\n";
    } else {
      debug(Yes)<<"Root's function is "<<inst->getParent()->getParent()->getName()<<"\n";
      auto* F = inst->getParent()->getParent();
      if(depthFunctions.find(F) == depthFunctions.end()){
        debug(Yes)<<"In function not in CallGraph depth\n";
        return output;
      }
    }


  } else if(auto phi = dyn_cast<InterPHISVFGNode>(root)){
    if(auto* ARG = dyn_cast<Argument>(phi->getRes()->getValue())){
      auto* F = ARG->getParent();
      if(depthFunctions.find(F) == depthFunctions.end()){
        debug(Yes)<<"In function not in CallGraph depth\n";
        return output;
      }

      debug(Yes)<<"CallGraph Function: "<<ARG->getParent()->getName()<<"\n";
      debug(Yes)<<"Root is an ARGUMENT, decrement depth of "<<depth<<"\n";
      depth--;
    }
  } else if(auto parm = dyn_cast<FormalParmSVFGNode>(root)){
    debug(Yes)<<"FormalParmSVFGNode for function: "<<parm->getFun()->getName()<<"\n";
    depth--;
  } else if(auto parm = dyn_cast<ActualParmSVFGNode>(root)){
    debug(Yes)<<"Actual Parm!!!\n";
    depth--;
  } else if(auto in = dyn_cast<FormalINSVFGNode>(root)){
    auto* F = in->getFun()->getLLVMFun();
    if(depthFunctions.find(F) == depthFunctions.end()){
      debug(Yes)<<"In function not in CallGraph depth\n";
      return output;
    }

    debug(Yes)<<"FormalINSVFGNode for function: "<<in->getFun()->getName()<<"\n";
    depth--;
  } else {

    debug(Yes)<<"NEITHER CASE!!!!\n";


  }





  if(condition(root) && depth != 0) {
    debug(Yes)<<"adding root to output\n";
    output->insert(root);
  }




  if(!depth){
    debug(Yes)<<"0 depth remaining, returning from forwardDfs\n";
    return output;
  }

  debug(Yes)<<"non-zero depth, go to children...\n";

  vector<SVFGNode*> children = nextNodes(root,depth);
  for(auto child : children) {
    debug(Yes)<<"Giving Child depth val: "<<depth<<"\n";
    int childDepth = depth;


    set<SVFGNode*> *childOutput = dfs_rec_limit(child, nextNodes, condition, visited, childDepth, NULL , trackLoops);
    if(childOutput)
      output->insert(childOutput->begin(), childOutput->end());
 }
  if(dpData)
    (*dpData)[root] = output;

  return output;
}

set<Value*> *AnnotateNew::dfs_rec(Value* root, std::function<vector<Value*> (Value*)> nextNodes, std::function<bool (Value *)> condition, set<Value *> &visited, map<Value *, set<Value *>* > *dpData, bool trackLoops) {
  dpData = NULL; //FIXME
  if(visited.find(root) != visited.end()) {
    if(dpData) {
      assert(dpData->find(root) != dpData->end());
      return (*dpData)[root];
    }
    return NULL;
  }

  visited.insert(root);
  if(dpData && dpData->find(root) != dpData->end()) {
    debug(Yes) << "Found in dp: " << *root << "\n";
    set<Value *> *temp = dpData->find(root)->second;
    return temp;
  }

  if(trackLoops)
    checkIfLoop(root);

  trackStats(root);
  set<Value *> *output = new set<Value *>;

  if(condition(root)) {
    output->insert(root);
  }

  vector<Value *> children = nextNodes(root);
  for(auto child : children) {
    set<Value *> *childOutput = dfs_rec(child, nextNodes, condition, visited, dpData, trackLoops);
    if(childOutput)
      output->insert(childOutput->begin(), childOutput->end());
   }
  if(dpData)
    (*dpData)[root] = output;

  return output;
}

bool isInLoop(Value* value) {
  return false;
}
//function SVFGNode*, vector<SVFGNode *> -> void
template <typename T>
void dfs(T root, std::function<vector<T> (T)> nextNodes, std::function<bool (T)> condition, set<T> &output) {
  vector<T> worklist;
  worklist.push_back(root);

  set<T> visited;

  while(worklist.size()) {
    auto currentNode = worklist.back();
    worklist.pop_back();
    if(visited.find(currentNode) != visited.end())
      continue;

    visited.insert(currentNode);

    if(condition(currentNode)) {
      output.insert(currentNode);
    }

    vector<T> children = nextNodes(currentNode);
    debug(Yes) << "Parent:  " << *root << "\n";
    for(auto child : children) {
      debug(Yes) << "Child : " << *child << "\n";
      worklist.push_back(child);
      //if(auto casted = dyn_cast<StmtSVFGNode>(child))
      //if(casted->getInst())
      //debug(Yes) << "Instruction :" << *casted->getInst() << "\n";
    }
  }
}

vector<SVFGNode*> AnnotateNew::forwardDfsLambda(SVFGNode *current) {
  vector<SVFGNode*> worklist;
  if(forwardDp.find(current) !=forwardDp.end())
    return worklist;

  forwardDp.insert(current);
  for(auto it = current->OutEdgeBegin(), end = current->OutEdgeEnd(); it != end; it++) {
    worklist.push_back((*it)->getDstNode());
  }
  debug(Yes)<<"forwardDfsLambda with return size: "<<worklist.size()<<"\n";
  return worklist;
}

vector<SVFGNode*> AnnotateNew::forwardDfsLambdaLimited(SVFGNode *current) {
  debug(Yes)<<"forwardDfsLambdaLimited invoked\n";
  vector<SVFGNode*> worklist;
  if(forwardDp.find(current) !=forwardDp.end())
    return worklist;


  if(auto rootStmt = dyn_cast<StmtSVFGNode>(current)){
    auto* inst = rootStmt->getInst();
    if(inst == NULL){//Function argument?
      debug(Yes)<<"Roots value is null\n";
    } else {
      debug(Yes)<<"Root's function is "<<inst->getParent()->getParent()->getName()<<"\n";
      debug(Yes)<<"Inst: "<<*inst<<"\n";
      auto* F = inst->getParent()->getParent();
      if(depthFunctions.find(F) == depthFunctions.end()){
        debug(Yes)<<"In function not in CallGraph depth\n";
        return worklist;
      }
    }

  } else if(auto phi = dyn_cast<InterPHISVFGNode>(current)){
    if(auto* ARG = dyn_cast<Argument>(phi->getRes()->getValue())){
      auto* F = ARG->getParent();
      if(depthFunctions.find(F) == depthFunctions.end()){
        debug(Yes)<<"In function not in CallGraph\n";
        return worklist;
      }
      debug(Yes)<<"CallGraph Function: "<<ARG->getParent()->getName()<<"\n";
    }
  } else if(auto in = dyn_cast<FormalINSVFGNode>(current)){
    auto* F = in->getFun()->getLLVMFun();
    if(depthFunctions.find(F) == depthFunctions.end()){
      debug(Yes)<<"In function not in CallGraph depth\n";
      return worklist;
    }
    debug(Yes)<<"FormalINSVFGNode for function: "<<in->getFun()->getName()<<"\n";
  }

  forwardDp.insert(current);
  for(auto it = current->OutEdgeBegin(), end = current->OutEdgeEnd(); it != end; it++) {
    debug(Yes)<<"Inserting outgoing child!\n";
    worklist.push_back((*it)->getDstNode());
  }
  debug(Yes)<<"Returning with children of size "<<worklist.size()<<"\n";
  return worklist;
}


vector<SVFGNode*> AnnotateNew::forwardLimitedDfsLambda(SVFGNode *current, int depth) {
  vector<SVFGNode*> worklist;
  if(forwardDepthDp.find(current) !=forwardDepthDp.end()){
    DfsDepthInfo* info = forwardDepthDp[current];

    if(depth <= info->depth) // Already dfs with higher depth remaining
      return worklist;
    else 
      delete info;
  }

  forwardDepthDp[current] = new DfsDepthInfo(current, depth);

  for(auto it = current->OutEdgeBegin(), end = current->OutEdgeEnd(); it != end; it++) {
    worklist.push_back((*it)->getDstNode());
  }
  debug(Yes)<<"forwardLimitedDfsLambda with return size: "<<worklist.size()<<"\n";
  return worklist;
}




vector<SVFGNode*> backwardDfsLambdaDp(SVFGNode *current) {
  vector<SVFGNode*> worklist;
  if(backwardDp.find(current) != backwardDp.end())
    return worklist;

  backwardDp.insert(current);

  /*
     if(LoadsOnSource.find(current) == LoadsOnSource.end()){
     if(LoadSVFGNode* LI = dyn_cast<LoadSVFGNode>(current)){
     LoadsOnSource[current] = 0;
     } else {
     LoadsOnSource[current] = 1;
     }
     }*/
  //updateLoadsOnSource(current);

  //dfsLoads(current);


  for(auto it = current->InEdgeBegin(), end = current->InEdgeEnd(); it != end; it++) {

    SVFGNode* pred = (*it)->getSrcNode();
    //updateLoadsOnSource(pred);


    worklist.push_back((*it)->getSrcNode());
  }
  debug(Yes) << "Node: " << current << " Size: " <<  worklist.size() << "\n";
  return worklist;
}

vector<SVFGNode*> backwardDfsLambda(SVFGNode *current) {
  vector<SVFGNode*> worklist;
  for(auto it = current->InEdgeBegin(), end = current->InEdgeEnd(); it != end; it++) {
    worklist.push_back((*it)->getSrcNode());
  }
  debug(Yes) << "Node: " << current << " Size: " <<  worklist.size() << "\n";
  return worklist;
}

bool allTrueCondition(SVFGNode *) {
  return true;
}

vector<Value*> AnnotateNew::genericScalarDfs(Value *current) {
  vector<Value *> worklist;
  if(slpLoadDp.find(current) != slpLoadDp.end())
    return worklist;

  slpLoadDp.insert(current);

  for(auto &use: current->uses()) {
    auto user = use.getUser();
    debug(Yes) << "User : " << *user << "\n";
    worklist.push_back(user);
  }
  return worklist;
};

vector<Value*> AnnotateNew::genericScalarDfsBackward(Value *current) {
  vector<Value *> worklist;
  if(!dyn_cast<User>(current))
    return worklist;

  User *user = dyn_cast<User>(current);
  for(unsigned i = 0; i < user->getNumOperands(); i++) {
    if(dyn_cast<Constant>(user->getOperand(i)))
      continue;
    worklist.push_back(user->getOperand(i));
  }
  return worklist;
};

bool supportedInst(Value *v) {
  if(dyn_cast<AllocaInst>(v) || dyn_cast<PHINode>(v) || dyn_cast<StoreInst>(v) || dyn_cast<LoadInst>(v) || dyn_cast<GetElementPtrInst>(v) || dyn_cast<BitCastInst>(v) || dyn_cast<GlobalValue>(v) || dyn_cast<SelectInst>(v) || dyn_cast<SwitchInst>(v) || dyn_cast<ReturnInst>(v) || dyn_cast<CmpInst>(v) || dyn_cast<BranchInst>(v) || dyn_cast<BinaryOperator>(v) || dyn_cast<CallInst>(v))
    return true;
  debug(Yes) << "Unsupported inst :" << *v << "\n";
  return false;
}

struct dfsInfo {
  char color;
  int distance;
  char type;
  BasicBlock *parent;
};

PHINode* getLoopInductionVariable(Loop *L, ScalarEvolution *SE) {
  PHINode *InnerIndexVar = L->getCanonicalInductionVariable();
  if (InnerIndexVar)
    return InnerIndexVar;
  if (L->getLoopLatch() == nullptr || L->getLoopPredecessor() == nullptr) {
    return nullptr;
  }
  for (BasicBlock::iterator I = L->getHeader()->begin(); isa<PHINode>(I); ++I) {
    PHINode *PhiVar = cast<PHINode>(I);
    Type *PhiTy = PhiVar->getType();
    if (!PhiTy->isIntegerTy() && !PhiTy->isFloatingPointTy() &&
        !PhiTy->isPointerTy())
      return nullptr;
    const SCEVAddRecExpr *AddRec =
      dyn_cast<SCEVAddRecExpr>(SE->getSCEV(PhiVar));
    if (!AddRec || !AddRec->isAffine())
      continue;
    const SCEV *Step = AddRec->getStepRecurrence(*SE);
    debug(Yes) << !isa<SCEVConstant>(Step) << "\n";
    if (!isa<SCEVConstant>(Step))
      continue;
    return PhiVar;
  }
  return nullptr;
}

void AnnotateNew::getSlpScalarStores(set<const Value*> slps, set<Value *>& scalars, set<Value *> stores) {
  for(auto &slp: slps)
    getSlpStores(slps, stores);

  for(auto &scalar: scalars) {
    getScalarStores(scalar, stores);
  }
}

void AnnotateNew::classifyValAndOperands(Value *value, set<SVFGNode *> &backwardPtr, set<const Value *> &slps, set<Value*> &scalars) { 
  User *user = dyn_cast<User>(value); 
  classifyVal(value, backwardPtr, slps, scalars);
  if(user)
    for(unsigned i = 0; i < user->getNumOperands(); i++)
      classifyVal(user->getOperand(i), backwardPtr, slps, scalars); 
}

void AnnotateNew::getLoopBbs(Module *M) {

  unsigned i = 0;
  for(auto &F: *M) {
    if(F.isDeclaration())
      continue;
    LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(F).getLoopInfo();
    set<Loop *> loops;
    auto getNestedLoops = [&](Loop *L) {
      vector<Loop *> worklist;
      worklist.push_back(L);
      while(worklist.size()) {
        Loop *L = worklist.back();
        worklist.pop_back();
        loops.insert(L);
        for(auto it = L->begin(), end = L->end(); it != end; it++) {
          worklist.push_back(*it); 
        }
      }
    };

    for(auto it = LI.begin(), end = LI.end(); it != end; it++) {
      Loop *L = *it;
      getNestedLoops(L); 
    }

    for(auto &L: loops) {
      debug(Yes) << L->getHeader()->getName() << "\n";
      for(auto BB: L->getBlocks()) {
        loopHeaders[BB] = LI.getLoopFor(BB)->getHeader(); //get header for inner most loop
      }
      i++;
    }
  }

  debug(Yes) << "TOTAL LOOPS: " << i << "\n";
}

void AnnotateNew::getLoopIterators(const BasicBlock *BB, set<const Value *> &trackedAllocas) {


  set<SVFGNode*> backwardPtr;
  set<Value *> scalars; //scalars
  set<const Value *> slps;
  vector<const SVFGNode *> worklistSvfg;

  Function *F = (Function *)BB->getParent();
  TargetLibraryInfo *TLI = &getAnalysis<TargetLibraryInfoWrapperPass>().getTLI(*F);

  AssumptionCache &AC = getAnalysis<AssumptionCacheTracker>(*F).getAssumptionCache(*F);
  DominatorTree * DT = new DominatorTree(*F);
  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*F).getLoopInfo();
  Loop *L = LI.getLoopFor(BB);

  ScalarEvolution SE(*F, *TLI, AC, *DT, LI);
 if(auto phi = getLoopInductionVariable(L, &SE)) {
    for(unsigned i = 0; i < phi->getNumIncomingValues(); i++) {
      set<Value *> possible;
      Value *current = phi->getIncomingValue(i);

      if(dyn_cast<Constant>(current))
        continue;

      if(!current->getType()->isPointerTy()) {
        set<Value *> processed;
        set<Value *> *vals = dfs_rec(current, genericScalarDfsBackward, isLoad, processed, &isLoadDp);
        for(auto val: *vals)
          possible.insert(val);
      } else {
        possible.insert(current);
      }

      for(auto &V: possible) {
        debug(Yes) << "Loop: adding : " << *V << "\n";
        SVFGNode* svfgNode;
        if(V->getType()->isPointerTy())
          svfgNode = getSvfgNode(V);     
        else
          svfgNode = getSvfgNode(dyn_cast<LoadInst>(V)->getPointerOperand());
        backwardPtr.insert(svfgNode);
      }
    }
  } else {
    for(auto BB: L->getBlocks())
      for(auto &I: *BB){
        debug(Yes) << "loop value :" << I << "\n";
        classifyValAndOperands(&I, backwardPtr, slps, scalars); 
      }
  }

  set<Value*> stores;
  set<SVFGNode*> storeSvfg;

  getSlpScalarStores(slps, scalars, stores);
  getStoreSvfg(stores, backwardPtr);
  getSourceAllocas(backwardPtr,worklistSvfg, trackedAllocas);
}

void AnnotateNew::getBranchAndArgcInstructions(set<BranchInst*> &branches, set<CallInst*> &calls, set<Instruction*> &argcValues) {

  for(auto &F: *module) {
    if(F.isDeclaration())
      continue; 

    for(auto &BB: F) {
      for(auto &I: BB) {

        if(I.getMetadata("track_argc")) {
          debug(Yes) <<"argc value :" << I << "\n";
          argcValues.insert(&I);
        }

        if(auto branch = dyn_cast<BranchInst>(&I))
          branches.insert(branch);

        if(auto callInst = dyn_cast<CallInst>(&I)) {
          if(callInst->getCalledFunction() && callInst->getCalledFunction()->isDeclaration())
            calls.insert(callInst);
        }
      }
    }
  }
}

bool AnnotateNew::isLoad(Value *V) {
  return dyn_cast<LoadInst>(V);
}

void AnnotateNew::getTaintedBranches(set<BranchInst *> &trackedBranches, map<Value *, set<Value *> > &branchDp, set<const Value*>& trackedAllocas) {

  for(auto it = branchDp.begin(), end = branchDp.end(); it != end; it++) {
    debug(Yes)<<"BRANCHDP exists!!!\n";
    Value *current = it->first;
    set<Value *> &values = it->second;

    for(auto alloca: trackedAllocas) {
      if (values.find((Value *)alloca) != values.end()) {
        trackedBranches.insert(dyn_cast<BranchInst>(current));
        break;
      }
    }
  }

  return;
 
}


/*
 * Traverse SVFG chain, and get all nodes into which the current node's data flows,
 * e.g. through store, memcpy
 */
void AnnotateNew::getMemoryFlow(const SVFGNode *current, set<const Value *> &singleLevelPointers, set<SVFGNode*> &storeSvfg, set<CallInst*> &calls) {
  //capture single level pointers as well as condition to capture output

  static set<const Value *> slps;
  //[Point to add CFG depth condition]
  auto forwardDfsCondition = [&](SVFGNode* node) {
   
    const Value *inst = NULL;
    if(auto temp = dyn_cast<InterPHISVFGNode>(node)) {
      debug(Yes) << *temp->getRes()->getValue() << " phinode\n";
      inst = temp->getRes()->getValue();
      debug(Yes)<<"\nPHINode inst: "<<*inst<<"\n";
      if(auto* ARG= dyn_cast<Argument>(inst)){
        debug(Yes)<<"ArgParent: "<<ARG->getParent()->getName()<<"\n";
      }
      //debug(Yes)<<"ParentFunc:"<<inst->getParent()->getParent()->getName()<<"\n";
      auto pagNode = pag->getPAGNode(pag->getValueNode(inst));
      auto svfgNode = svfg->getDefSVFGNode(pagNode);
      //return true;
    } 
    auto casted = dyn_cast<StmtSVFGNode>(node);
    if(casted) {
        if(casted->getInst()) {
        debug(Yes) << "Going forward on Instruction: " << *casted->getInst() << " in function " << casted->getInst()->getParent()->getParent()->getName() << "\n";
        inst = casted->getInst(); 
      }
    }
    if(inst) {
      if(auto point = dyn_cast<PointerType>(inst->getType())) {
        if(!point->getElementType()->isPointerTy()) { // Only a single level pointer
          if(slps.find(inst) == slps.end()) {
            singleLevelPointers.insert(inst);
            slps.insert(inst);
          }
        }

        //check if involved in any strcpy or strncpy
        //TODO this is a hack, and can be imporved by checking formalin at any callsite
        for(auto &call: calls) {
          bool found = false;
          for(unsigned i = 0; i < call->getNumOperands(); i++) { 
            if(call->getOperand(i) == inst) {
              //return true;
              debug(Yes) << "call found\n" << " " << *call << "\n";
              found = true;
            }
          }
          if(found) { // CallInst operand is inst to be used
            debug(Yes)<<"call with found true: "<<*call<<"\n";
            for(unsigned i = 0; i < call->getNumOperands(); i++) {
              if(!call->getOperand(i)->getType()->isPointerTy())
                continue;
              debug(Yes)<<"Adding to storeSet "<<*call->getOperand(i)<<"\n";
              auto *pagNode = pag->getPAGNode((pag->getValueNode(call->getOperand(i)))); // [Q] Tracking all pointer operands???
              storeSvfg.insert((SVFGNode*) svfg->getDefSVFGNode(pagNode)); //[Q] InterProceduralFlow limiting? (Within same function. Is it valid?
              //If original flow is considered then this should also?
            }
            if(call->getType()->isPointerTy()) {
              auto *pagNode = pag->getPAGNode((pag->getValueNode(call)));
              storeSvfg.insert((SVFGNode*)svfg->getDefSVFGNode(pagNode));
              //calls.erase(call);

            }

          }
        }
      }
    }
    if(casted) {
      auto pagEdge = casted->getPAGEdge();
      if(dyn_cast<StorePE>(pagEdge) && casted->getInst())
        return true;

      if(casted->getInst())
        if(isMemTransfer(casted->getInst()))
          return true;

      if(casted->getInst() && dyn_cast<BranchInst>(casted->getInst())) {
        assert(false); //TODO remove?
      }
    }
    return false;
  };



  auto forwardLimitedDfsCondition = [&](SVFGNode* node) {
   
    const Value *inst = NULL;
    if(auto temp = dyn_cast<InterPHISVFGNode>(node)) {
      debug(Yes) << *temp->getRes()->getValue() << " phinode\n";
      inst = temp->getRes()->getValue();
      debug(Yes)<<"\nPHINode inst: "<<*inst<<"\n";
      if(auto* ARG= dyn_cast<Argument>(inst)){
        debug(Yes)<<"ArgParent: "<<ARG->getParent()->getName()<<"\n";
        if(depthFunctions.find(ARG->getParent()) == depthFunctions.end()){
          debug(Yes)<<"ARG Parent not in depthFunctions, returning...\n";
          return false;
        }
      }
      auto pagNode = pag->getPAGNode(pag->getValueNode(inst));
      auto svfgNode = svfg->getDefSVFGNode(pagNode);
    } 
    auto casted = dyn_cast<StmtSVFGNode>(node);
    if(casted) {
     
      if(casted->getInst()) {
        inst = casted->getInst(); 
      }
    }
    if(inst) {

      if(auto* instruct = dyn_cast<Instruction>(inst)){
        auto* F = instruct->getParent()->getParent();
        if(F && depthFunctions.find(((Instruction*)inst)->getParent()->getParent()) == depthFunctions.end()){
          debug(Yes)<<"[DepthFu] ARG Parent not in depthFunctions, returning...\n";
          return false;
        }

      }


      if(auto point = dyn_cast<PointerType>(inst->getType())) {
        if(!point->getElementType()->isPointerTy()) { // Only a single level pointer
          if(slps.find(inst) == slps.end()) {
            singleLevelPointers.insert(inst);
            slps.insert(inst);
          }
        }

        //check if involved in any strcpy or strncpy
        //TODO this is a hack, and can be imporved by checking formalin at any callsite
        for(auto &call: calls) {
          bool found = false;
          for(unsigned i = 0; i < call->getNumOperands(); i++) { 
            if(call->getOperand(i) == inst) {
              //return true;
              debug(Yes) << "call found\n" << " " << *call << "\n";
              found = true;
            }
          }
          if(found) { // CallInst operand is inst to be used
            debug(Yes)<<"call with found true: "<<*call<<"\n";
            for(unsigned i = 0; i < call->getNumOperands(); i++) {
              if(!call->getOperand(i)->getType()->isPointerTy())
                continue;
              debug(Yes)<<"Adding to storeSet "<<*call->getOperand(i)<<"\n";
              auto *pagNode = pag->getPAGNode((pag->getValueNode(call->getOperand(i)))); // [Q] Tracking all pointer operands???
              storeSvfg.insert((SVFGNode*) svfg->getDefSVFGNode(pagNode)); //[Q] InterProceduralFlow limiting? (Within same function. Is it valid?
              //If original flow is considered then this should also?
            }
            if(call->getType()->isPointerTy()) {
              auto *pagNode = pag->getPAGNode((pag->getValueNode(call)));
              storeSvfg.insert((SVFGNode*)svfg->getDefSVFGNode(pagNode));
              //calls.erase(call);

            }

          }
        }
      }
    }
    if(casted) {
      auto pagEdge = casted->getPAGEdge();
      if(dyn_cast<StorePE>(pagEdge) && casted->getInst())
        return true;

      if(casted->getInst())
        if(isMemTransfer(casted->getInst()))
          return true;

      if(casted->getInst() && dyn_cast<BranchInst>(casted->getInst())) {
        assert(false); //TODO remove?
      }
    }
    return false;
  };





  //go forward 
  set<SVFGNode *> visited;
  set<SVFGNode *> * data;
  if(isLimitedDepth){
    debug(Yes)<<"[LIMITED CHECK]"<<"\n";
    data = dfs_rec_limit((SVFGNode*)current, forwardLimitedDfsLambda, forwardDfsCondition, visited,depthLimit+1, NULL, true);
    //data = dfs_rec((SVFGNode*)current, forwardDfsLambdaLimited, forwardLimitedDfsCondition, visited, NULL, true);

  } else {
    data = dfs_rec((SVFGNode*)current, forwardDfsLambda, forwardDfsCondition, visited, NULL, true);
  }
  debug(Yes)<<"FINISHED FORWARD DFS\n";


  for(auto &node: *data) {
    storeSvfg.insert(node);
  }
}

GlobalValue *pointsToGlobal(const User *user) {
  if(!user)
    return NULL;

  for(int i = 0; i < user->getNumOperands(); i++) {
    auto current = user->getOperand(i);
    if(auto global = dyn_cast<GlobalVariable>(current)) {
      return global;
    }
  }
  return NULL;
}


void AnnotateNew::getSourceAllocas(set<SVFGNode*> &svfgNodes, vector<const SVFGNode*> &worklistSvfg, set<const Value*> &trackedAllocas, bool trackLoops, bool dpMem) {

  auto backwardDfsCondition = [&](SVFGNode* node) {
    if(auto casted = dyn_cast<StmtSVFGNode>(node)) {
      auto pagEdge = casted->getPAGEdge();
      if(pagEdge->getInst()) {

        //debug(Yes) << "In backward " << *pagEdge->getInst() << "\n";
        auto I = pagEdge->getInst();
        string fname = "";

        if(dyn_cast<ReturnInst>(I)) {
          Function *parent = (Function *) I->getParent()->getParent(); 
          parent->addFnAttr("track_func", "true");
          debug(Yes) << "track_func added to function " << parent->getName() << "\n";
        }

        if(I->getParent() && I->getParent()->getParent())
          fname = I->getParent()->getParent()->getName();

        debug(Yes) << "Going backward on : " << *pagEdge->getInst() << " Node: " << node  << " Function: " << fname << "\n";
        if(dyn_cast<AllocaInst>(pagEdge->getInst()))
          return true;

        for(unsigned i = 0; i < I->getNumOperands(); i++) {
          GlobalValue* global = dyn_cast<GlobalVariable>(I->getOperand(i));
          if(global || (global = pointsToGlobal(dyn_cast<User>(I->getOperand(i))))) {
            debug(Yes) << "GLOBAL: " << *global << dyn_cast<StmtSVFGNode>(getSvfgNode(global)) << "\n";
            worklistSvfg.push_back(getSvfgNode(global));
            trackedAllocas.insert(global); // hackish
          }
        }

        //FIXME Use MemObj instead of pointer hack
        if(auto user = dyn_cast<User>(pagEdge->getInst())){
          if(auto global = pointsToGlobal(user)) {
            return true; 
          }
        }

        if(auto call = dyn_cast<CallInst>(pagEdge->getInst())) {
          if (call->getCalledFunction()->getName() == "malloc" || call->getCalledFunction()->getName() == "calloc" || call->getCalledFunction()->isDeclaration()) {
            debug(Yes) << "is external call " << *call->getCalledFunction() << "\n";
            return true;
          }
        }
      }
    } else if(dyn_cast<MRSVFGNode>(node)) {
      debug(Yes) << "TESTINGGG";
    }
    return false;
  };

  for(auto it = svfgNodes.begin(), end = svfgNodes.end(); it != end; it++) {
    auto temp = dyn_cast<StmtSVFGNode>(*it);
    if(!temp)
      continue;
    set<SVFGNode*>* data = NULL;
    set<SVFGNode*> visited;
    if(temp->getInst()) {
      debug(Yes) << "Backward dp size:" << backwardDp.size() << "\n";
      if(dpMem)
        data = dfs_rec(*it, backwardDfsLambdaDp, backwardDfsCondition, visited, &backwardDp, trackLoops);
      else
        data = dfs_rec(*it, backwardDfsLambda, backwardDfsCondition, visited, &backwardDp, trackLoops);
      debug(Yes) << "Data: " << data << "\n";
    }

    if(!data)
      continue;

    debug(Yes) << data->size() << "size\n";
    for(auto val: *data) { 
      Instruction *current = (Instruction*)dyn_cast<StmtSVFGNode>(val)->getPAGEdge()->getInst(); 
      debug(Yes) << *current << " here\n"; 
      //debug(Yes) << "ALLOCAAA : " << *current << "\n";
      if(auto global = pointsToGlobal(dyn_cast<User>(current))) {
        trackedAllocas.insert(global);
        worklistSvfg.push_back(getSvfgNode(global));
      } else {
        worklistSvfg.push_back(val);
        trackedAllocas.insert(current);
      }
    }

     }
}

/**
 * Get non pointer uses of a scalar
 * Currently only getting Stores
 */
void AnnotateNew::getScalarStores(Value *scalar, set<Value*>& stores) {
  vector<Value *> worklist;
  worklist.push_back(scalar);
  //traverse use chain of load and get any getElementPtr or stores
  assert(!scalar->getType()->isPointerTy());
  debug(Yes) << *scalar << " getting uses of scalar \n";
  static set<Value*> processed;
  while(worklist.size()) {
    Value *current = worklist.back();
    worklist.pop_back();
    if(processed.find(current) != processed.end())
      continue;
    processed.insert(current);

    if(dyn_cast<Constant>(current)) {
      continue;
    }
    //debug(Yes) << "Use: " << *current << "\n";
    for(auto &use: current->uses()) {
      auto user = use.getUser();
      //debug(Yes) << "User: " << *user << "\n";
      //debug(Yes) << 
      if(isMemTransfer(user)) {
        debug(Yes) << "STOREEEE: " << *user << "\n";
        stores.insert(user);
      }

      //TODO can we skip this? Since if a scalar has a memory value,
      //there must always be a load in it's chain, making this gep redundant?
      //Can there be a gep in its chain without a load?
      //if(dyn_cast<GetElementPtrInst>(user))
      //stores.insert(user);
      //assert(false);

      worklist.push_back(user);
    }
  }
}

/**
 * If memory found, add to track set
 */
void trackIfMemory(const SVFGNode* current, set<const Value*> &trackedAllocas) {
  if(auto casted = dyn_cast<StmtSVFGNode>(current)) {
    if(casted->getInst()) {
      auto inst = casted->getInst();
      //TODO remove this debug statement
      //debug(Yes) << "Going forward on Instruction : " << *inst << " in function " <<  inst->getParent()->getParent()->getName() << "\n";

      if(dyn_cast<AllocaInst>(casted->getInst()) || dyn_cast<GlobalValue>(casted->getInst()))
        trackedAllocas.insert(casted->getInst());

      if(auto temp = dyn_cast<CallInst>(casted->getInst()))
        if (temp->getCalledFunction()->getName() == "malloc" || temp->getCalledFunction()->getName() == "calloc")
          trackedAllocas.insert(temp);
    }
  } else {
    debug(Yes)<<"TrackIfMemory: source node is not stmt\n";

  }
}

SVFGNode *AnnotateNew::getSvfgNode(const Value *V) {
  debug(Yes)<<"Const Value: "<<*V<<"\n";
  auto valNode = pag->getValueNode(V);
  debug(Yes)<<"ValNode: "<<valNode<<"\n";

  auto pagNode = pag->getPAGNode(pag->getValueNode(V));
  return (SVFGNode*)svfg->getDefSVFGNode(pagNode);
}


void AnnotateNew::getStoreSvfg(set<Value*> &stores, set<SVFGNode*> &storeSvfg) {
  for(auto &value: stores) {
    if(!isMemTransfer(value))
      assert("Must be a memory transfer value" && false);

    Value *val = dyn_cast<User>(value)->getOperand(1);

    val = val->stripPointerCasts();

    storeSvfg.insert(getSvfgNode(val));
  }
}

void getBbsTillJoin(BasicBlock *join, set<BasicBlock*>& markedBBs, BranchInst *I) {
  for(int i = 0; i < I->getNumSuccessors(); i++) {
     bool found = false; 
     //do dfs until found the join node, and get all BBs in the path
    auto lambdaCondition = [&](BasicBlock *temp) {
      if(temp == join)
        found = true;

      return !found;
    };

    auto forwardBBDfs = [](BasicBlock *current) {
      vector<BasicBlock*> children;
      auto terminator = current->getTerminator();
      for(int i = 0; i < terminator->getNumSuccessors(); i++) {
        children.push_back(terminator->getSuccessor(i));
      }
      return children;
    };

    dfs<BasicBlock*>(I->getSuccessor(i), forwardBBDfs, lambdaCondition, markedBBs);
  }
}

void AnnotateNew::getLoadsOnSlps(Value* pointer, set<Value*> &singleLevelLoads) {
  //get non pointer data to track
  static set<Value *> processed;

  auto isLoadOnSingleLevelPointer = [&](Value *current) {
    processed.insert(current);
    if(dyn_cast<LoadInst>(current))
      if(auto temp = dyn_cast<PointerType>(dyn_cast<User>(current)->getOperand(0)->getType()))
        return !current->getType()->isPointerTy(); 
    if(auto call = dyn_cast<CallInst>(current))
      return !call->getType()->isPointerTy();
    return false;
  };

  if(processed.find(pointer) != processed.end()) {
    debug(Yes) << "Already processed: " << *pointer << "\n";
    return;
  }

  processed.insert(pointer);
  set<Value*> visited;
  set<Value *> *data = dfs_rec((Value*)pointer, genericScalarDfs, isLoadOnSingleLevelPointer, visited, NULL, true); //get all loads of single level pointer 
  for(auto &value: *data) {
    singleLevelLoads.insert(value);
  }
}

void AnnotateNew::classifyVal(Value *value, set<SVFGNode*>& backwardPtr, set<const Value *> &singleLevelPointers, set<Value*>& scalar) {
  //debug(Yes) << "Classifying :" << *value << "\n";
  if(value->getType()->isPointerTy() && supportedInst(value)) {
    auto pagNode = pag->getPAGNode(pag->getValueNode(value));
    auto svfgNode = svfg->getDefSVFGNode(pagNode);

    //for any pointer, track back to its alloc/malloc
    backwardPtr.insert((SVFGNode*)svfgNode);
    if(!dyn_cast<PointerType>(value->getType())->getElementType()->isPointerTy()) { //single level pointer
      singleLevelPointers.insert(value);
    }
  } else if(!value->getType()->isPointerTy() && !dyn_cast<Constant>(value)) {
    //get any stores later on these scalars 
    scalar.insert(value);
  } else {
    debug(Yes) << "Unable to classify " << *value << "\n";
  }
}

void AnnotateNew::getBranchMemory(set<BranchInst *> &allBranches, map<Value *, set<Value *> > &dp, set<BranchInst*>& argcBranches) {

  debug(Yes) << "Total Branches = " << allBranches.size() << "\n";
  int i = 0;
  for(auto branchInst: allBranches) {
    if(branchInst->isUnconditional())
      continue;

    //TODO ?
    CmpInst *condition = dyn_cast<CmpInst>(branchInst->getCondition());
    if(!condition)
      continue;

    //perform dfs backwards on each value of the branch condition
    bool found = false;

    debug(Yes) << "Processing branch :" << i << "\n"; 
    i++;

    set<const Value *> allocs;
    vector<const SVFGNode*> worklistSvfg;
    for(int i = 0; i < condition->getNumOperands(); i++) {
     Value *current = condition->getOperand(i);
      //checkeing separately for condition just because it's easier to do so here :/
      if(dyn_cast<Instruction>(condition)->getMetadata("track_argc")) {
        argcBranches.insert(branchInst);
        break;
      }

      set<Value *> pointers;

      bool isArgcBranch = false;

      //lambda sets is argc branch
      auto isLoadOrArgc = [&](Value *value) {
        if(auto inst = dyn_cast<Instruction>(value)) {
          if(inst->getMetadata("track_argc")) {
            isArgcBranch = true;
            return true;
          }
        }
        return isLoad(value);
      };

      if(!current->getType()->isPointerTy()) {
        set<Value *> visited;
        set<Value*> *data = dfs_rec(current, genericScalarDfsBackward, isLoadOrArgc, visited, &isLoadOrArgcDp, false);
        for(auto d: *data)
          pointers.insert(d);
      } else if(supportedInst(current)) {
        pointers.insert(current);
      }

      if(isArgcBranch) {
        argcBranches.insert(branchInst);
        found = true;
        break;
      }
      //go back to tap into any possible SVFG node.
      //Due to mem2reg, we might have direct register values instead of allocas
      //e.g. if(a == 1) x = 2; else x = 3; Need to handle that

      if(!pointers.size())
        continue;
      //set<SVFGNode*> poss;

      //condition for when a branch instruction is of our use.
      //FIXME uses allocs directly
      set<SVFGNode*> svfgNodes;
      //track back to alloca
      for(auto value: pointers) {
        const PAGNode* pagNode;
        //single level loads
        if(auto load = dyn_cast<LoadInst>(value))
          if(!value->getType()->isPointerTy())
            value = load->getPointerOperand();

        //debug(Yes) << *value << "\n";
        pagNode = pag->getPAGNode(pag->getValueNode(value));
        auto svfgNode = svfg->getDefSVFGNode(pagNode);
        svfgNodes.insert((SVFGNode*)svfgNode);
      }

      getSourceAllocas(svfgNodes, worklistSvfg, allocs, false, false);

    }

    for(auto &a: worklistSvfg)
      if(auto temp = dyn_cast<StmtSVFGNode>(a)) {
        if(temp->getInst()) {
          debug(Yes) << "Inserting branch: " << *temp->getInst() << "\n";
          allocs.insert((Value*)dyn_cast<StmtSVFGNode>(a)->getInst());
        }
      }
    for(auto &a: allocs) {
      dp[branchInst].insert((Value*)a);
    }
  }
}

void printAllAllocsMallocs(Module &M) {
  set<Value *> asd;
  for(auto &F: M) {
    for(auto &BB: F) {
      for(auto &I: BB) {
        if (dyn_cast<AllocaInst>(&I))
          asd.insert(&I);
        if (auto temp = dyn_cast<CallInst>(&I))
          if(temp->getCalledFunction() && (temp->getCalledFunction()->getName() == "malloc" || temp->getCalledFunction()->getName() == "calloc" || temp->getCalledFunction()->getName() == "xmalloc" || temp->getCalledFunction()->getName() == "xcalloc"))
            asd.insert(&I);
      }
    }
  }

  debug(Yes)<<"asd size allocs "<<asd.size()<<"\n";
  for(auto it = M.global_objects().begin(), end = M.global_objects().end(); it != end; it++)
    if(!dyn_cast<Function>(&*it))
      asd.insert(&*it);

  debug(Yes)<<"asd size total "<<asd.size()<<"\n";
  debug(Yes) << "Size : " << asd.size() << "\n";
  for(auto &I: asd) {
    debug(Yes) << *I << "\n";
  }
}

void AnnotateNew::getTrackedBranchBBs(BranchInst *I, set<BasicBlock *> &markedBBs, set<PHINode*> &phis, map<Function *, PostDominatorTree *> &postDoms) {

  PostDominatorTree *tree;
 
  tree = &getAnalysis<PostDominatorTreeWrapperPass>(*I->getParent()->getParent()).getPostDomTree();

  set<BasicBlock *> dominates;
  for(auto &BB: *I->getParent()->getParent()) {
    if(tree->properlyDominates(&BB, I->getParent())) {
      dominates.insert(&BB);
    }
  }

  BasicBlock *join= NULL;
  unsigned smallest = UINT_MAX;
  for(auto &BB: dominates) {
    auto node = tree->getNode(BB);
    if(node->getDFSNumOut() < smallest) {
      join = BB;
      smallest = node->getDFSNumOut();
    }
  }

  if(!join) {
    debug(Yes) << "Could not find join for branch " << *I << " in BB : " << *I->getParent() << "\n";
    //assert(false); //FIXME
    return;
  }

  debug(Yes) << "Join found for branch: " << *I << "\n";

  for(auto it = join->begin(); dyn_cast<PHINode>(&*it); it++)
    phis.insert(dyn_cast<PHINode>(&*it));

  getBbsTillJoin(join, markedBBs, I);
}

void markArgcUsers(Value *argc) {
  for(auto user: argc->users())
    if(auto inst = dyn_cast<Instruction>(user))
      inst->setMetadata("track_argc", MDNode::get(inst->getContext(), MDString::get(inst->getContext(), "1"))); 
}

/**
 * The algorithm works in following steps
 * 1) Forward DFS on the Static Value Flow graph to get all stores of tainted data (initially argv only)
 * 2) Backward DFS on the SVF to get all allocs/mallocs, adding them to tainted data
 * 3) Get any loads on single level pointers, e.g (int *a; *a += 1;),
 *    using llvm def use chains since they are not present in SVF graph.
 *    Add any corresponding stores to tainted data
 * 4) Get all branches depending on tainted data
 * 5) Add any Values, track any pointers backwards to Allocs/Mallocs in corresponding branches,
 *    and add them to the tainted data
 * 6) Repeat above steps untill no new tainted data
 */
void AnnotateNew::run(vector<Value*> sources, Value *argc, set<const Value*> &trackedAllocas) {

  //set<const Value *> singleLevelPointers; //store single level pointers

  //forward and backward dfs to get allocas/mallocs
  vector<const SVFGNode*> worklistSvfg;
  set<BranchInst*> allBranches;
  set<const Value*> singleLevelPointers;
  set<const SVFGNode *> processed;
  set<Instruction *> argcValues;
  set<CallInst *> calls;
  set<Loop*> loops;
  map<Function*, PostDominatorTree *> postDoms;
  map<Value *, set<Value *> > branchDp;

  for(auto &val: sources) {
    const PAGNode *pagNode = pag->getPAGNode((pag->getValueNode(val)));
    auto svfgNode = svfg->getDefSVFGNode(pagNode);
    worklistSvfg.push_back(svfgNode);
    trackedAllocas.insert(val);
  }

  // just for running tests
  if(argc && isTest) {
    markArgcUsers(argc);
    set<Value*> stores;
    set<SVFGNode*> storeSvfg;
    getScalarStores(argc, stores);
    getStoreSvfg(stores, storeSvfg);
    getSourceAllocas(storeSvfg, worklistSvfg, trackedAllocas);
  }

  {
    markArgcUsers(argc);
    set<SVFGNode*> svfgNodes;
    getBranchAndArgcInstructions(allBranches, calls, argcValues);
    //getSourceAllocas(svfgNodes, worklistSvfg, trackedAllocas);
  }

  getLoopBbs(module);

  {
    for(auto &I: argcValues) {
      set<Value*> stores;
      set<SVFGNode*> storeSvfg;
      debug(Yes) << *I << "\n";
      if(dyn_cast<StoreInst>(I)) {
        worklistSvfg.push_back(getSvfgNode(dyn_cast<User>(I)->getOperand(1)));
      } else if (I->getType()->isPointerTy()) {
        worklistSvfg.push_back(getSvfgNode(I));
      } else {
        //is a scalar value
        getScalarStores(argc, stores);
        getStoreSvfg(stores, storeSvfg);
        getSourceAllocas(storeSvfg, worklistSvfg, trackedAllocas);
      }
    }
  }

  set<BranchInst*> argcBranches;


  while(1) {
    while(worklistSvfg.size()) {
      const SVFGNode *current = worklistSvfg.back();
      worklistSvfg.pop_back();

      // Need to remove processed? (Depth changes so need multiple reprocessing") Only considering
      // Source allocas. Should stay
      if(processed.find(current) != processed.end())
        continue;

      debug(Yes) << "PROCESSING " << current << " Size: " << worklistSvfg.size() ;
      if(auto temp = dyn_cast<StmtSVFGNode>(current)) {
        if(temp->getInst()) {
          debug(Yes) << *temp->getInst();
          currentValue = (Value *) temp->getInst();
        } else {
          auto srcNode = temp->getPAGSrcNode();
          if(srcNode->hasValue()) {
            auto t = (srcNode->getValue()); 
            if(t)
              currentValue = (Value *)t;
            else 
              debug(Yes)<<"Source has no value associated with it...\n";
          }
        }
      } else {
        debug(Yes)<<"CURRENT IS NOT A STMT NODE...\n";
      }
      if(current != NULL){
        valToNode[currentValue] = current;
      }

      debug(Yes) << "\n";

      trackIfMemory(current, trackedAllocas);

      processed.insert(current);

      set<SVFGNode *> storeSvfg; 
      //traverse memory chain of this svfgnode, and get any stores 
      getMemoryFlow(current, singleLevelPointers, storeSvfg, calls);
      //go backward to get corresponding allocs/mallocs

      set<Value*> stores;
      getSlpStores(singleLevelPointers, stores); 
      currentValue = NULL;
      singleLevelPointers.clear();
      if(stores.size()) {
        getStoreSvfg(stores, storeSvfg);
        //continue;
      }
      getSourceAllocas(storeSvfg,worklistSvfg, trackedAllocas);
    }
    debug(Yes)<<"WorkList has ended...\n";


    //get all branch instructions touching tainted data
    set<BranchInst*> trackedBranches; 
    getTaintedBranches(trackedBranches, branchDp, trackedAllocas);

    //TODO this runs only for the first iteration really. Hacky. fix this
    if(argcBranches.size()) {
      debug(Yes)<<"HACKY argcBranches executes\n";
      trackedBranches.insert(argcBranches.begin(), argcBranches.end());
      argcBranches.clear();
    }

    debug(Yes) << "Tracked Branches size: " << trackedBranches.size() << "\n";
    if(!trackedBranches.size())
      break;
    else 
      debug(Yes)<<"Tracked branches non-empty...\n";

    for(auto branch: trackedBranches) {
      branchDp.erase(branch);
    }

    //get branch join BB
    //find join node in tracked branches and get BBs which are affected by these branch insts
    set<BasicBlock*> markedBBs;
    set<PHINode*> phis;
    for(auto &I: trackedBranches) {
      //BasicBlock *join = getJoinBb(I->getParent()); 
      getTrackedBranchBBs(I, markedBBs, phis, postDoms); 
    }

    /**
     * if markedbbs, do
     * 1) for any pointer, track back its allocs/mallocs
     * 2) for any single level pointer, traverse def use chain -> get stores/geps -> taint data
     * 4) Add any mallocs/allocs to tracked data
     * 5) handle phi nodes
     * 6) handle scalars
     */
    if(markedBBs.size()) {
      set<SVFGNode*> backwardPtr;
      set<Value *> scalars; //scalars
      set<const Value *> slps;

      for(auto &phi: phis) {
        debug(Yes) << "PHI " << *phi << "\n";
        classifyVal(phi, backwardPtr, slps, scalars);
        for(unsigned i = 0; i < phi->getNumIncomingValues(); i++) {
          Value *value = phi->getIncomingValue(i);
          debug(Yes) << "PHI " << *value << "\n";
          classifyVal(value, backwardPtr, slps, scalars);
        }
      }

      debug(Yes) << "Scalar size : " << scalars.size() << "\n";
      for(auto &BB: markedBBs) {
        for(auto &I: *BB) {
          //handle pointers
          if(dyn_cast<AllocaInst>(&I)) {
            trackedAllocas.insert(&I);
          } else if(auto temp = dyn_cast<CallInst>(&I)) {
            if(temp->getCalledFunction() && (temp->getCalledFunction()->getName() == "malloc" || temp->getCalledFunction()->getName() == "calloc" || temp->getCalledFunction()->getName() == "xmalloc" || temp->getCalledFunction()->getName() == "xcalloc"))
              trackedAllocas.insert(temp);
          } else {
            classifyValAndOperands(&I, backwardPtr, slps, scalars); 
          }
          debug(Yes) << "In branch : " << I << "\n";
        }
      }
      //getSourceAllocas(backwardPtr, worklistSvfg, trackedAllocas);
      set<Value*> stores;

      for(auto &slp: slps)
        getSlpStores(slps, stores);

      for(auto &scalar: scalars) {
        getScalarStores(scalar, stores);
      }

      getStoreSvfg(stores, backwardPtr);
      getSourceAllocas(backwardPtr,worklistSvfg, trackedAllocas);
    } else {
      break;
    } 
  }

  debug(Yes) << "Printing loops " << "\n";

  set<const BasicBlock *> processedLoops;
  Function *loopFunc = insertLoopFuncAnnot(module, "unroll_loop");
  debug(Yes)<<"markedLoops size: "<<markedLoops.size()<<"\n";
  for(auto &BB: markedLoops) {
    debug(Yes) << BB->getName() << "\n";
    if(processedLoops.find(BB) != processedLoops.end())
      continue;

    processedLoops.insert(BB);

  }

  debug(Yes) << "MARKED LOOPS: " << markedLoops.size() << "\n";
  for(auto &BB: markedLoops) {
    annotateLoop(BB, loopFunc, LOOP_ID);
    LOOP_ID++;
  }
}

void AnnotateNew::annotateLoop(const BasicBlock *BB, Function *F, unsigned loop_id) {
  llvm::IRBuilder<> builder((BasicBlock *) BB);

  builder.SetInsertPoint((Instruction *) BB->getFirstNonPHI());
  vector<Value *> args;
  args.push_back(builder.getInt32(loop_id));
  builder.CreateCall(F, args);
}

Function *AnnotateNew::insertLoopFuncAnnot(Module *M, const string &name) {
  vector<Type *> args;
  LLVMContext &context = M->getContext();
  Type *returnType = Type::getVoidTy(context);

  args.push_back(Type::getInt32Ty(context));
  return createFunction(returnType, args, false, name, M);
}

Function *createFunction(Type *returnType, vector<Type*> &args, bool isVarArg, const string &name, Module *M) {
  FunctionType *funcType = FunctionType::get(returnType, args, isVarArg);
  return Function::Create(funcType, GlobalValue::LinkageTypes::ExternalLinkage, name, M);
}

double statFormula(Stat *a) {
  return a->stores.size() * 0.0 + a->loads.size() * 1.0;
}
/**
 * TODO add preserves information
 */
bool AnnotateNew::runOnModule(Module &M) {
  initDebugLevel();

  debug(Yes) << "...................................Annotation Pass started.......................................................................\n";

  // TODO: Revisit this. Might be too slow. We are extracting an unoptimized SVF and then optimizing it
  SVFModule* svfModule = LLVMModuleSet::getLLVMModuleSet()->buildSVFModule(M);  
  PAGBuilder pag_builder;
	PAG* svf_pag = pag_builder.build(svfModule);

  AndersenWaveDiff* ander = AndersenWaveDiff::createAndersenWaveDiff(svf_pag);
  // AndersenWaveDiff* ander = AndersenWaveDiff::createAndersenWaveDiff(svfModule);
  SVFGBuilder builder;

  LOOP_ID = 0;
  module = &M;
  // SVFG* unoptimized_svfg =  builder.buildFullSVFG(ander);
  svfg =  builder.buildFullSVFG(ander);
  // svfg =  new SVFGOPT(unoptimized_svfg->getMSSA(), VFG::FULLSVFG_OPT);
  pag = svfg->getPAG();




  globPag = pag;
  globSvfg = svfg;

  debug(Yes)<<"[ARGS]\n";
  debug(Yes)<<"isLimitedDepth: "<<isLimitedDepth<<"\n";
  debug(Yes)<<"depthLimit: "<<depthLimit<<"\n";

  //printAllAllocsMallocs(M);


  set<const Value*> trackedAllocas;
  Function *main = M.getFunction("main");
  vector<Value *> sources;
  Value *argv;
  Value *argc = NULL;
  if(main->arg_begin() != main->arg_end())
    argc = &*main->arg_begin();

  int i =0;

  for (auto start = main->arg_begin(), end = main->arg_end(); start!=end; ++start){
      if(i==1)
          argv = &*start;
      i++;
  }

  sources.push_back(argv);
  if(auto val = getArgv("optind", M))
    sources.push_back(val);

  if(auto val = getArgv("optarg", M))
    sources.push_back(val);


  if(isLimitedDepth){ // Limiting CallGraph to depthLimit nodes away from main
    const Function* mainFunc = M.getFunction("main");
    depthFunctions.insert(mainFunc);
    setDepthFunctions(depthLimit, depthFunctions ,mainFunc);
    debug(Yes)<<"CallGraph functions considered: "<<depthFunctions.size()<<"\n";
  }

  run(sources, argc, trackedAllocas); 

  debug(Yes) << "Printing stats: " << "\n";
  vector<Stat *> statValues;

  vector<Value *> sortedLoads;
  vector<Value *> MemCpy;

  debug(Yes)<<"statMapSize: "<<statMap.size()<<"\n";
  for(auto &kv: statMap) {
    debug(Yes)<<"StatMap iter...\n";
    Stat *stat = &kv.second;
    debug(Yes)<<"kv.first: "<<*kv.first<<"\n";

    if(isLoadsLimited){
      debug(Yes)<<"Performing instrinisc check...\n";

      if(!isa<IntrinsicInst>(kv.first)){   //!isa<MemCpyInst>(kv.first)){
        debug(Yes)<<"Not instrinsic inst: "<<*kv.first<<"\n";


        const SVFGNode* srcNode = valToNode[kv.first]; //getSvfgNode(kv.first);
        if(srcNode){
          set<const Instruction*> Loads;
          set<const SVFGNode*> visited;

          dfsLoads(srcNode, Loads, visited);

          LoadsOnSource[srcNode] = Loads.size();
          sortedLoads.push_back(kv.first);
        }
      } else {
        debug(Yes)<<"MemCpyInst :" <<*kv.first<<"\n";
        MemCpy.push_back(kv.first);
      }
      }

      string name = "";
      if(auto inst = dyn_cast<Instruction>(kv.first))
        name = inst->getParent()->getParent()->getName();
      debug(Yes) << "Current Value: " << *kv.first << " in function " << name << "\n";
      debug(Yes) << "Printing loads for value" << *kv.first << ". Size: " << stat->loads.size() << "\n";
      for(auto &val: stat->loads) {
        debug(Yes) << "           Value: " << *val << " in Function: " << dyn_cast<Instruction>(val)->getParent()->getParent()->getName() << "\n"; 
      }

      debug(Yes) << "Printing stores for value" << *kv.first << ". Size: " << stat->stores.size() << "\n";
      for(auto &val: stat->stores) {
        debug(Yes) << "           Value: " << *val << " in Function: " << dyn_cast<Instruction>(val)->getParent()->getParent()->getName() << "\n"; 
      }

      debug(Yes) << "Printing branches for value" << *kv.first << ". Size: " << stat->branches.size() << "\n";
      for(auto &val: stat->branches)
        debug(Yes) << "           Value: " << *val << " in Function: " << dyn_cast<Instruction>(val)->getParent()->getParent()->getName() << "\n"; 
      statValues.push_back(stat);
      debug(Yes)<<"Inserted "<<*kv.first<< "into statValues\n";
    }


    std::sort(statValues.begin(), statValues.end(), [](Stat *a, Stat *b) {
        return statFormula(a) < statFormula(b);
        });

    std::sort(sortedLoads.begin(), sortedLoads.end(), myComparator);


    unsigned totalTracked = statMap.size();

    unsigned global_count = 0;

    debug(Yes) << "SIZE" << trackedAllocas.size() << "\n";
    debug(Yes) << "Sorted Values" << "\n";
    if (!isLoadsLimited) {
      for(int i = statValues.size() - 1; i >= 0; i--) { 
        debug(Yes) << *statValues[i]->value << " with value: " << (int) statFormula(statValues[i]) << "\n"; 
        Value *I = statValues[i]->value;
        debug(Yes)<<"Is value in tracked allocas? : "<<(trackedAllocas.find((const Value*) statValues[i]->value) != trackedAllocas.end())<<"\n";
        unsigned num = (statValues.size() - 1) - i + 1;
        LLVMContext &C = I->getContext();
        MDNode *N = MDNode::get(C, ConstantAsMetadata::get(ConstantInt::get(Type::getInt64Ty(C), num))); 
        if(dyn_cast<Instruction>(I))
          ((Instruction*)I)->setMetadata("track", N);
        else {
          ((GlobalObject*)I)->setMetadata("track", N);
          debug(Yes)<< "statGlob: "<< *((GlobalObject*)I)<<"\n";
          global_count++;
        }
      } 
    } else {
      int topNValue = (loadPercent/100.0) * sortedLoads.size();
      debug(Yes)<<"Considering only top "<<topNValue<<" values + memcpy insts # "<<MemCpy.size() <<"\n";

      unsigned remaining = topNValue;

      for(auto it = sortedLoads.begin(); it != sortedLoads.end(); it++){
        if(remaining-- <= 0){
          break;
        }
        Value* I = *it;


        unsigned num = (topNValue - 1) - remaining + 1;
        LLVMContext &C = I->getContext();
        MDNode *N = MDNode::get(C, ConstantAsMetadata::get(ConstantInt::get(Type::getInt64Ty(C), num))); 
        if(dyn_cast<Instruction>(I))
          ((Instruction*)I)->setMetadata("track", N);
        else {
          ((GlobalObject*)I)->setMetadata("track", N);
        }
      }
      debug(Yes)<<"==================\nMemCpy Tracking\n ";

      for(auto it = MemCpy.begin(); it != MemCpy.end(); it++){
        Value* I = *it;

        debug(Yes)<<"[TRACKING] "<< *I<<" "<<"NA"<<"\n";
        unsigned num = (topNValue - 1);
        LLVMContext &C = I->getContext();
        MDNode *N = MDNode::get(C, ConstantAsMetadata::get(ConstantInt::get(Type::getInt64Ty(C), num))); 
        if(dyn_cast<Instruction>(I))
          ((Instruction*)I)->setMetadata("track", N);
        else {
          ((GlobalObject*)I)->setMetadata("track", N);
        }
      }

      totalTracked = MemCpy.size() + topNValue;

    }



    debug(Yes)<<"Total Tracked Variables: "<<totalTracked<<"\n";




    vector<const Value*> trackedSorted;


    map<SVFGNode*, int> ValueLoads;



    debug(Yes)<<"TRACKED ALLOCAS SIZE : "<<trackedAllocas.size()<<"\n";
    
    debug(Yes)<<"\n===== Stats =====\n";
    debug(Yes)<<"# Number of Config Variables being tracked: "<<statValues.size()<<"\n";
    debug(Yes)<<"# Tracked number size: "<<totalTracked<<"\n";//trackedAllocas.size()<<"\n";
    debug(Yes)<<"# Total Nodes in PAG: "<<pag->getPAGNodeNum()<<"\n";
    debug(Yes)<<"# Total StmtNodes (PAGEdge): "<<pag->getPAGEdgeNum()<<"\n";
    debug(Yes)<<"# Total Globals: "<<0<<"\n";//trackedGlobals<<"\n";

    std::ofstream StatFile;
    StatFile.open("anotStats.JSON");

    StatFile<<"{ \"trackedAllocas\": "<<totalTracked<<" , \"globals\": "<< global_count <<"}\n"; 
    StatFile.close();

    return false;
  }



  void AnnotateNew::getAnalysisUsage(AnalysisUsage &AU) const { 
    AU.addRequired<LoopInfoWrapperPass>();
    AU.addRequired<ScalarEvolutionWrapperPass>();
    AU.addRequired<TargetLibraryInfoWrapperPass>();
    AU.addRequired<DominatorTreeWrapperPass>();
    AU.addRequired<PostDominatorTreeWrapperPass>();
  }


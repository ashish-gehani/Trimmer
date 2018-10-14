#include "AnnotateNew.h"

#include "llvm/ADT/DenseMap.h"

#include <set>
#include "WPA/Andersen.h"
#include "MemoryModel/PAG.h"
#include "MSSA/SVFGBuilder.h"
#include "MSSA/MemSSA.h"
#include "llvm/Analysis/AssumptionCache.h"


static cl::opt<std::string> argvName("argvName",
    cl::desc("global to track"));
static cl::opt<int> argvId("argvId",
    cl::desc("global to track"));

using namespace std;
using namespace analysisUtil;
using namespace llvm;

char AnnotateNew::ID = 0;

string AnnotateNew::print(SVFGNode *node, SVFG *graph) {
  std::string str;
  raw_string_ostream rawstr(str);
  rawstr << "NodeID: " << node->getId() << "\n";
  if(StmtSVFGNode* stmtNode = dyn_cast<StmtSVFGNode>(node)) {
    NodeID src = stmtNode->getPAGSrcNodeID();
    NodeID dst = stmtNode->getPAGDstNodeID();
    rawstr << dst << "<--" << src << "\n";
    if(stmtNode->getInst()) {
      rawstr << getSourceLoc(stmtNode->getInst());
    }
    else if(stmtNode->getPAGDstNode()->hasValue()) {
      rawstr << getSourceLoc(stmtNode->getPAGDstNode()->getValue());
    }
  }
  else if(MSSAPHISVFGNode* mphi = dyn_cast<MSSAPHISVFGNode>(node)) {
    rawstr << "MR_" << mphi->getRes()->getMR()->getMRID()
      << "V_" << mphi->getRes()->getResVer()->getSSAVersion() << " = PHI(";
    for (MemSSA::PHI::OPVers::const_iterator it = mphi->opVerBegin(), eit = mphi->opVerEnd();
        it != eit; it++)
      rawstr << "MR_" << it->second->getMR()->getMRID() << "V_" << it->second->getSSAVersion() << ", ";
    rawstr << ")\n";

    rawstr << mphi->getRes()->getMR()->dumpStr() << "\n";
    rawstr << getSourceLoc(&mphi->getBB()->back());
  }
  else if(PHISVFGNode* tphi = dyn_cast<PHISVFGNode>(node)) {
    rawstr << tphi->getRes()->getId() << " = PHI(";
    for(PHISVFGNode::OPVers::const_iterator it = tphi->opVerBegin(), eit = tphi->opVerEnd();
        it != eit; it++)
      rawstr << it->second->getId() << ", ";
    rawstr << ")\n";
    rawstr << getSourceLoc(tphi->getRes()->getValue());
  }
  else if(FormalINSVFGNode* fi = dyn_cast<FormalINSVFGNode>(node)) {
    rawstr	<< fi->getEntryChi()->getMR()->getMRID() << "V_" << fi->getEntryChi()->getResVer()->getSSAVersion() <<
      " = ENCHI(MR_" << fi->getEntryChi()->getMR()->getMRID() << "V_" << fi->getEntryChi()->getOpVer()->getSSAVersion() << ")\n";
    rawstr << fi->getEntryChi()->getMR()->dumpStr() << "\n";
    rawstr << "Fun[" << fi->getFun()->getName() << "]";
  }
  else if(FormalOUTSVFGNode* fo = dyn_cast<FormalOUTSVFGNode>(node)) {
    rawstr << "RETMU(" << fo->getRetMU()->getMR()->getMRID() << "V_" << fo->getRetMU()->getVer()->getSSAVersion() << ")\n";
    rawstr  << fo->getRetMU()->getMR()->dumpStr() << "\n";
    rawstr << "Fun[" << fo->getFun()->getName() << "]";
  }
  else if(FormalParmSVFGNode* fp = dyn_cast<FormalParmSVFGNode>(node)) {
    rawstr	<< "FPARM(" << fp->getParam()->getId() << ")\n";
    rawstr << "Fun[" << fp->getFun()->getName() << "]";
  }
  else if(ActualINSVFGNode* ai = dyn_cast<ActualINSVFGNode>(node)) {
    rawstr << "CSMU(" << ai->getCallMU()->getMR()->getMRID() << "V_" << ai->getCallMU()->getVer()->getSSAVersion() << ")\n";
    rawstr << ai->getCallMU()->getMR()->dumpStr() << "\n";
    rawstr << "CS[" << getSourceLoc(ai->getCallSite().getInstruction()) << "]";
  }
  else if(ActualOUTSVFGNode* ao = dyn_cast<ActualOUTSVFGNode>(node)) {
    rawstr <<  ao->getCallCHI()->getMR()->getMRID() << "V_" << ao->getCallCHI()->getResVer()->getSSAVersion() <<
      " = CSCHI(MR_" << ao->getCallCHI()->getMR()->getMRID() << "V_" << ao->getCallCHI()->getOpVer()->getSSAVersion() << ")\n";
    rawstr << ao->getCallCHI()->getMR()->dumpStr() << "\n";
    rawstr << "CS[" << getSourceLoc(ao->getCallSite().getInstruction()) << "]" ;
  }
  else if(ActualParmSVFGNode* ap = dyn_cast<ActualParmSVFGNode>(node)) {
    rawstr << "APARM(" << ap->getParam()->getId() << ")\n" ;
    rawstr << "CS[" << getSourceLoc(ap->getCallSite().getInstruction()) << "]";
  }
  else if(isa<NullPtrSVFGNode>(node)) {
    rawstr << "NullPtr";
  }
  else if (ActualRetSVFGNode* ar = dyn_cast<ActualRetSVFGNode>(node)) {
    rawstr << "ARet(" << ar->getRev()->getId() << ")\n";
    rawstr << "CS[" << getSourceLoc(ar->getCallSite().getInstruction()) << "]";
  }
  else if (FormalRetSVFGNode* fr = dyn_cast<FormalRetSVFGNode>(node)) {
    rawstr << "FRet(" << fr->getRet()->getId() << ")\n";
    rawstr << "Fun[" << fr->getFun()->getName() << "]";
  }
  else
    assert(false && "what else kinds of nodes do we have??");

  return rawstr.str();
}

bool isMemTransfer(const Value *inst) {
  if(dyn_cast<StoreInst>(inst))
    return true;

  if(dyn_cast<MemCpyInst>(inst))
    return true;

  if(auto casted =dyn_cast<CallInst>(inst)) {
    errs() << casted->getCalledFunction()->getName() << "\n";
    if(casted->getCalledFunction()->getName() == "strncpy" || casted->getCalledFunction()->getName() == "strcpy")
      return true;
  }

  return false;
}

GlobalValue* getArgv(string argvName, Module &M) {
  if(argvName.size())
    return M.getNamedValue(argvName);
  return NULL;  
}

static RegisterPass<AnnotateNew> X("svfg", "Constant Folding for strings", false, false);

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
    for(auto child : children) {
      worklist.push_back(child);
      //if(auto casted = dyn_cast<StmtSVFGNode>(child))
      //if(casted->getInst())
      //errs() << "Instruction :" << *casted->getInst() << "\n";
    }
  }
}

vector<SVFGNode*> forwardDfsLambda(SVFGNode *current) {
  vector<SVFGNode*> worklist;
  for(auto it = current->OutEdgeBegin(), end = current->OutEdgeEnd(); it != end; it++) {
    worklist.push_back((*it)->getDstNode());
  }
  return worklist;
}



vector<SVFGNode*> backwardDfsLambda(SVFGNode *current) {
  vector<SVFGNode*> worklist;
  for(auto it = current->InEdgeBegin(), end = current->InEdgeEnd(); it != end; it++) {
    worklist.push_back((*it)->getSrcNode());
  }
  return worklist;
}

bool allTrueCondition(SVFGNode *) {
  return true;
}

vector<Value*> genericScalarDfs(Value *current) {
  vector<Value *> worklist;
  for(auto &use: current->uses()) {
    auto user = use.getUser();
    worklist.push_back(user);
  }
  return worklist;
};

vector<Value*> genericScalarDfsBackward(Value *current) {
  vector<Value *> worklist;
  for(auto &use: current->uses()) {
    auto user = use.getUser();
    for(unsigned i = 0; i < user->getNumOperands(); i++)
      worklist.push_back(user->getOperand(i));
  }
  return worklist;
};

bool supportedInst(Value *v) {
  return dyn_cast<AllocaInst>(v) || dyn_cast<PHINode>(v) || dyn_cast<StoreInst>(v) || dyn_cast<LoadInst>(v) || dyn_cast<GetElementPtrInst>(v);
}

struct dfsInfo {
  char color;
  int distance;
  char type;
  BasicBlock *parent;
};

/**
 * TODO move to dominator tree
 */
void diamondJoin(BasicBlock *current, map<BasicBlock *, dfsInfo*> &dfsData, int distance = 0) {
  if(dfsData.find(current) == dfsData.end())
    dfsData[current] = new dfsInfo;

  dfsData[current]->color = 'g';
  dfsData[current]->distance = distance;
  distance += 1;
  auto terminator = current->getTerminator();
  for(int i = 0; i < terminator->getNumSuccessors(); i++) {
    auto succ = terminator->getSuccessor(i);
    auto it = dfsData.find(succ);
    errs() << current << "-> " << succ << "\n";
    if(it == dfsData.end()) {
      dfsData[succ] = new dfsInfo;
      dfsData[succ]->type = 't';
      dfsData[succ]->parent = current;
      diamondJoin(succ, dfsData, distance);
    }else if(it->second->color == 'b') {
      //if(dfsData[current]->distance >= it->second->distance) {
      //it->second->parent = current;
      it->second->type = 'c';
      //errs() << "yeahh **********************";
      //}
    }
  }

  dfsData[current]->color = 'b';
  distance += 1;
}

PHINode* getLoopInductionVariable(Loop *L, ScalarEvolution *SE) {
  PHINode *InnerIndexVar = L->getCanonicalInductionVariable();
  if (InnerIndexVar)
   return InnerIndexVar;
  if (L->getLoopLatch() == nullptr || L->getLoopPredecessor() == nullptr)
   return nullptr;
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
   if (!isa<SCEVConstant>(Step))
     continue;
   // Found the induction variable.
   // FIXME: Handle loops with more than one induction variable. Note that,
   // currently, legality makes sure we have only one induction variable.
   return PhiVar;
  }
  return nullptr;
}

void AnnotateNew::getBranchAndArgcInstructions(set<BranchInst*> &branches, set<CallInst*> &calls, set<Instruction*> &argcValues, set<SVFGNode*>& svfgNodes) {

  TargetLibraryInfo *TLI = &getAnalysis<TargetLibraryInfoWrapperPass>().getTLI();

  for(auto &F: *module) {
    if(F.isDeclaration())
      continue;

    LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(F).getLoopInfo();
    AssumptionCache &AC = getAnalysis<AssumptionCacheTracker>(F).getAssumptionCache(F);
    DominatorTree * DT = new DominatorTree(F);
    ScalarEvolution SE(F, *TLI, AC, *DT, LI);

    for(auto it = LI.begin(), end = LI.end(); it != end; it++) {
      errs() << F.getName() << "\n";
      Loop *L = *it;
      if(auto temp = getLoopInductionVariable(L, &SE)) {
        errs() << *temp << "\n";
        errs() << "loop AWWWWWWWWWWWWWWWWWWWWWWWWWWWW" << "\n";
        for(unsigned i = 0; i < temp->getNumIncomingValues(); i++) {
          errs() << *temp->getIncomingValue(i) << "\n";
          set<Value *> possible;
          Value *current = temp->getIncomingValue(i);

          dfs<Value*>(current, genericScalarDfsBackward, isLoad, possible);

          for(auto &V: possible) {
            errs() << "Loop: adding : " << *V << "\n";
            SVFGNode* svfgNode;
            if(V->getType()->isPointerTy())
              svfgNode = getSvfgNode(V);     
            else
              svfgNode = getSvfgNode(dyn_cast<LoadInst>(V)->getPointerOperand());

            svfgNodes.insert(svfgNode);
          }
        }
      } else {
        for(auto BB: L->getBlocks()) {
          for(auto &I: *BB) {
            Value *current;

            if(I.getType()->isPointerTy())
              current = &I;
            else if(auto load = dyn_cast<LoadInst>(&I))
              current = load->getPointerOperand();
            else if(auto store = dyn_cast<StoreInst>(&I))
              current = store->getPointerOperand();
            else
              continue;

            auto svfgNode = getSvfgNode(current);
            if(auto temp = dyn_cast<StmtSVFGNode>(svfgNode)) {
              if(temp->getInst()) {
                errs() << "Adding loop pointer " << *temp->getInst() << "\n";
                svfgNodes.insert(svfgNode);
              }
            }
          }
        }
      }
    }

    for(auto &BB: F) {
      for(auto &I: BB) {

        if(I.getMetadata("track_argc")) {
          argcValues.insert(&I);
        }

        if(auto branch = dyn_cast<BranchInst>(&I))
          branches.insert(branch);

        if(auto callInst = dyn_cast<CallInst>(&I))
          if(callInst->getCalledFunction()->getName() == "strncpy" || callInst->getCalledFunction()->getName() == "strcpy")
            calls.insert(callInst);
      }
    }
  }
}

bool isLoad(Value *V) {
  return dyn_cast<LoadInst>(V);
}

void AnnotateNew::getTaintedBranches(set<BranchInst*>& trackedBranches, set<BranchInst*> &allBranches, Value *argv, set<const Value*>& trackedAllocas) {

  for(auto branchInst: allBranches) {
    if(branchInst->isUnconditional())
      continue;

    //TODO ?
    CmpInst *condition = dyn_cast<CmpInst>(branchInst->getCondition());
    if(!condition)
      continue;

    //perform dfs backwards on each value of the branch condition
    for(int i = 0; i < condition->getNumOperands(); i++) {

      errs() << "Operand : " << *condition->getOperand(i)<< "\n";
      Value *current = condition->getOperand(i);
      set<Value *> possible;

      //if scalar, get loads. if pointer and supported by svfg, get allocas
      if(!current->getType()->isPointerTy())
        dfs<Value*>(current, genericScalarDfsBackward, isLoad, possible);
      else if(supportedInst(current))
        possible.insert(current);

      //go back to tap into any possible SVFG node.
      //TODO:? Due to mem2reg, we might have direct register values instead of allocas
      //e.g. if(a == 1) x = 2; else x = 3; Need to handle that
      
      if(!possible.size())
        continue;
      set<SVFGNode*> poss;

      //condition for when a branch instruction is of our use
      auto conditionLambda = [&](SVFGNode *node) {
        if(auto temp = dyn_cast<StmtSVFGNode>(node)) {
          if(trackedAllocas.find(temp->getInst()) != trackedAllocas.end())
            return true;
          for(auto &use: argv->uses()) {
            auto user = use.getUser();
            if(user == temp->getInst()) {
              return true;
            }
          }
        }
        return false;
      };

      //track back to possible alloca
      for(auto value: possible) {
        errs() << *value << "\n";
        const PAGNode* pagNode;
        //single level loads
        if(auto load = dyn_cast<LoadInst>(value))
          if(!value->getType()->isPointerTy())
            value = load->getPointerOperand();

        errs() << *value << "\n";
        pagNode = pag->getPAGNode(pag->getValueNode(value));
        auto svfgNode = svfg->getDefSVFGNode(pagNode);
        dfs<SVFGNode*>((SVFGNode*) svfgNode, backwardDfsLambda, conditionLambda, poss); 
        if(poss.size()) {
          errs() << "Tracking branch : " << *branchInst << "\n"; 
          trackedBranches.insert(branchInst);
          break;
        }
      } 
    }
  }
}


//performs dfs 
BasicBlock *getJoinBb(BasicBlock *current) {
  map<BasicBlock *, dfsInfo *> dfsData;
  diamondJoin(current, dfsData);
  BasicBlock *join;
  for(auto it = dfsData.begin(), end = dfsData.end(); it != end; it++) {
    if(it->second->type == 'c') { //cross edge found
      join = it->first;
      break; //TODO assumption that only one
    }
  }

  return join;
}

/*
 * Traverse SVFG chain, and get all nodes into which the current node's data flows,
 * e.g. through store, memcpy
 */
void AnnotateNew::getMemoryFlow(const SVFGNode *current, set<const Value *> &singleLevelPointers, set<SVFGNode*> &storeSvfg, set<CallInst*> calls) {
  //capture single level pointers as well as condition to capture output

  auto forwardDfsCondition = [&](SVFGNode* node) {
    if(auto casted = dyn_cast<StmtSVFGNode>(node)) {
      if(casted->getInst()) {
        errs() << "Instruction: " << *casted->getInst() << "\n";
        const Value *inst = casted->getInst();
        if(auto point = dyn_cast<PointerType>(inst->getType())) {
          if(!point->getElementType()->isPointerTy()) {
            errs() <<*point << " " << *inst<< "  ****************\n";
            singleLevelPointers.insert(inst);
          }

          //check if involved in any strcpy or strncpy
          for(auto &call: calls) {
            errs() << call << "AWWWWWWWWW";
            bool found = false;
            for(unsigned i = 0; i < call->getNumOperands(); i++) { 
              if(call->getOperand(i) == casted->getInst()) {
                //return true;
                found = true;
              }
            }
            if(found) {
              for(unsigned i = 0; i < 2; i++) {
                auto *pagNode = pag->getPAGNode((pag->getValueNode(call->getOperand(i))));
                storeSvfg.insert((SVFGNode*) svfg->getDefSVFGNode(pagNode));
              }
            }
          }
        }
      }

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
  dfs<SVFGNode*>((SVFGNode*)current, forwardDfsLambda, forwardDfsCondition, storeSvfg);
}


void AnnotateNew::getSourceAllocas(set<SVFGNode*> &storeSvfg, vector<const SVFGNode*> &worklistSvfg, set<const Value*> &trackedAllocas) {
  //Note: lambda changes worklistSvfg too
  auto backwardDfsCondition = [&](SVFGNode* node) {
    if(auto casted = dyn_cast<StmtSVFGNode>(node)) {
      auto pagEdge = casted->getPAGEdge();
      if(pagEdge->getInst()) {
        if(dyn_cast<AllocaInst>(pagEdge->getInst()))
          return true;

        //TODO add this to trackedAlloca. Use MemObj instead of pointer hack
        if(auto temp = dyn_cast<User>(pagEdge->getInst())){
          for(int i = 0; i < temp->getNumOperands(); i++) {
            auto current = temp->getOperand(i);
            if(dyn_cast<GlobalValue>(current)) {
              const PAGNode *pagNode = pag->getPAGNode((pag->getValueNode(current)));
              auto svfgNode = (SVFGNode*) svfg->getDefSVFGNode(pagNode);
              worklistSvfg.push_back(svfgNode);
              trackedAllocas.insert(current); // hackish
            }
          }
        }

        if(auto call = dyn_cast<CallInst>(pagEdge->getInst())) {
          if (call->getCalledFunction()->getName() == "malloc") {
            return true;
          }
        }
      }
    }
    return false;
  };

  for(auto it = storeSvfg.begin(), end = storeSvfg.end(); it != end; it++) {
    set<SVFGNode *> allocas;
    auto temp = dyn_cast<StmtSVFGNode>(*it);
    if(!temp)
      continue;
    if(temp->getInst())
      errs() << "Going backward on Instruction : " << *(temp->getInst()) << " \n";
    dfs<SVFGNode*>(*it, backwardDfsLambda, backwardDfsCondition, allocas);
    std::copy(allocas.begin(), allocas.end(), std::back_inserter(worklistSvfg));
    //for(auto it = allocas.begin(), end = allocas.end(); it != end; it++)
    //trackedAllocas.insert(dyn_cast<StmtSVFGNode>(*it)->getInst()); 
  }
}

/**
 * Get non pointer uses of a scalar
 * Currently only getting GEPs and Stores
 * TODO can scalars have GEP??
 */
void getScalarStores(Value *scalar, set<Value*>& stores) {
  //errs() << "LOADDDDDD************: " << *scalar << "\n";
  vector<Value *> worklist;
  worklist.push_back(scalar);
  //traverse use chain of load and get any getElementPtr or stores
  assert(!scalar->getType()->isPointerTy());
  errs() << *scalar << " getting uses of scalar \n";
  set<Value*> processed;
  while(worklist.size()) {
    Value *current = worklist.back();
    worklist.pop_back();
    if(processed.find(current) != processed.end())
      continue;
    processed.insert(current);
    errs() << "Use: " << *current << "\n";
    for(auto &use: current->uses()) {
      auto user = use.getUser();
      errs() << "User: " << *user << "\n";
      //errs() << 
      if(isMemTransfer(user))
        stores.insert(user);

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
    errs() << "HEREE" << "\n";
    if(casted->getInst()) {
      auto inst = casted->getInst();
      //TODO remove this debug statement
      errs() << "Going forward on Instruction : " << *inst << " in function " <<  "\n";

      if(dyn_cast<AllocaInst>(casted->getInst()) || dyn_cast<GlobalValue>(casted->getInst()))
        trackedAllocas.insert(casted->getInst());

      if(auto temp = dyn_cast<CallInst>(casted->getInst()))
        if (temp->getCalledFunction()->getName() == "malloc")
          trackedAllocas.insert(temp);
    }
  }
}

SVFGNode *AnnotateNew::getSvfgNode(Value *V) {
  auto pagNode = pag->getPAGNode(pag->getValueNode(V));
  return (SVFGNode*)svfg->getDefSVFGNode(pagNode);
}

void AnnotateNew::getStoreSvfg(set<Value*> &stores, set<SVFGNode*> &storeSvfg) {
  for(auto &value: stores) {
    if(!isMemTransfer(value))
      assert("Must be a memory transfer value" && false);
    storeSvfg.insert(getSvfgNode(dyn_cast<User>(value)->getOperand(1)));
    //errs() << *dyn_cast<User>(value)->getOperand(1) <<"\n";
  }
}
/**
 * TODO move to dominator tree
 */
void getBbsTillJoin(BasicBlock *join, set<BasicBlock*>& markedBBs, BranchInst *I) {
  for(int i = 0; i < I->getNumSuccessors(); i++) {
    errs() << "In successor " << i << "\n";
    errs() << I->getSuccessor(i) << "\n";
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

void getLoadsOnSingleLevelPointers(Value* pointer, set<Value*> &singleLevelLoads) {
  //get non pointer data to track
  auto isLoadOnSingleLevelPointer = [](Value *current) {
    if(dyn_cast<LoadInst>(current))
      if(auto temp = dyn_cast<PointerType>(dyn_cast<User>(current)->getOperand(0)->getType()))
        return !current->getType()->isPointerTy(); 
    return false;
  };



  dfs<Value*>((Value*)pointer, genericScalarDfs, isLoadOnSingleLevelPointer, singleLevelLoads); //get all loads of single level pointer 
}

void printAllAllocsMallocs(Module &M) {
  set<Instruction *> asd;
  for(auto &F: M) {
    for(auto &BB: F) {
      for(auto &I: BB) {
        if (dyn_cast<AllocaInst>(&I))
          asd.insert(&I);
        if (auto temp = dyn_cast<CallInst>(&I))
          if(temp->getCalledFunction()->getName() == "malloc")
            asd.insert(&I);
      }
    }
  }

  for(auto &I: asd) {
    errs() << *I << "\n";
  }
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
void AnnotateNew::run(GlobalValue* argv, Value *argc, set<const Value*> &trackedAllocas) {

  //set<const Value *> singleLevelPointers; //store single level pointers

  //forward and backward dfs to get allocas/mallocs
  vector<const SVFGNode*> worklistSvfg;
  set<BranchInst*> allBranches;
  set<const Value*> singleLevelPointers;
  set<const SVFGNode *> processed;
  set<Instruction *> argcValues;
  set<CallInst *> calls;
  set<Loop*> loops;

  {
    const PAGNode *pagNode = pag->getPAGNode((pag->getValueNode(argv)));
    auto svfgNode = svfg->getDefSVFGNode(pagNode);
    worklistSvfg.push_back(svfgNode);
  } 

  if(argc) {
    set<Value*> stores;
    set<SVFGNode*> storeSvfg;
    getScalarStores(argc, stores);
    getStoreSvfg(stores, storeSvfg);
    getSourceAllocas(storeSvfg, worklistSvfg, trackedAllocas);
  }

  trackedAllocas.insert(argv);
  {
    set<SVFGNode*> svfgNodes;
    getBranchAndArgcInstructions(allBranches, calls, argcValues, svfgNodes);
    getSourceAllocas(svfgNodes, worklistSvfg, trackedAllocas);
  }
    
  // just for running tests
  {
    for(auto &I: argcValues) {
      set<Value*> stores;
      set<SVFGNode*> storeSvfg;
      errs() << *I << "\n";
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

  //getArgc(trackedAllocas, M); 

  while(1) {
    while(worklistSvfg.size()) {
      const SVFGNode *current = worklistSvfg.back();
      worklistSvfg.pop_back();

      if(processed.find(current) != processed.end())
        continue;

      errs() << "PROCESSING " << current << "\n";

      trackIfMemory(current, trackedAllocas);

      processed.insert(current);

      errs() << print((SVFGNode*)(current),svfg) << "\n";

      set<SVFGNode *> storeSvfg; 
      //traverse memory chain of this svfgnode, and get any stores 
      getMemoryFlow(current, singleLevelPointers, storeSvfg, calls);
      //go backward to get corresponding allocs/mallocs
      getSourceAllocas(storeSvfg, worklistSvfg, trackedAllocas); 
    }

    set<Value*> stores;
    //Handle single level pointers
    for(auto &pointer: singleLevelPointers) {
      set<Value*> singleLevelLoads; //these are esentially normal llvm scalar values, tracked through use def chains
      //<Value*>((Value*)pointer, lambdaNonPointerDfs, isLoadOnSingleLevelPointer, singleLevelLoads); //get all loads of single level pointer 
      getLoadsOnSingleLevelPointers((Value*) pointer, singleLevelLoads);
      //TODO add loads to trackedAllocas?
      for(auto &load: singleLevelLoads) {
        getScalarStores(load, stores); 
      }
    }

    singleLevelPointers.clear();
    worklistSvfg.clear(); //unnecessary
    //if any geps or stores in uses of a scalar
    if(stores.size()) {
      set<SVFGNode*> storeSvfg;
      getStoreSvfg(stores, storeSvfg);
      getSourceAllocas(storeSvfg,worklistSvfg, trackedAllocas);
      continue;
    }

    //get all branch instructions touching tainted data
    set<BranchInst*> trackedBranches;
    getTaintedBranches(trackedBranches, allBranches, argv, trackedAllocas);

    if(!trackedBranches.size())
      break;

    for(auto branch: trackedBranches) {
      allBranches.erase(branch);
    }

    //get branch join BB
    //find join node in tracked branches and get BBs which are affected by these branch insts
    set<BasicBlock*> markedBBs;
    for(auto &I: trackedBranches) {

      BasicBlock *join = getJoinBb(I->getParent()); 

      //TODO handle this
      if(!join)
        continue;

      getBbsTillJoin(join, markedBBs, I);
    }

    errs() << "Marked BBS: " << markedBBs.size() << "\n";
    /**
     * if markedbbs, do
     * 1) for any pointer, track back its allocs/mallocs
     * 2) for any single level pointer, traverse def use chain -> get stores/geps -> taint data
     * 3) TODO add all rest of Values to trackedAllocas?
     * 4) Add any mallocs/allocs to tracked data
     * 5) TODO handle phi nodes
     * 6) TODO handle scalars
     */
    if(markedBBs.size()) {
      set<SVFGNode*> backwardPtr;
      for(auto &BB: markedBBs) {
        set<Value *> scalarOrSlp; //Slp Single level pointer
        for(auto &I: *BB) {
          //handle pointers
          if(dyn_cast<AllocaInst>(&I)) {
            trackedAllocas.insert(&I);
          } else if(auto temp = dyn_cast<CallInst>(&I)) {
            if(temp->getCalledFunction()->getName() == "malloc")
              trackedAllocas.insert(temp);
          } else if(I.getType()->isPointerTy()) {
            auto pointerTy = dyn_cast<PointerType>(I.getType());

            //single level pointers handle differently
            if(!pointerTy->getElementType()->isPointerTy()) { //single level pointer
              errs() << "SINNGLEE* **** << " << I << "\n";
              singleLevelPointers.insert(&I);
            }

            auto pagNode = pag->getPAGNode(pag->getValueNode(&I));
            auto svfgNode = svfg->getDefSVFGNode(pagNode);

            //for any pointer, track back to its alloc/malloc
            backwardPtr.insert((SVFGNode*)svfgNode);
          } else {
            // non pointer values
            scalarOrSlp.insert(&I);
          }

          errs() << "In branch : " << I << "\n";
          //trackedAllocas.insert(&I);
        }
      }
      getSourceAllocas(backwardPtr, worklistSvfg, trackedAllocas);
    } else {
      break;
    }
  }
}

/**
 * TODO add preserves information
 */
bool AnnotateNew::runOnModule(Module &M) {
  AndersenWaveDiff* ander = AndersenWaveDiff::createAndersenWaveDiff(M);
  SVFGBuilder builder;

  module = &M;
  svfg =  builder.buildSVFG(ander);
  pag = svfg->getPAG();

  //printAllAllocsMallocs(M);


  set<const Value*> trackedAllocas;
  vector<const SVFGNode *> worklistSvfg; //worklist of pointers to track
  set<const SVFGNode *> processed;
  set<const Value *> singleLevelPointers; //store single level pointers

  Function *main = M.getFunction("main");
  GlobalValue *argv;
  Value *argc = NULL;
  if(main->arg_begin() != main->arg_end())
    argc = &*main->arg_begin();

  if(!(argv = getArgv(argvName,M))) {
    errs() << "Argv not found \n";
    return false;
  }

  errs() << "ID: " << argvId << "\n";

  run(argv, argc, trackedAllocas);

  errs() << "SIZE" << trackedAllocas.size() << "\n";
  for(auto I: trackedAllocas) {
    errs() << *I << "\n";
    LLVMContext &C = I->getContext();
    MDNode *N = MDNode::get(C, MDString::get(C, "1"));
    if(dyn_cast<Instruction>(I))
      ((Instruction*)I)->setMetadata("track", N);
    else
      ((GlobalObject*)I)->setMetadata("track", N);
  }
  return false;
}

void AnnotateNew::getAnalysisUsage(AnalysisUsage &AU) const { 
  AU.addRequired<LoopInfoWrapperPass>();
  AU.addRequired<ScalarEvolutionWrapperPass>();
  AU.addRequired<TargetLibraryInfoWrapperPass>();
  AU.addRequired<DominatorTreeWrapperPass>();
}

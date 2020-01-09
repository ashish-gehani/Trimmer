#include "llvm/Support/raw_ostream.h"

#include "Stats.h"

#include <chrono>

using namespace std;

Stats::Stats() {
  count = 0;
  libCallsSimplified = 0;
  loadsFolded = 0;
  totalLoads = 0;
  totalLibCalls = 0;
  functionsCloned = 0;
  loopsUnrolled = 0;
  trackedLoads = 0;
}

void Stats::functionCall(Function *child) {
  FunctionStats *stat = new FunctionStats(child, count++);
  if(stack.size())
    getRunningFunction()->addChild(stat);
  stack.push_back(stat);
}

inline FunctionStats *Stats::getRunningFunction() {
  if(!stack.size()) {
    errs() << "stats: no running function\n";
    return NULL;
  }
  return stack[stack.size()-1];
}

LoopStats *Stats::getRunningLoop() {
  int i;
  for(i = stack.size() - 1; i >= 0; i--) {
    if(stack[i]->loops.size() && stack[i]->getRunningLoop())
      return stack[i]->getRunningLoop();
  }
  errs() << "getRunningLoop: returned NULL\n";
  return NULL;
}

void Stats::functionReturn() {
  FunctionStats *pop = stack.back();
  pop->functionReturn();
  stack.pop_back();
  processed.insert(pop);
}

void Stats::loopStart(BasicBlock *loopHeader) {
  getRunningFunction()->loopStart(loopHeader);
}

void Stats::loopSuccess() {
  getRunningFunction()->loopSuccess();
}

//returns true if terminated
bool Stats::getLoopTime(uint64_t &seconds) {
  errs()<<"getLoopTime() in stats\n";
  
  if(getRunningLoop() == NULL)
    return false;
  return getRunningLoop()->getLoopTime(seconds);
}

void Stats::loopFail() {
  getRunningFunction()->loopFail();
}

void Stats::printStats(FunctionStats *root) {
  if(!root)
    return;

  root->printStats();
  for(auto &child: root->children)
    printStats(child);
}

void Stats::printStats(Function *main) {
  FunctionStats *root = NULL;
  for(auto &func: processed) {
    if(func->getFunction() == main)
      root = func;
  }

  printStats(root);
  errs()<<"==================|Stats|===================="<<"\n";
  errs()<<"# LibCalls Simplified: "<<libCallsSimplified<<"\n";
  errs()<<"# Total LibCalls: "<<totalLibCalls<<"\n";
  errs()<<"# Loads Folded: "<<loadsFolded<<"\n";
  errs()<<"# Tracked Loads Folded: "<<trackedLoads<<"\n";
  errs()<<"# Total Loads Encountered: "<< totalLoads<<"\n";
  errs()<<"# Function Calls Analyzed: "<<count<<"\n";
  errs()<<"# Functions Cloned: "<<functionsCloned<<"\n";
  errs()<<"# Loops Unrolled: "<<loopsUnrolled<<"\n";

}

void Stats::swapFunction(Function *oldF, Function *newF) {
  FunctionStats *old = getRunningFunction();
  old->setFunction(newF);
}

void Stats::makeGraph(Function *main) {
  FunctionStats *root = NULL;
  for(auto &func: processed) {
    if(func->getFunction() == main)
      root = func;
  }

  string str = "digraph D { \n";
  root->makeGraph(str);
  str += "}";
  errs() << str << "\n";
}

void Stats::incrementLibCallsFolded(){ libCallsSimplified++; }
void Stats::incrementTotalLoads(){ totalLoads++; }
void Stats::incrementLoadsFolded(){ loadsFolded++; }
void Stats::incrementTotalLibCalls(){ totalLibCalls++; }
void Stats::incrementFunctionsCloned() { functionsCloned++; }
void Stats::incrementLoopsUnrolled() { loopsUnrolled++; } 
void Stats::incrementTrackedLoads() { trackedLoads++;          }
unsigned Stats::getTrackedLoads() { return trackedLoads; }

bool FunctionStats::getLoopTime(uint64_t &seconds) {
  errs()<<"getLoopTime(seconds) \n";
  return getRunningLoop()->getLoopTime(seconds);
}

FunctionStats::FunctionStats(Function *f, unsigned id) {
  this->f = f;
  this->id = id;
  startTime = chrono::system_clock::now();
}

void FunctionStats::functionReturn() {
  endTime = chrono::system_clock::now();
}

void FunctionStats::loopStart(BasicBlock *BB) {
  errs() << "pushing new loop " << BB->getName() << "for function " << this->f->getName() << "\n";
  loops.push_back(new LoopStats(BB));
}

void FunctionStats::setFunction(Function *f) {
  this->f = f;
}

inline LoopStats *FunctionStats::getRunningLoop() {
  int i;
  assert(loops.size());
  errs() << "loop size:" << loops.size() << "\n";
  for(i = loops.size() - 1; i >= 0 && loops[i]->hasLoopTerminated(); i--);
  //assert(i >= 0);
  if(i < 0)
    return NULL;
  errs() << " i " << i << "\n";
  return loops[i];
}

void FunctionStats::loopSuccess() {
  errs()<<"loopSuccess() in stats\n";
  getRunningLoop()->loopSuccess();   
}

void FunctionStats::loopFail() {
  errs()<<"loopFail() in stats\n";
  getRunningLoop()->loopFail();   
}

Function *FunctionStats::getFunction() {
  return f;
}

void FunctionStats::printStats() {
  errs() << "Function Name: " << getFunction()->getName() << " time: " << getRunTime() << "\n";
  for(auto &loop: loops) {
    errs() << "           Loop BB header: " << loop->getHeader()->getName() << " time: " << loop->getRunTime() << "\n";
  }
}

void replace(string& str, const string oldStr, const string newStr) {
  string::size_type pos = 0u;
  while((pos = str.find(oldStr, pos)) != string::npos){
    str.replace(pos, oldStr.length(), newStr);
    pos += newStr.length();
  }
}

string FunctionStats::getLabels() {
  string str = "";
  string name = getFunction()->getName().str();
  replace(name, ".", "_");
  str += name + "  " + to_string(getRunTime()) + "\\n";
  for(auto &loop: loops) {
    string name = loop->getHeader()->getName().str();
    replace(name, ".", "_");
    str +=  name + "  " + to_string(loop->getRunTime()) + "\\n";
  }
  return str;
}

void FunctionStats::makeGraph(string &str) {
  Function *func = getFunction();
  string name = func->getName().str();
  replace(name, ".", "_");
  str +=  name + " [label=\"" + getLabels() + "\" ] \n";
  for(auto &child: children) {
    string childName = child->getFunction()->getName().str();
    replace(childName, ".", "_");
    str += name + " -> "  + childName + "\n";
  }

  for(auto &child: children) {
    child->makeGraph(str);
  }
}

bool LoopStats::getLoopTime(uint64_t &seconds) {
  if(terminated) {
    auto elapsed = chrono::duration_cast<chrono::seconds>(endTime-startTime);
    seconds = elapsed.count();
  } else {
    auto current = chrono::system_clock::now();
    auto elapsed = chrono::duration_cast<chrono::seconds>(current - startTime);
    seconds = elapsed.count();
  }
  return terminated;
}

LoopStats::LoopStats(BasicBlock *BB) {
  header = BB;
  terminated = false;
  passed = false;
  startTime = chrono::system_clock::now();
}

void LoopStats::loopSuccess() {
  terminated = true;
  passed = true;
  endTime = chrono::system_clock::now();
}

void LoopStats::loopFail() {
  terminated = true;
  passed = true;
  endTime = chrono::system_clock::now();
}

BasicBlock *LoopStats::getHeader() {
  return header;
}

inline bool LoopStats::hasLoopTerminated() {
  return terminated;
}

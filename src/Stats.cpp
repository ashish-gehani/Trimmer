// Copyright (c) 2020 SRI International All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/*This file contain methods to keep track of statistics and print statistics such as total loads, function cloned, loop unrolled etc. Fo example 
incrementFunctionCloned() is called whenever we clone a function.*/


#include "llvm/Support/raw_ostream.h"

#include "Stats.h"
#include "Debug.h"
#include <chrono>
#include <fstream>


using namespace std;


Stats::Stats() {
  count = 0;
}


void Stats::removeFunctions(set<Function*> setFuncs)
{
  
  for(auto &func:setFuncs){
    functionsToRemove.insert(func);
  }
}


void Stats::incrementLibCallsFolded()
{

  if(getCurrentFuncRunningLoop()==NULL && stack.size())
    getRunningFunction()->stat->incrementLibCallsFolded();
  else if(getCurrentFuncRunningLoop()!=NULL)
    getCurrentFuncRunningLoop()->stat->incrementLibCallsFolded();
}


void Stats::incrementTotalLoads()
{
 if(getCurrentFuncRunningLoop()==NULL && stack.size())
    getRunningFunction()->stat->incrementTotalLoads();
  else if(getCurrentFuncRunningLoop()!=NULL)
    getCurrentFuncRunningLoop()->stat->incrementTotalLoads();
}

void Stats::incrementLoadsFolded()
{
   if(getCurrentFuncRunningLoop()==NULL && stack.size())
    getRunningFunction()->stat->incrementLoadsFolded();
  else if(getCurrentFuncRunningLoop()!=NULL)
    getCurrentFuncRunningLoop()->stat->incrementLoadsFolded();
}

void Stats::incrementTotalLibCalls()
{
 if(getCurrentFuncRunningLoop()==NULL && stack.size())
    getRunningFunction()->stat->incrementTotalLibCalls();
  else if(getCurrentFuncRunningLoop()!=NULL)
    getCurrentFuncRunningLoop()->stat->incrementTotalLibCalls();
}

void Stats::incrementTotalLoops()
{
 if(getCurrentFuncRunningLoop()==NULL && stack.size())
    getRunningFunction()->stat->incrementTotalLoops();
  else if(getCurrentFuncRunningLoop()!=NULL)
    getCurrentFuncRunningLoop()->stat->incrementTotalLoops();
}


void Stats::incrementFunctionCalls(){
  if(getCurrentFuncRunningLoop()==NULL && stack.size())
    getRunningFunction()->stat->incrementFunctionCalls();
  else if(getCurrentFuncRunningLoop()!=NULL)
    getCurrentFuncRunningLoop()->stat->incrementFunctionCalls();
}
    
void Stats::incrementLoopsUnrolled()
{
  if(getCurrentFuncRunningLoop()==NULL && stack.size())
    getRunningFunction()->stat->incrementLoopsUnrolled();
  else if(getCurrentFuncRunningLoop()!=NULL)
    getCurrentFuncRunningLoop()->stat->incrementLoopsUnrolled();
}

void Stats::incrementInstructionsFolded(){
  if(getCurrentFuncRunningLoop()==NULL && stack.size())
    getRunningFunction()->stat->incrementInstructionsFolded();
  else if(getCurrentFuncRunningLoop()!=NULL)
    getCurrentFuncRunningLoop()->stat->incrementInstructionsFolded();
}
    
void Stats::incrementLoopsRerolledBack(){
  if(getCurrentFuncRunningLoop()==NULL && stack.size())
    getRunningFunction()->stat->incrementLoopsRerolledBack();
  else if(getCurrentFuncRunningLoop()!=NULL)
    getCurrentFuncRunningLoop()->stat->incrementLoopsRerolledBack();
}


void Stats::functionCall(Function *child) {
  FunctionStats *stat = new FunctionStats(child, count++);
  if(stack.size())
    getRunningFunction()->addChild(stat);
  stack.push_back(stat);
}

inline FunctionStats *Stats::getRunningFunction() {
  if(!stack.size()) {
    debug(Yes) << "stats: no running function\n";
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
  debug(Yes) << "getRunningLoop: returned NULL\n";
  return NULL;
}

LoopStats *Stats::getCurrentFuncRunningLoop() {
   if(stack.size()){
     if(stack[stack.size()-1]->loops.size())
        return stack[stack.size()-1]->loops[stack[stack.size()-1]->loops.size()-1];
   }
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
  debug(Yes)<<"getLoopTime() in stats\n";
  
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

  unsigned libCallsSimplified=0;
  unsigned loadsFolded=0;
  unsigned totalLoads=0;
  unsigned totalLibCalls=0;
  unsigned functionsCloned=0;
  unsigned loopsUnrolled=0;
  unsigned instructionsFolded=0;
  unsigned totalFunctionCalls=0;
  unsigned loopsRerolledBack=0;
  unsigned totalLoops=0;

  for(int i=0;i<stack.size();i++)
  {
   functionReturn();
  }

  vector<FunctionStats*> eraseFunctions;
  for(auto &func:processed){
     Function * function = func->getFunction();
     if(functionsToRemove.find(function)!=functionsToRemove.end())
        eraseFunctions.push_back(func);
  } 
     

  for(unsigned i=0;i<eraseFunctions.size();i++){
     processed.erase(eraseFunctions[i]);
   }

  functionsCloned = processed.size() - 1; 

  for(auto &func: processed) {
      debug(Yes)<<func->getFunction()->getName()<<"\n";
      libCallsSimplified = libCallsSimplified + func->stat->getLibCallsFolded();
      loadsFolded = loadsFolded + func->stat->getLoadsFolded();
      totalLoads = totalLoads + func->stat->getTotalLoads();
      totalLibCalls = totalLibCalls + func->stat->getTotalLibCalls();
      loopsUnrolled = loopsUnrolled + func->stat->getLoopsUnrolled();
      instructionsFolded = instructionsFolded + func->stat->getInstructionsFolded();
      totalFunctionCalls = totalFunctionCalls + func->stat->getFunctionCalls();
      loopsRerolledBack = loopsRerolledBack + func->stat->getLoopsRerolledBack();
      totalLoops = totalLoops + func->stat->getTotalLoops();
      for(auto &loop: func->loops){
         libCallsSimplified = libCallsSimplified + loop->stat->getLibCallsFolded();
         loadsFolded = loadsFolded + loop->stat->getLoadsFolded();
         totalLoads = totalLoads + loop->stat->getTotalLoads();
         totalLibCalls = totalLibCalls + loop->stat->getTotalLibCalls();
         loopsUnrolled = loopsUnrolled + loop->stat->getLoopsUnrolled();
         instructionsFolded = instructionsFolded + loop->stat->getInstructionsFolded();
         totalFunctionCalls = totalFunctionCalls + loop->stat->getFunctionCalls();
         loopsRerolledBack = loopsRerolledBack + loop->stat->getLoopsRerolledBack();
         totalLoops = totalLoops + loop->stat->getTotalLoops();

     }
   }
  
  debug(Yes)<<"==================|Stats|===================="<<"\n";
  debug(Yes)<<"# LibCalls Simplified: "<<libCallsSimplified<<"\n";
  debug(Yes)<<"# Total LibCalls: "<<totalLibCalls<<"\n";
  debug(Yes)<<"# Loads Folded: "<<loadsFolded<<"\n";
  debug(Yes)<<"# Total Loads Encountered: "<< totalLoads<<"\n";
  debug(Yes)<<"# Function Calls Analyzed: "<<count<<"\n";
  debug(Yes)<<"# Functions Cloned: "<<functionsCloned<<"\n";
  debug(Yes)<<"# Total Loops: "<<totalLoops<<"\n";
  debug(Yes)<<"# Loops Unrolled: "<<loopsUnrolled<<"\n";
  debug(Yes)<<"# Loops RerolledBack: "<<loopsRerolledBack<<"\n";
  debug(Yes)<<"# Instructions Folded: "<<instructionsFolded<<"\n";
  std::ofstream StatFile;
  StatFile.open("constStats.JSON");
  StatFile<<"{ \"LibCallsSimplified\": "<<libCallsSimplified<<", \"TotalLibCalls\":"<<totalLibCalls<<", \"LoadsFolded\":"<<loadsFolded<<",\"TotalLoadsEncountered\":"<<totalLoads<<", \"FunctionCallsAnalyzed\":"<<count<<",\"FunctionsCloned\":"<<functionsCloned<<",\"TotalLoopsEncountered\":"<<totalLoops<<",\"LoopsUnrolled\":"<<loopsUnrolled<<",\"LoopsRerolledBack\":"<<loopsRerolledBack<<",\"InstructionsFolded\":"<<instructionsFolded<<"}";
  StatFile.close();


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
  debug(Yes) << str << "\n";
}

newStats::newStats() {
  libCallsSimplified = 0;
  loadsFolded = 0;
  totalLoads = 0;
  totalLibCalls = 0;
  loopsUnrolled = 0;
  instructionsFolded = 0;
  totalFunctionCalls = 0;
  loopsRerolledBack = 0;
  totalLoops = 0;
}

void newStats::incrementLibCallsFolded(){ libCallsSimplified++; }
void newStats::incrementTotalLoads(){ totalLoads++; }
void newStats::incrementLoadsFolded(){ loadsFolded++; }
void newStats::incrementTotalLibCalls(){ totalLibCalls++; }
void newStats::incrementLoopsUnrolled() { loopsUnrolled++; } 
void newStats::incrementInstructionsFolded(){ instructionsFolded++; }
void newStats::incrementFunctionCalls(){totalFunctionCalls++;}
void newStats::incrementLoopsRerolledBack(){loopsRerolledBack++;}
void newStats::incrementTotalLoops(){ totalLoops++; }

unsigned newStats::getLibCallsFolded(){ return libCallsSimplified; }
unsigned newStats::getTotalLoads(){ return totalLoads; }
unsigned newStats::getLoadsFolded(){ return loadsFolded; }
unsigned newStats::getTotalLibCalls(){ return totalLibCalls; }
unsigned newStats::getLoopsUnrolled() { return loopsUnrolled; } 
unsigned newStats::getInstructionsFolded(){ return instructionsFolded; }
unsigned newStats::getFunctionCalls(){return totalFunctionCalls;}
unsigned newStats::getLoopsRerolledBack(){return loopsRerolledBack;}
unsigned newStats::getTotalLoops(){ return totalLoops; }

bool FunctionStats::getLoopTime(uint64_t &seconds) {
  debug(Yes)<<"getLoopTime(seconds) \n";
  return getRunningLoop()->getLoopTime(seconds);
}

FunctionStats::FunctionStats(Function *f, unsigned id) {
  this->f = f;
  this->id = id;
  this->stat = new newStats(); 
  startTime = chrono::system_clock::now();
}

void FunctionStats::functionReturn() {
  endTime = chrono::system_clock::now();
  
}

void FunctionStats::loopStart(BasicBlock *BB) {
  debug(Yes) << "pushing new loop " << BB->getName() << "for function " << this->f->getName() << "\n";
  loops.push_back(new LoopStats(BB));
}

void FunctionStats::setFunction(Function *f) {
  this->f = f;
}

inline LoopStats *FunctionStats::getRunningLoop() {
  int i;
  assert(loops.size());
  debug(Yes) << "loop size:" << loops.size() << "\n";

  i = loops.size() -1;

  loops[i]->hasLoopTerminated();

  debug(Yes) << " i " << i << "\n";
  return loops[i];
}

void FunctionStats::loopSuccess() {
  debug(Yes)<<"loopSuccess() in stats\n";
  getRunningLoop()->loopSuccess();   
}

void FunctionStats::loopFail() {
  debug(Yes)<<"loopFail() in stats\n";
  LoopStats *pop = loops.back();
  pop->loopFail();
  loops.pop_back();
  failedLoops.insert(pop);
    
}

Function *FunctionStats::getFunction() {
  return f;
}

void FunctionStats::printStats() {
  debug(Yes) << "Function Name: " << getFunction()->getName() << " time: " << getRunTime() << "\n";
  for(auto &loop: loops) {
    debug(Yes) << "           Loop BB header: " << loop->getHeader()->getName() << " time: " << loop->getRunTime() << "\n";
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
  stat = new newStats();
  startTime = chrono::system_clock::now();
}

void LoopStats::loopSuccess() {
  terminated = true;
  passed = true;
  endTime = chrono::system_clock::now();
}

void LoopStats::loopFail() {
  terminated = true;
  passed = false;
  endTime = chrono::system_clock::now();
}

BasicBlock *LoopStats::getHeader() {
  return header;
}

inline bool LoopStats::hasLoopTerminated() {
  return terminated;
}

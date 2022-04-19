/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

/* This is the main header file for statistics.It consists of classes that keep track of statistics and print statistics such as 
total loads, function cloned, loop unrolled etc. Fo example incrementFunctionCloned()of class Stat is called whenever we clone a function.
The methods of class Stat are defined in src/Stats.cpp.*/

#ifndef STAT_H
#define STAT_H

#include "llvm/IR/Function.h"
#include "llvm/Analysis/LoopPass.h"

#include <string>
#include <unordered_map>
#include <chrono>
#include <set>

using namespace std;
using namespace llvm;


template<class T>
class StatNode {
  public:
    vector<T> children;
    void addChild(T val) {
      children.push_back(val); 
    }
};

class StatItem {
  public:
    chrono::system_clock::time_point startTime;
    chrono::system_clock::time_point endTime;
    time_t getRunTime() {
      auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(endTime - startTime);
      return duration.count();
    }
};

class newStats {
  private:
    unsigned libCallsSimplified;
    unsigned loadsFolded;
    unsigned totalLoads;
    unsigned totalLibCalls;
    unsigned loopsUnrolled;
    unsigned instructionsFolded;
    unsigned totalFunctionCalls;
    unsigned loopsRerolledBack;
    unsigned totalLoops;
  public:
    newStats();
    void incrementLibCallsFolded();
    void incrementTotalLoads();
    void incrementLoadsFolded();
    void incrementTotalLibCalls();
    void incrementFunctionCalls();
    void incrementLoopsUnrolled();
    void incrementInstructionsFolded();
    void incrementLoopsRerolledBack();
    void incrementTotalLoops();
    

    unsigned getLibCallsFolded();
    unsigned getTotalLoads();
    unsigned getLoadsFolded();
    unsigned getTotalLibCalls();
    unsigned getFunctionCalls();
    unsigned getLoopsUnrolled();
    unsigned getTotalLoops();
    unsigned getInstructionsFolded();
    unsigned getLoopsRerolledBack();

};


class LoopStats: public StatItem {
  private:
    BasicBlock *header;
    bool terminated;
    bool passed;

  public:
    newStats *stat;
    LoopStats(BasicBlock *);
    void loopSuccess();
    void loopFail();
    BasicBlock *getHeader();
    inline bool hasLoopTerminated();

    bool getLoopTime(uint64_t &);
};

class FunctionStats: public StatNode<FunctionStats*>, public StatItem {
  private:
    unsigned id;
    Function *f;
  public:
    newStats *stat;
    vector<LoopStats *> loops;
    set<LoopStats *> failedLoops;
    inline LoopStats *getRunningLoop();
    FunctionStats(Function *, unsigned);
    void functionReturn();
    void loopStart(BasicBlock *); 
    void loopSuccess();
    void loopFail();
    void setFunction(Function *);
    void printStats();
    Function *getFunction();
    void makeGraph(string &str);
    string getLabels();

    bool getLoopTime(uint64_t &);
};

class Stats {
  private:
    unsigned count;
    inline FunctionStats *getRunningFunction();
    LoopStats *getRunningLoop();
    LoopStats *getCurrentFuncRunningLoop();
    vector<FunctionStats *> stack;
    set<FunctionStats *> processed;
    set<Function *> functionsToRemove;
    void printStats(FunctionStats*);   
  public:
    Stats();
    void functionCall(Function *);
    void functionReturn();
    void swapFunction(Function *, Function *);
    void loopStart(BasicBlock *);
    void loopSuccess();
    void loopFail();
    void printStats(Function *);
    void removeFunctions(set<Function*>);
    void makeGraph(Function *);

    bool getLoopTime(uint64_t &);

    void incrementLibCallsFolded();
    void incrementTotalLoads();
    void incrementLoadsFolded();
    void incrementTotalLibCalls();
    void incrementFunctionCalls();
    void incrementLoopsUnrolled();
    void incrementInstructionsFolded();
    void incrementLoopsRerolledBack();
    void incrementTotalLoops();
     
};



#endif

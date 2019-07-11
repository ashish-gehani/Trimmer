#ifndef STAT_H
#define STAT_H

#include "llvm/IR/Function.h"

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

class LoopStats: public StatItem {
  private:
    BasicBlock *header;
    bool terminated;
    bool passed;
  public:
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
    vector<LoopStats *> loops;
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
    vector<FunctionStats *> stack;
    set<FunctionStats *> processed;
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
    void makeGraph(Function *);

    bool getLoopTime(uint64_t &);
};

#endif

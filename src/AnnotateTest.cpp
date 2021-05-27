// Copyright (c) 2020 SRI International All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

//This pass is used to test annotation pass.

#include "AnnotateTest.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Instructions.h"
#include <set>
#include <string>
#include "llvm/IR/Constant.h"
#include "llvm/IR/Constants.h"

using namespace llvm;
using namespace std;

char AnnotateTest::ID = 0;
static RegisterPass<AnnotateTest> X("annot-test", "Annotations Test", false, false);

void AnnotateTest::getTrackedVariables(set<Value *> &tracked, Module &M) {
  for(auto &F: M) {
    for(auto &BB: F) {
      for(auto &I: BB) {
        if(I.getMetadata("track"))
          tracked.insert(&I);
      }
    }
  }

  for(auto it = M.global_object_begin(), end = M.global_object_end(); it != end; it++)
    if(!dyn_cast<Function>(&*it))
      tracked.insert(&*it);
}

void AnnotateTest::getCheckValues(Value *user, set<Value *> &toCheck) {
  Value *current = NULL;
  if(auto call = dyn_cast<CallInst>(user)) {
    if(call->getCalledFunction()->getName() == "llvm.var.annotation")
      current = dyn_cast<User>(user)->getOperand(0);
    else
      current = user;
  }else {
    return;
  }
  vector<Value *> worklist;
  set<Value *> processed;

  worklist.push_back(current);
  while(worklist.size()) {
    Value *current = worklist.back();
    worklist.pop_back();

    if(processed.find(current) != processed.end())
      continue;

    //errs() << *current << "asdasd \n";
    processed.insert(current);

    if(dyn_cast<AllocaInst>(current) || dyn_cast<GlobalVariable>(current)) {
      toCheck.insert(current);
      break;
    }

    if(auto call = dyn_cast<CallInst>(current)) {
      if(call->getCalledFunction()->getName() == "malloc") {
        toCheck.insert(current);
        break;
      }
    }
    User *user = dyn_cast<User>(current);
    if(!user)
      continue;
    for(unsigned i = 0; i < user->getNumOperands(); i++) {
      worklist.push_back(user->getOperand(i));
    }
  }
}

bool AnnotateTest::runOnModule(Module &M) {
  set<Value*> tracked;   
  set<Value *> toCheck;
  getTrackedVariables(tracked, M);

  Function *f = M.getFunction("llvm.var.annotation");
  if(f)
      for(auto use: f->users()) {
        if(dyn_cast<Function>(use))
          continue;
        getCheckValues(use, toCheck);
      }

  f = M.getFunction("malloc");
  if(f)
      for(auto use: f->users()) {
        if(dyn_cast<Function>(use))
          continue;
        getCheckValues(use, toCheck);
      }

  for(auto &check: toCheck) {
      errs() << *check << " checking \n";
    if(tracked.find(check) == tracked.end()) {
      errs() << *check << " not found! " << "\n";
      errs() << "Test failed" << "\n";
      return false;
    }
  }

  errs() << "Test passed" << "\n";
  return false;
  Constant* expected = M.getNamedGlobal("llvm.global.annotations")->getInitializer();
  ArrayType *ty = dyn_cast<ConstantArray>(expected)->getType();
  for(unsigned i = 0; i < ty->getNumElements(); i++) {
    Constant *ele = expected->getAggregateElement(i);
    errs() << *ele << "\n";
    GetElementPtrInst *temp = dyn_cast<GetElementPtrInst>(dyn_cast<ConstantExpr>(ele)->getAsInstruction());
    Constant *val =  dyn_cast<Constant>(temp->getPointerOperand());
    temp->dropAllReferences();
    string a = dyn_cast<ConstantDataArray>(dyn_cast<GlobalVariable>(val)->getInitializer())->getAsString();
    bool found = false;
    for(auto &track: tracked) {
      if(track->getName() == a.substr(0, a.size() - 1)) {
        //errs() << "found " << track->getName() << " -> " << a.substr(0, a.size() - 1) << "\n";
        found = true;
        break;
      }
    }

    if(!found) {
      errs() << a << " not found! " << "\n";
      errs() << "Test failed" << "\n";
      return false;
    }
  }

  errs() << "Test passed" << "\n";
  return false;

  return false;
}

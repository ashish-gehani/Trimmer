/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

// This file consistof a method for parsing comma-separated arguments provided to the SpecializeArguments Pass into a vector. 

#include <string> 
using namespace std;
using namespace llvm;

#define MaxArgs 10


vector<string> parse_args(string s) {
    string temp = "";
    vector<string> ret;
    for(unsigned i = 0; i < s.size(); i++) {
        if(s[i] == ' ') {
            ret.push_back(temp);
            temp = "";
        } else
            temp += s[i];   
    }
    ret.push_back(temp);
    return ret;
} 


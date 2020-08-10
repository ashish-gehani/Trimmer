/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#ifndef FD_INST_INFO_H
#define FD_INST_INFO_H
# include <stdio.h>
# include "llvm/IR/Instruction.h"
/*
 * The structure used for tracking File IO instructions

*/
struct FileInsts {
  vector<Instruction *> insts; // collection of fileIO instructions which are specialized
  vector<Instruction*> insertedSeekCalls;//seek calls inserted on behalf of reads
  bool isSpecialized; // tracks whether the file is completely specialized or not
};

#endif

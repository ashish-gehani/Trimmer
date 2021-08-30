// Copyright (c) 2020 SRI International All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/*This file contains methods for Basic Block context such as duplicating/imaging context. ContextInfo contains memory, a boolean variable deleted and a pointer
to the context information of the Basic Block it is equal to (if it is).*/

#include "ContextInfo.h"
ContextInfo::ContextInfo() {
  deleted = false;
  imageOf = NULL;
}

ContextInfo::ContextInfo(Module * M) {
  deleted = false;
  imageOf = NULL;
  memory = new Memory(M);    
}

ContextInfo *ContextInfo::image() {
  ContextInfo * nci = new ContextInfo();
  nci->memory = memory;
  if(imageOf) {
    nci->imageOf = imageOf;
  } else {
    nci->imageOf = this;
  }
  return nci;        
}

ContextInfo * ContextInfo::duplicate() {
  ContextInfo * nci = new ContextInfo();
  nci->memory = new Memory(*memory);
  return nci;
}

/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

/* this is the main header file for getOptLocal. It  contains getopt functions which actually imitate functionality of the getopt function in getopt.h.
All the methods are defined in src/GetOptLocal.cpp.*/

#include <string>
#include <unistd.h>
#include <getopt.h>

extern string err_local;

int getopt_local(int argc, char ** argv, char * opts);

int getopt_long_local(int argc, char ** argv, char * opts, struct option * long_opts, int * long_index); 

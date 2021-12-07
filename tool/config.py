# Copyright (c) 2020 SRI International All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

"""
This file consists of a function env_version, which gets the environmental variables ( such as those mentioned in the readme.md file) set by the user.
In case environmental variables are not set by user, it uses default value mentioned in env dictionary.





"""

import os
import platform
import sys




env = { 'clang'      :  'LLVM_CC_NAME',
	'clang++'    :  'LLVM_CXX_NAME',
	'llvm-link'  :  'LLVM_LINK_NAME',
	'llvm-dis'   :  'LLVM_DIS_NAME',
	'llvm-ar'    :  'LLVM_AR_NAME',
	'llvm-as'    :  'LLVM_AS_NAME',
	'llvm-ld'    :  'LLVM_LD_NAME',
	'llc'        :  'LLVM_LLC_NAME',
	'opt'        :  'LLVM_OPT_NAME',
	'llvm-nm'    :  'LLVM_NM_NAME',
	'clang-cpp'  :  'LLVM_CPP_NAME'}

def env_version(name):
	""" Returns the tool as defined in the user's environment.
	"""
	env_name = None
	if name in env:
		env_name = os.getenv(env[name])
	return env_name if env_name else name

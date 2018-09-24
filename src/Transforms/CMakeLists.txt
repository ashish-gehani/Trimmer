add_library(ConstantFolding MODULE
  ../Utils.cpp
  ../StringUtils.cpp
  ../BBOps.cpp
  ../Debug.cpp
  ConstantFolding.cpp
  ../VecUtils.cpp
  ../GetOptLocal.cpp
  ../RegOps.cpp
  ../LoopUnroller.cpp
  )
add_library(Internalize MODULE
  Internalize.cpp
  )
add_library(TestPass MODULE
  TestPass.cpp
  )
add_library(Annotate MODULE
  Annotate.cpp
  ../Debug.cpp
  ../VecUtils.cpp
  )
add_library(SpecializeArguments MODULE
  SpecializeArguments.cpp
  )
add_library(Remove MODULE
  Remove.cpp
  )
add_library(AnnotateConfig MODULE
  ../Utils.cpp
  ../StringUtils.cpp
  ../BBOps.cpp
  ../Debug.cpp
  ConstantFolding.cpp
  ../VecUtils.cpp
  ../GetOptLocal.cpp
  ../RegOps.cpp
  ../LoopUnroller.cpp
  AnnotateConfig.cpp
  )
#[[
add_library(RemFuncBody MODULE
  RemFuncBody.cpp
  )
]]
add_library(ListFunctions MODULE
  ListFunctions.cpp
  )
add_library(AnnotateNew MODULE
  AnnotateNew.cpp
  )


# Use C++11 to compile your pass (i.e., supply -std=c++11).
target_compile_features(ConstantFolding PRIVATE cxx_range_for cxx_auto_type)
target_compile_features(Internalize PRIVATE cxx_range_for cxx_auto_type)
target_compile_features(TestPass PRIVATE cxx_range_for cxx_auto_type)
target_compile_features(Annotate PRIVATE cxx_range_for cxx_auto_type)
target_compile_features(SpecializeArguments PRIVATE cxx_range_for cxx_auto_type)
target_compile_features(Remove PRIVATE cxx_range_for cxx_auto_type)
#target_compile_features(RemFuncBody PRIVATE cxx_range_for cxx_auto_type)
target_compile_features(ListFunctions PRIVATE cxx_range_for cxx_auto_type)
target_compile_features(AnnotateConfig PRIVATE cxx_range_for cxx_auto_type)
target_compile_features(AnnotateNew PRIVATE cxx_range_for cxx_auto_type)

# LLVM is (typically) built with no C++ RTTI. We need to match that;
# otherwise, we'll get linker errors about missing RTTI data.
set_target_properties(ConstantFolding Internalize TestPass Annotate SpecializeArguments Remove ListFunctions AnnotateConfig #RemFuncBody 
  PROPERTIES
  COMPILE_FLAGS "-fPIC -D__GLIBCXX_USE_CXX11_ABI=0 -fno-rtti -g"
  LINK_FLAGS "-rdynamic"
  ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/"
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/"
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/"
  PREFIX ""
  )

set_target_properties(AnnotateNew
  PROPERTIES
  COMPILE_FLAGS "-fPIC -fno-rtti -g"
  LINK_FLAGS "-rdynamic -lLLVMSvf"
  ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/"
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/"
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/"
  PREFIX ""
  )
#[[
#add_library(LLVMSvf STATIC IMPORTED)


set_target_properties(LLVMSvf 
    PROPERTIES
    IMPORTED_LOCATION /usr/local/lib/libLLVMSvf.a)

]]
target_link_libraries(AnnotateNew LLVMSvf LLVMCudd)
# Get proper shared-library behavior (where symbols are not necessarily
# resolved when the shared library is linked) on OS X.
if(APPLE)
  set_target_properties(ConstantFolding Internalize TestPass Annotate SpecializeArguments 
    PROPERTIES
    LINK_FLAGS "-undefined dynamic_lookup"
    )
endif(APPLE)

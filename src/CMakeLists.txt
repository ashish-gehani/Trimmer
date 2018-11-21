add_library(AnnotateTest MODULE
  AnnotateTest.cpp   
  )
target_compile_features(AnnotateTest PRIVATE cxx_range_for cxx_auto_type)

set_target_properties(AnnotateTest
  PROPERTIES
  COMPILE_FLAGS "-fPIC -D__GLIBCXX_USE_CXX11_ABI=0 -fno-rtti -g"
  LINK_FLAGS "-rdynamic"
  ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/"
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/"
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/"
  PREFIX ""
  )


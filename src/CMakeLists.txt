add_library(ConstantFolding MODULE
    # List your source files here.
    Utils.cpp
    StringUtils.cpp
    BBOps.cpp
    Debug.cpp
    VecUtils.cpp
    ConstantFolding.cpp
    getopt_local.cpp
    )

# Use C++11 to compile your pass (i.e., supply -std=c++11).
target_compile_features(ConstantFolding PRIVATE cxx_range_for cxx_auto_type)

# LLVM is (typically) built with no C++ RTTI. We need to match that;
# otherwise, we'll get linker errors about missing RTTI data.
set_target_properties(ConstantFolding PROPERTIES
  COMPILE_FLAGS "-fPIC -D__GLIBCXX_USE_CXX11_ABI=0"
  LINK_FLAGS "-rdynamic -Wl,--no-undefined"
    )

# Get proper shared-library behavior (where symbols are not necessarily
# resolved when the shared library is linked) on OS X.
if(APPLE)
  set_target_properties(ConstantFolding PROPERTIES
    LINK_FLAGS "-undefined dynamic_lookup"
        )
endif(APPLE)

#!/bin/bash

TARGET_DIR=$HOME/working/build-llvm
if [ -d "$TARGET_DIR" ]; then
  # Control will enter here if $DIRECTORY exists.
	cd $TARGET_DIR
#	cmake -P "$SRC_ROOT/cmake/modules/CheckAtomic.cmake" \
	cmake -DCMAKE_OSX_ARCHITECTURES=x86_64 \
\#	-DLIBCXX_HAVE_CXX_ATOMICS_WITHOUT_LIB=ON \
	-DCMAKE_INSTALL_PREFIX="$HOME/working/install-llvm -P cmake_install.cmake" \
	-DPOLLY_ENABLE_GPGPU_CODEGEN=ON \
	-DCMAKE_C_FLAGS="-DOPENMP_NVPTX_COMPUTE_CAPABILITY=37" \
	-DCMAKE_CXX_FLAGS="-std=c++14 -stdlib=libc++ -I/usr/include/c++/5.4.0 -DOPENMP_NVPTX_COMPUTE_CAPABILITY=37" \
\#	-DCMAKE_CXX_FLAGS="-std=c++14 -DOPENMP_NVPTX_COMPUTE_CAPABILITY=37" \
\#	-DLIBOMP_CFLAGS="-stdlib=libc++" \
	-DCMAKE_BUILD_TYPE=Debug \
	-DLLVM_ENABLE_ASSERTIONS=ON \
	-DLLVM_ENABLE_WERROR=ON \
	-DLLVM_ENABLE_BACKTRACES=ON \
	-DBUILD_SHARED_LIBS=OFF \
	-DLIBOMPTARGET_NVPTX_COMPUTE_CAPABILITY=37 \
\#	-DCMAKE_C_COMPILER=$OBJ_ROOT/usr/local/bin/clang \
	-DCMAKE_C_COMPILER=$(which gcc) \
\#	-DCMAKE_CXX_COMPILER=$OBJ_ROOT/usr/local/bin/clang++ \
	-DCMAKE_CXX_COMPILER=$(which g++) \
	-DCMAKE_MAKE_PROGRAM=$(which make) \
	-DLLVM_ENABLE_LIBCXX=ON \
	-DCMAKE_OSX_ARCHITECTURES=x86_64 \
	-DCMAKE_CXX_STANDARD_REQUIRED=ON \
	-DCMAKE_CXX_EXTENSIONS=ON \
	-DCHECK_CXX_SOURCE_COMPILES=ON \
\#	-DLIBCXX_CXX_ABI=libsupc++ \
\#	-DLIBCXX_LIBSUPCXX_INCLUDE_PATHS="/usr/include/c++/5.4.0/;/usr/lib/x86_64-linux-gnu/" \
	-DCHECK_CXX_SOURCE_COMPILES=ON \
	-G "Unix Makefiles" \
	$HOME/working/llvm
else
	echo "can't find the directory $TARGET_DIR"
fi


if [ -d "$WORKING_PATH" ]; then
	TARGET_DIR=$WORKING_PATH/build-llvm-ykt
	if [ -d "$TARGET_DIR" ]; then
	  # Control will enter here if $DIRECTORY exists.
		cd $TARGET_DIR
		cmake -DCMAKE_OSX_ARCHITECTURES=x86_64 \
		-DCMAKE_ASM_COMPILER=$(which cc) \
		-DCMAKE_C_FLAGS="-DOPENMP_NVPTX_COMPUTE_CAPABILITY=37" \
		-DLIBOMP_CFLAGS="-stdlib=libc++" \
		-DCMAKE_CXX_FLAGS="-std=c++11 -stdlib=libc++ -DOPENMP_NVPTX_COMPUTE_CAPABILITY=37" \
		-DCMAKE_BUILD_TYPE=DEBUG \
		-DCMAKE_INSTALL_PREFIX=$WORKING_PATH/install-llvm-ykt -P cmake_install.cmake \
		-DCMAKE_CXX_STANDARD_REQUIRED=ON \
		-DCMAKE_C_COMPILER=$OBJ_ROOT/bin/clang \
		-DCMAKE_CXX_COMPILER=$OBJ_ROOT/bin/clang++ \
		-DCMAKE_MAKE_PROGRAM=$(which make) \
		-DCMAKE_CXX_EXTENSIONS=ON \
		-DCMAKE_CXX_COMPILER_FLAGS="-L -std=c++11" \
		-DLLVM_ENABLE_ASSERTIONS=ON \
		-DLLVM_ENABLE_WERROR=ON \
		-DLLVM_ENABLE_BACKTRACES=ON \
		-DLLVM_ENABLE_LIBCXX=ON \
		-DBUILD_SHARED_LIBS=OFF \
		-DLIBOMPTARGET_NVPTX_COMPUTE_CAPABILITY=37 \
		-DCHECK_CXX_SOURCE_COMPILES=ON \
		-G "Unix Makefiles" \
		$HOME/working/llvm-ykt
	else
		echo "can't find the directory \$TARGET_DIR"
	fi;
else
	echo "can't find directory \$WORKING_PATH"
fi;

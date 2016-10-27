CMAKE=$1	# /opt/cmake/bin/cmake
CUDA_PATH=$2	#"/opt/nvidia/cuda"
if [ -f "$CMAKE" ]; then
	if [ -d "$CUDA_PATH" ]; then
		if [ -d "$WORKING_PATH" ]; then
			TARGET_DIR=$WORKING_PATH/build-llvm-ykt
			if [ -d "$TARGET_DIR" ]; then
			  # Control will enter here if $DIRECTORY exists.
				cd $TARGET_DIR

		#		cmake -DCMAKE_INSTALL_PREFIX=$WORKING_PATH/install-llvm-ykt -P cmake_install.cmake \
				$CMAKE -DCMAKE_INSTALL_PREFIX="$WORKING_PATH/install-llvm-ykt" \
				-DCMAKE_OSX_ARCHITECTURES=x86_64 \
				-DCMAKE_ASM_COMPILER=$(which cc) \
				-DCUDA_TOOLKIT_ROOT_DIR="$CUDA_PATH" \
				-DCMAKE_C_FLAGS="-DOPENMP_NVPTX_COMPUTE_CAPABILITY=30" \
				-DLIBOMP_CFLAGS="-stdlib=libc++" \
				-DCMAKE_CXX_FLAGS="-std=c++11 -stdlib=libc++ -DOPENMP_NVPTX_COMPUTE_CAPABILITY=30" \
				-DCMAKE_BUILD_TYPE=DEBUG \
				-DCMAKE_CXX_STANDARD_REQUIRED=ON \
				-DCMAKE_C_COMPILER=$(which clang) \
				-DCMAKE_CXX_COMPILER=$(which clang++) \
				-DCMAKE_MAKE_PROGRAM=$(which make) \
				-DCMAKE_CXX_EXTENSIONS=ON \
				-DCMAKE_CXX_COMPILER_FLAGS="-L -std=c++11" \
				-DCMAKE_CXX_LINK_FLAGS="-L${HOST_GCC}/lib64 -Wl,-rpath,${HOST_GCC}/lib64" \
				-DLLVM_ENABLE_ASSERTIONS=ON \
				-DLLVM_ENABLE_WERROR=ON \
				-DLLVM_ENABLE_BACKTRACES=ON \
				-DLLVM_ENABLE_LIBCXX=ON \
				-DBUILD_SHARED_LIBS=OFF \
				-DLIBOMPTARGET_NVPTX_COMPUTE_CAPABILITY=30 \
				-DCHECK_CXX_SOURCE_COMPILES=ON \
				-G "Unix Makefiles" \
				$WORKING_PATH/llvm-ykt
			else
				echo "Can't find the directory \$TARGET_DIR"
			fi;
		else
			echo "Can't find directory \$WORKING_PATH"
		fi;
	else
		echo "Cuda path has not provided from arguments list."
	fi;
else
	echo "Give where CMake is at first, please"
fi;

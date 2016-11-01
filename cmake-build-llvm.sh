CMAKE=$1	# "/opt/cmake/bin/cmake"
CUDA_PATH=$2	# "/opt/nvidia/cuda"
RELATIVE_SOURCE_PATH=$3	# "llvm-bit"
HOST_GCC=$4		# ""
if [ -f "$CMAKE" ]; then
	if [ -d "$CUDA_PATH" ]; then
		if [ -d "$WORKING_PATH" ]; then
			if ! [ "$RELATIVE_SOURCE_PATH" = "" ]; then
				cd "$WORKING_PATH"
				if ! [ -d "build-$RELATIVE_SOURCE_PATH" ]; then 
					mkdir "build-$RELATIVE_SOURCE_PATH" 
				fi;
				if ! [ -d "install-$RELATIVE_SOURCE_PATH" ]; then 
					mkdir "install-$RELATIVE_SOURCE_PATH" 
				fi;

				  # Control will enter here if $DIRECTORY exists.
				cd "build-$RELATIVE_SOURCE_PATH"
		#		cmake -DCMAKE_INSTALL_PREFIX="$WORKING_PATH/install-$RELATIVE_SOURCE_PATH -P cmake_install.cmake" \
				$CMAKE -DCMAKE_INSTALL_PREFIX="$WORKING_PATH/install-$RELATIVE_SOURCE_PATH" \
				-DCMAKE_OSX_ARCHITECTURES=x86_64 \
				-DCMAKE_ASM_COMPILER=$(which cc) \
				-DCUDA_TOOLKIT_ROOT_DIR="$CUDA_PATH" \
				-DCMAKE_C_FLAGS="-DOPENMP_NVPTX_COMPUTE_CAPABILITY=37" \
				-DLIBOMP_CFLAGS="-stdlib=libc++" \
				-DCMAKE_CXX_FLAGS="-std=c++11 -stdlib=libc++ -DOPENMP_NVPTX_COMPUTE_CAPABILITY=37" \
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
				-DLIBOMPTARGET_NVPTX_COMPUTE_CAPABILITY=37 \
				-DCHECK_CXX_SOURCE_COMPILES=ON \
				-G "Unix Makefiles" \
				"$WORKING_PATH/$RELATIVE_SOURCE_PATH"
			else
				echo "Give \$RELATIVE_SOURCE_PATH from argument 3"
			fi;
		else
			echo "Can't find directory \$WORKING_PATH"
		fi;
	else
		echo "Cuda path has not provided from arguments 2."
	fi;
else
	echo "Give where CMake location from argument 1, please"
fi;

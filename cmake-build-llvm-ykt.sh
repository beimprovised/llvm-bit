#!/bin/bash

BUILD_PATH=$PWD
CMAKE="$1"			# "/opt/cmake/bin/cmake"
ACCELERATOR_TOOLKIT="$2"	# "/opt/nvidia/cuda"
RELATIVE_SOURCE_PATH="$3"	# "llvm-bit"
PROJECT_TYPE="$4"		# "Unix Makefiles"
HOST_GCC="$5"			# ""
if [ -f "$CMAKE" ]; then
	if [ -d "$ACCELERATOR_TOOLKIT" ]; then
		if [ -d "$WORKING_PATH" ]; then
			if ! [ "$RELATIVE_SOURCE_PATH" = "" ]; then
				if ! [ "$PROJECT_TYPE" = "" ]; then
#					$PROJECT_TYPE="Unix Makefiles"
#				fi;

					cd "$WORKING_PATH"

#					if ! [ -d "build-$RELATIVE_SOURCE_PATH" ]; then 
#						mkdir "build-$RELATIVE_SOURCE_PATH" 
#					fi;
					if ! [ -d "install-$RELATIVE_SOURCE_PATH" ]; then 
						mkdir "install-$RELATIVE_SOURCE_PATH" 
					fi;

					  # Control will enter here if $DIRECTORY exists.
#					cd "build-$RELATIVE_SOURCE_PATH"
					cd "$BUILD_PATH"
					
					$CMAKE -DCMAKE_INSTALL_PREFIX:PATH="$WORKING_PATH/install-$RELATIVE_SOURCE_PATH" \
					-DCMAKE_OSX_ARCHITECTURES:STRING="x86_64" \
					-DCMAKE_ASM_COMPILER:FILEPATH="$(which clang)" \
					-DCUDA_TOOLKIT_ROOT_DIR:PATH="$ACCELERATOR_TOOLKIT" \
					-DCMAKE_C_FLAGS:STRING="-DOPENMP_NVPTX_COMPUTE_CAPABILITY=37" \
					-DLIBOMP_CFLAGS:STRING="-stdlib=libc++" \
					-DCMAKE_CXX_FLAGS:STRING="-std=c++11 -stdlib=libc++ -DOPENMP_NVPTX_COMPUTE_CAPABILITY=37" \
					-DCMAKE_BUILD_TYPE:STRING="Debug" \
					-DCMAKE_CXX_STANDARD_REQUIRED:BOOL=ON \
					-DCMAKE_C_COMPILER:FILEPATH="$(which clang)" \
					-DCMAKE_CXX_COMPILER:FILEPATH="$(which clang++)" \
					-DCMAKE_MAKE_PROGRAM:FILEPATH="$(which make)" \
					-DCMAKE_CXX_EXTENSIONS:BOOL=ON \
					-DCMAKE_CXX_LINK_FLAGS:STRING="-L${HOST_GCC}/lib64 -Wl,-rpath,${HOST_GCC}/lib64" \
					-DLLVM_ENABLE_ASSERTIONS:BOOL=ON \
					-DLLVM_ENABLE_WERROR:BOOL=ON \
					-DLLVM_ENABLE_BACKTRACES:BOOL=ON \
					-DLLVM_ENABLE_LIBCXX:BOOL=ON \
					-DBUILD_SHARED_LIBS:BOOL=ON \
					-DLLVM_ENABLE_LIBCXX:BOOL=ON ${IFS#//Use libc++ if available.}\
					-DLIBCXX_CXX_ABI:STRING="libcxxabi" \
					-DLLVM_TOOL_LIBCXXABI_BUILD:BOOL=ON ${IFS#//Whether to build libcxxabi as part of LLVM}\
					-DLLVM_TOOL_LIBCXX_BUILD:BOOL=ON ${IFS#//Whether to build libcxx as part of LLVM}\
					-DLLVM_EXTERNAL_LIBCXXABI_SOURCE_DIR:PATH="$WORKING_PATH/$RELATIVE_SOURCE_PATH/projects/libcxxabi"   ${IFS#//Path to libcxxabi source directory}\
					-DLLVM_EXTERNAL_LIBCXX_SOURCE_DIR:PATH="$WORKING_PATH/$RELATIVE_SOURCE_PATH/projects/libcxx"      ${IFS#//Path to libcxx source directory}\
					-DLIBOMPTARGET_NVPTX_COMPUTE_CAPABILITY:STRING="37" \
					-G "$PROJECT_TYPE" \
					"$WORKING_PATH/$RELATIVE_SOURCE_PATH";
#					make -j$(nproc);
#					cmake -DCMAKE_INSTALL_PREFIX:PATH="$WORKING_PATH/install-$RELATIVE_SOURCE_PATH" -P cmake_install.cmake; \
				else
					echo "Provide \$PROJECT_TYPE from argument 4."
				fi;
			else
				echo "Give \$RELATIVE_SOURCE_PATH from argument 3"
			fi;
		else
			echo "Can't find directory \$WORKING_PATH"
		fi;
	else
		echo "\$ACCELERATOR_TOOLKIT path has not provided from arguments 2."
	fi;
else
	echo "Give where CMake location from argument 1, please"
fi;

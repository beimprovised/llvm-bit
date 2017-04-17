echo "cmake config ..."


#PYTHON_PATH=$(which python)//"/bin/python"
#	-DPYTHON_EXECUTABLE:FILEPATH=$(which python) \
#	-DPYTHON_INCLUDE_DIR:PATH=$PYTHON_PATH \
#	-DPYTHON_LIBRARY:FILEPATH=$PYTHON_PATH/lib64 \
#	-DPYTHON_LIBRARY_DEBUG:FILEPATH=PYTHON_LIBRARY_DEBUG-NOTFOUND \

CMAKE=$1
RELATIVE_SOURCE_PATH=$2
BUILD_PATH_PREFIX=$3
INSTALL_PATH_PREFIX=$4
COMPILER_SWITCH=$5
CLANG_MAIN_VERSION=$6
ATOMIC_PATH=$7
PROJECT_TYPE=$8
#DOXYGEN_DOT_EXECUTABLE=$6 	#/usr/bin/dot
#DOXYGEN_EXECUTABLE=$7 		#/usr/bin/doxygen

if ! [ "$WORKING_PATH" = "" ] ; then

	if ! [ "$CMAKE" = "" ] ; then

		if ! [ "$RELATIVE_SOURCE_PATH" = "" ] ; then

			if ! [ "$BUILD_PATH_PREFIX" = "" ] ; then

				if ! [ "$INSTALL_PATH_PREFIX" = "" ] ; then
					CC=""
					CPP=""
					if ! [ "$COMPILER_SWITCH" = "" ]; then
						if [ "$COMPILER_SWITCH" = "gcc" ]; then
							CC="gcc"
							CPP="g++"
						fi;
						if [ "$COMPILER_SWITCH" = "clang" ]; then
							CC="clang"
							CPP="clang++"
						fi;

						if [[ ( "$CC" != "" ) && ( "$CPP" != "" ) ]]; then
                                                        if ! [ "$CLANG_MAIN_VERSION" = "" ]; then
								if ! [ "$ATOMIC_PATH" = "" ]; then
								if ! [ "$PROJECT_TYPE" = "" ]; then


#								if ! [ "$DOXYGEN_DOT_EXECUTABLE" = "" ] ; then
#	
#									if ! [ "$DOXYGEN_EXECUTABLE" = "" ] ; then

										if ! [ -d "$WORKING_PATH/$BUILD_PATH_PREFIX-$RELATIVE_SOURCE_PATH" ]; then
											mkdir "$WORKING_PATH/$BUILD_PATH_PREFIX-$RELATIVE_SOURCE_PATH"
										fi;
										if ! [ "$WORKING_PATH/$BUILD_PATH_PREFIX-$RELATIVE_SOURCE_PATH" = "$PWD" ]; then
											cd "$WORKING_PATH/$BUILD_PATH_PREFIX-$RELATIVE_SOURCE_PATH"
										fi;
										if [ "$PWD" = "$WORKING_PATH/$BUILD_PATH_PREFIX-$RELATIVE_SOURCE_PATH" ]; then
											$CMAKE -DCMAKE_INSTALL_PREFIX:PATH=$WORKING_PATH/$INSTALL_PATH_PREFIX-$RELATIVE_SOURCE_PATH \
											-DLLVM_PATH:PATH="$WORKING_PATH/$RELATIVE_SOURCE_PATH" \
											-DCMAKE_OSX_ARCHITECTURES:STRING="x86_64" \
											-DCMAKE_ASM_COMPILER_WORKS:INTERNAL=1 \
											-DLIBCXX_HAVE_CXX_ATOMICS_WITHOUT_LIB:INTERNAL=1 \
											-DCMAKE_ASM_COMPILER:FILEPATH="$(which $CC)" \
											-DCMAKE_MAKE_PROGRAM:FILEPATH="$(which make)" \
											-DCMAKE_CXX_STANDARD_REQUIRED:BOOL=TRUE \
											-DCMAKE_CXX_EXTENSIONS:BOOL=TRUE \
											-DCMAKE_SKIP_INSTALL_RPATH:BOOL=FALSE \
`#											-DCMAKE_CXX_LINK_FLAGS:STRING="-L${HOST_CC}/lib -L${ATOMIC_PATH} -Wl,-rpath,${HOST_CC}/lib -lc++ -lc++abi -latomic"` \
											-DCMAKE_CXX_LINK_FLAGS:STRING="-L$WORKING_PATH/$INSTALL_PATH_PREFIX-$RELATIVE_SOURCE_PATH/lib -L${ATOMIC_PATH} -Wl,-rpath,$WORKING_PATH/$INSTALL_PATH_PREFIX-$RELATIVE_SOURCE_PATH/lib -lc++ -lc++abi -latomic" \
											-DLLVM_ENABLE_ASSERTIONS:BOOL=TRUE \
											-DLLVM_ENABLE_WERROR:BOOL=TRUE \
											-DLLVM_ENABLE_BACKTRACES:BOOL=TRUE \
											-DLLVM_ENABLE_LIBCXX:BOOL=TRUE \
											-DBUILD_SHARED_LIBS:BOOL=TRUE \
											-DLLVM_ENABLE_LIBCXX:BOOL=TRUE ${IFS#//Use libc++ if available.}\
											-DLIBCXX_CXX_ABI:STRING="libcxxabi" \
											-DLIBCXXABI_LIBCXX_INCLUDES:PATH=$WORKING_PATH/$RELATIVE_SOURCE_PATH/projects/libcxx/include \
											-DLIBCXX_CXX_ABI_INCLUDE_PATHS:PATHS=$WORKING_PATH/$RELATIVE_SOURCE_PATH/projects/libcxx/include \
											-DLLVM_TOOL_LIBCXXABI_BUILD:BOOL=TRUE ${IFS#//Whether to build libcxxabi as part of LLVM}\
											-DLLVM_TOOL_LIBCXX_BUILD:BOOL=TRUE ${IFS#//Whether to build libcxx as part of LLVM}\
											-DLLVM_EXTERNAL_LIBCXXABI_SOURCE_DIR:PATH="$WORKING_PATH/$RELATIVE_SOURCE_PATH/projects/libcxxabi"   ${IFS#//Path to libcxxabi source directory}\
											-DLLVM_EXTERNAL_LIBCXX_SOURCE_DIR:PATH="$WORKING_PATH/$RELATIVE_SOURCE_PATH/projects/libcxx"      ${IFS#//Path to libcxx source directory}\
											-DPOLLY_ENABLE_GPGPU_CODEGEN:BOOL=TRUE \
											-DCMAKE_CXX_FLAGS:STRING="-std=c++11 -stdlib=libc++ -I$WORKING_PATH/$INSTALL_PATH_PREFIX-$RELATIVE_SOURCE_PATH/lib/clang/$CLANG_MAIN_VERSION.0.0/include -I$WORKING_PATH/$INSTALL_PATH_PREFIX-$RELATIVE_SOURCE_PATH/include/c++/v1" \
											-DCMAKE_C_FLAGS:STRING="-I$WORKING_PATH/$INSTALL_PATH_PREFIX-$RELATIVE_SOURCE_PATH/lib/clang/$CLANG_MAIN_VERSION.0.0/include -I$WORKING_PATH/$INSTALL_PATH_PREFIX-$RELATIVE_SOURCE_PATH/include/c++/v1" \
											-DCMAKE_C_COMPILER:FILEPATH=$(which $CC) \
											-DCMAKE_CXX_COMPILER:FILEPATH=$(which $CPP) \
											-DCMAKE_SHARED_LIBRARY_LINK_C_FLAGS:STRING="" \
											-DCMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS:STRING="" \
											-DLIBOMP_CFLAGS:STRING="-I$WORKING_PATH/$INSTALL_PATH_PREFIX-$RELATIVE_SOURCE_PATH/lib/clang/$CLANG_MAIN_VERSION.0.0/include -I$WORKING_PATH/$INSTALL_PATH_PREFIX-$RELATIVE_SOURCE_PATH/include/c++/v1" \
										`#	-DLIBOMP_USE_QUAD_PRECISION:BOOL=TRUE` \
									       	`#     	-DLLVM_ENABLE_DOXYGEN:BOOL=TRUE` \
									       	`#     	-DLLVM_BUILD_DOCS:BOOL=TRUE` \
									       	`#     	-DLLDB_DISABLE_PYTHON:BOOL=TRUE` \
									       	`#     	-DDOXYGEN_DOT_EXECUTABLE:FILEPATH=$DOXYGEN_DOT_EXECUTABLE` \
									       	`#     	-DDOXYGEN_EXECUTABLE:FILEPATH=$WORKING_PATH/$DOXYGEN_EXECUTABLE` `#install-doxygen/bin/doxygen` \
									       	`#     	-DLLDB_EXPORT_ALL_SYMBOLS:BOOL=TRUE` \
											-DCMAKE_BUILD_TYPE:STRING="Debug" \
											-G "$PROJECT_TYPE" \
											$WORKING_PATH/$RELATIVE_SOURCE_PATH; 
										else
											echo "Have not entered destination. Operation failed."
										fi;
#									else		
#										echo "Provide \$DOXYGEN_EXECUTABLE from argument 7, please."
#									fi;
#	
#								else
#									echo "Provide \$DOXYGEN_DOT_EXECUTABLE (just dot, not doxygen itself) from argument 6, please."
#								fi;
								else
									echo "Provide \$PROJECT_TYPE from argument 8."
								fi;

								else
									echo "Provide \$ATOMIC_PATH from argument 7."
								fi;
							else
								echo "Provide \$CLANG_MAIN_VERSION from argument 6."
							fi;

						else
							echo "Compiler type unkown, please check it again."
						fi;
					else
						echo "Provide \$COMPILER_SWITCH (e.g.: \"gcc\" or \"clang\") from argument 5, please."
					fi;
				else
					echo "Provide \$INSTALL_PATH_PREFIX from argument 4 (e.g.: \"install\"), please."
				fi;
			else
				echo "Provide \$BUILD_PATH_PREFIX from argument 3 (e.g.: \"build\"), please."
			fi;
		else
		    echo "Provide \$RELATIVE_SOURCE_PATH from argument 2 (e.g.: \"llvm\"), please."

		fi;
	else
	    echo "Provide \$CMAKE from argument 1, please."

	fi;
else
    echo "Export \$WORKING_PATH first."

fi;


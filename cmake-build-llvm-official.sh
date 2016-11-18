echo "cmake config ..."


#PYTHON_PATH=$(which python)//"/bin/python"
#	-DPYTHON_EXECUTABLE:FILEPATH=$(which python) \
#	-DPYTHON_INCLUDE_DIR:PATH=$PYTHON_PATH \
#	-DPYTHON_LIBRARY:FILEPATH=$PYTHON_PATH/lib64 \
#	-DPYTHON_LIBRARY_DEBUG:FILEPATH=PYTHON_LIBRARY_DEBUG-NOTFOUND \

CMAKE=$1
SOURCE_PATH_PREFIX=$2
BUILD_PATH_PREFIX=$3
INSTALL_PATH_PREFIX=$4

DOXYGEN_DOT_EXECUTABLE=$5 	#/usr/bin/dot
DOXYGEN_EXECUTABLE=$6 		#/usr/bin/doxygen

if ! [ "$WORKING_PATH" = "" ] ; then

	if ! [ "$CMAKE" = "" ] ; then

		if ! [ "$SOURCE_PATH_PREFIX" = "" ] ; then

			if ! [ "$BUILD_PATH_PREFIX" = "" ] ; then

				if ! [ "$INSTALL_PATH_PREFIX" = "" ] ; then

					if ! [ "$DOXYGEN_DOT_EXECUTABLE" = "" ] ; then

						if ! [ "$DOXYGEN_EXECUTABLE" = "" ] ; then

							if ! [ -d "$WORKING_PATH/$BUILD_PATH_PREFIX-llvm"]; then
								mkdir "$WORKING_PATH/$BUILD_PATH_PREFIX-llvm"
							fi;
							cd "$WORKING_PATH/$BUILD_PATH_PREFIX-llvm"
							if [ "$PWD" = "$WORKING_PAT/$BUILD_PATH_PREFIX-llvm" ]; then
								$CMAKE -DCMAKE_INSTALL_PREFIX:PATH=$WORKING_PATH/$INSTALL_PATH_PREFIX-llvm \
								-DPOLLY_ENABLE_GPGPU_CODEGEN:BOOL=ON \
								-DLLVM_ENABLE_LIBCXX:BOOL=ON \
								-DLIBOMP_CFLAGS:STRING="-stdlib=libc++" \
								-DCMAKE_CXX_FLAGS:STRING="-std=c++11 -stdlib=libc++" \
								-DCMAKE_C_COMPILER:FILEPATH=$(which clang) \
								-DCMAKE_CXX_COMPILER:FILEPATH=$(which clang++) \
								-DCMAKE_SHARED_LIBRARY_LINK_C_FLAGS:STRING="" \
								-DCMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS:STRING="" \
								-DLIBOMP_CFLAGS:STRING="-stdlib=libc++" \
								-DLLVM_ENABLE_DOXYGEN:BOOL=ON \
								-DLLVM_BUILD_DOCS:BOOL=ON \
								-DLLDB_DISABLE_PYTHON:BOOL=ON \
								-DDOXYGEN_DOT_EXECUTABLE:FILEPATH=$DOXYGEN_DOT_EXECUTABLE \
								-DDOXYGEN_EXECUTABLE:FILEPATH=$WORKING_PATH/$DOXYGEN_EXECUTABLE `#install-doxygen/bin/doxygen` \
							`#	-DLLDB_EXPORT_ALL_SYMBOLS:BOOL=ON` \
								-DCMAKE_BUILD_TYPE:STRING="Debug" \
								-G "Unix Makefiles" \
								"$WORKING_PATH/$SOURCE_PATH_PREFIX";
							else
								echo "Have not entered destination. Operation failed."
							fi;
						else		
							echo "Provide \$DOXYGEN_EXECUTABLE from argument 6, please."
						fi;

					else
						echo "Provide \$DOXYGEN_DOT_EXECUTABLE from argument 5, please."
					fi;

				else
					echo "Provide \$INSTALL_PATH_PREFIX from argument 4, please."
				fi;
			else
				echo "Provide \$BUILD_PATH_PREFIX from argument 3, please."
			fi;
		else
		    echo "Provide \$SOURCE_PATH_PREFIX from argument 2, please."

		fi;
	else
	    echo "Provide \$CMAKE from argument 1, please."

	fi;

else
    echo "Export \$WORKING_PATH first."

fi;


echo "cmake config ..."
if ! [ "$WORKING_PATH" = "" ] ; then

        cmake -DCMAKE_INSTALL_PREFIX:PATH=$WORKING_PATH/install-llvm \
        -DPOLLY_ENABLE_GPGPU_CODEGEN:BOOL=ON \
        -DLLVM_ENABLE_LIBCXX:BOOL=ON \
        -DCMAKE_C_COMPILER:FILEPATH=$(which clang) \
        -DCMAKE_CXX_COMPILER:FILEPATH=$(which clang++) \
        -DCMAKE_SHARED_LIBRARY_LINK_C_FLAGS:STRING="" \
        -DCMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS:STRING="" \
        -DCMAKE_CXX_FLAGS:STRING="-std=c++11" \
        -DLIBOMP_CFLAGS:STRING="-stdlib=libc++" \
        -G "Unix Makefiles" \
        "$WORKING_PATH/llvm";

else
    echo "export WORKING_PATH first."

fi;


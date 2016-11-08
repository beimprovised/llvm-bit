echo "cmake config ..."
if ! [ "$WORKING_PATH" = "" ] ; then

        cmake -DCMAKE_INSTALL_PREFIX=$WORKING_PATH/install-llvm \
        -DPOLLY_ENABLE_GPGPU_CODEGEN=ON \
        -DLLVM_ENABLE_LIBCXX=ON \
        -DCMAKE_C_COMPILER=$(which clang) \
        -DCMAKE_CXX_COMPILER=$(which clang++) \
        -DCMAKE_SHARED_LIBRARY_LINK_C_FLAGS="" \
        -DCMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS="" \
        -DCMAKE_CXX_FLAGS="-std=c++11" \
        -DLIBOMP_CFLAGS="-stdlib=libc++" \
        -G "Unix Makefiles" \
        $WORKING_PATH/llvm;

else
    echo "export WORKING_PATH first."

fi;


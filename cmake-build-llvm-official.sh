echo "cmake config ..."
if ! [ "$WORKING_PATH" = "" ] ; then

        cmake -DCMAKE_INSTALL_PREFIX=$WORKING_PATH/install-llvm \
        -DPOLLY_ENABLE_GPGPU_CODEGEN=ON \
        -DLLVM_ENABLE_LIBCXX=ON \
        -DCMAKE_C_COMPILER=$ORIGINAL_OBJ_ROOT/bin/clang \
        -DCMAKE_CXX_COMPILER=$ORIGINAL_OBJ_ROOT/bin/clang++ \
        -DCMAKE_SHARED_LIBRARY_LINK_C_FLAGS="" \
        -DCMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS="" \
        -DCMAKE_CXX_FLAGS="-std=c++11" \ # fatal error: 'atomic' file not found
        -DLIBOMP_CFLAGS="-stdlib=libc++" \ # fatal error: 'atomic' file not found
        -G "Unix Makefiles" \
        $WORKING_PATH/llvm;

else
    echo "export WORKING_PATH first."

fi;


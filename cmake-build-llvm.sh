echo "cmake config ..."
WORKING_PATH=$HOME/working
cmake -DCMAKE_INSTALL_PREFIX=$WORKING_PATH/install-llvm \
-DPOLLY_ENABLE_GPGPU_CODEGEN=ON \
-DLLVM_ENABLE_LIBCXX=ON \
-G "Unix Makefiles" \
$WORKING_PATH/llvm;

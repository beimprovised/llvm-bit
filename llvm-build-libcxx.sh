cmake \
	-DCMAKE_INSTALL_PREFIX:PATH=$WORKING_PATH/install-llvm \
	-DLLVM_PATH=$WORKING_PATH/llvm \
        -DLIBCXX_CXX_ABI=libcxxabi \
        -DLIBCXX_CXX_ABI_INCLUDE_PATHS=$WORKING_PATH/llvm/projects/libcxxabi/include \
        $WORKING_PATH/llvm/projects/libcxx

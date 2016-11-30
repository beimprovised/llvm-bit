cmake \
	-DCMAKE_INSTALL_PREFIX:PATH=/home/hyang/working/install-llvm \
	-DLLVM_PATH=/home/hyang/working/llvm \
        -DLIBCXX_CXX_ABI=libcxxabi \
        -DLIBCXX_CXX_ABI_INCLUDE_PATHS=/home/hyang/working/llvm/projects/libcxxabi/include \
        /home/hyang/working/llvm/projects/libcxx

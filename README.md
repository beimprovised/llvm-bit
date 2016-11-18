Here are some shell scripts for building llvm.

For example: 
	
	pl $PATH
	llvm-gitpull-bit.sh $PWD beimprovised llvm-bit
	. dynamic-switch-llvm.sh llvm llvm-ykt
	ds llvm llvm-ykt
	cmake-build-llvm-bit.sh $(which cmake) /opt/nvidia/cuda llvm-bit "Unix Makefiles"
	cmake-build-llvm.sh $(which cmake) /usr/lib/nvidia-cuda-toolkit llvm-bit "Eclipse CDT4 - Unix Makefiles"
	cmake-install-llvm.sh /opt/cmake/bin/cmake llvm-ykt


See wiki for more details

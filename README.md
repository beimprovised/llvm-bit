Here are some shell scripts for building llvm.

For example: 
	
	pl $PATH
	llvm-gitpull-bit.sh $PWD beimprovised llvm-bit
	source dynamic-switch-llvm-ykt.sh /opt/nvidia/cuda
	cmake-build-llvm-bit.sh $(which cmake) /opt/nvidia/cuda llvm-bit "Unix Makefiles"
	cmake-build-llvm.sh $(which cmake) /usr/lib/nvidia-cuda-toolkit llvm-bit "Eclipse CDT4 - Unix Makefiles"


See wiki for more details

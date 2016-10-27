#!/bin/sh

WORKING_PATH="$1" 

if ! [ "$WORKING_PATH" = "" ]; then

	cd $WORKING_PATH/llvm

	echo "------- LLVM ----------"

	git pull --rebase

	echo "------- Clang ----------"

	cd $WORKING_PATH/tools/clang

	git pull --rebase

	#cd ../..

	echo "------- Polly ----------"

	cd $WORKING_PATH/tools/polly

	git pull --rebase

	#cd ../..

	echo "------- Compiler-rt ----------"

	cd $WORKING_PATH/projects/compiler-rt

	git pull --rebase

	#cd ../..

	echo "------- OpenMP ----------"

	cd $WORKING_PATH/projects/openmp

	git pull --rebase

	#cd ../..

	echo "------- libcxx ----------"
	cd $WORKING_PATH/llvm/projects/libcxx

	git pull --rebase


	echo "------- libcxxabi ----------"

	cd $WORKING_PATH/projects/libcxxabi

	git pull --rebase

	cd $WORKING_PATH/llvm/projects/test-suite

	git pull --rebase

	echo "------- clang tools extra ----------"
	cd $WORKING_PATH/llvm/tools/clang/tools/clang-tools-extra

	git pull --rebase

	echo "prepare build directory ..."
	cd "$WORKING_PATH"
	if [ ! -d "build-llvm" ]; then
		mkdir build-llvm #(in-tree build is not supported)
	fi;
	if [ ! -d "install-llvm" ]; then
		mkdir install-llvm
	fi;
	cd build-llvm;

else
	echo "Give \$WORKING_PATH first."
fi;

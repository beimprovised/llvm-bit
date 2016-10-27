#!/bin/sh
WORKING_PATH="$1" 
if ! [ "$WORKING_PATH" = "" ]; then

        if [ ! -d "$WORKING_PATH" ]; then
                mkdir $WORKING_PATH
        fi;
	
	cd "$WORKING_PATH"
	if [ ! -d "$WORKING_PATH/llvm-ykt" ]; then
                git clone https://github.com/clang-ykt/llvm.git "$WORKING_PATH/llvm-ykt"	# http://llvm.org/git/llvm.git
        fi;

	cd "$WORKING_PATH/llvm-ykt"
	echo "------- LLVM ----------"
        if [ ! -d ".git" ]; then
                git remote add origin https://github.com/clang-ykt/llvm.git	# http://llvm.org/git/llvm.git
        fi;
                git pull --rebase
                git fetch
                git checkout master

	echo "------- LLVM ----------"

	#git pull --rebase
	#git fetch
	#git checkout master
	#git svn rebase -l

	echo "------- Clang ----------"
	if [ ! -d "$WORKING_PATH/llvm-ykt/tools/clang" ]; then
                git clone https://github.com/clang-ykt/clang.git "$WORKING_PATH/llvm-ykt/tools/clang"	# http://llvm.org/git/llvm.git
        fi;

	cd "$WORKING_PATH/llvm-ykt/tools/clang"
        if [ ! -d ".git" ]; then
                git remote add origin https://github.com/clang-ykt/clang.git	# http://llvm.org/git/llvm.git
        fi;
                git pull --rebase
                git fetch
                git checkout master


	#git pull --rebase
	#git fetch 
	#git checkout master
	#git svn rebase -l
	#cd ../..

	#cd tools/clang/tools/clang-tools-extra
	#git pull --rebase
	#git fetch
	#git checkout master
	#git svn rebase -l

	#cd ../../../..

	#echo "------- Polly ----------"

	#cd tools/polly

	#git pull --rebase
	#git fetch 
	#git checkout master
	#git svn rebase -l


	#cd ../..

	#echo "------- Compiler-rt ----------"

	#cd projects/compiler-rt

	#git pull --rebase
	#git fetch 
	#git checkout master
	#git svn rebase -l


	#cd ../..

	echo "------- OpenMP ----------"
        if [ ! -d "$WORKING_PATH/llvm-ykt/projects/openmp" ]; then
                git clone https://github.com/clang-ykt/openmp.git "$WORKING_PATH/llvm-ykt/projects/openmp"    # http://llvm.org/git/llvm.git
        fi;

       	cd "$WORKING_PATH/llvm-ykt/projects/openmp"
        if [ ! -d ".git" ]; then
                git remote add origin https://github.com/clang-ykt/openmp.git    # http://llvm.org/git/llvm.git
        fi;
                git pull --rebase
                git fetch
                git checkout master

	#git pull --rebase
	#git fetch 
	#git checkout master
	#git svn rebase -l


	#cd ../..

	#echo "------- libcxxabi ----------"

	#cd projects/libcxxabi

	#git pull --rebase
	#git fetch 
	#git checkout master
	#git svn rebase -l

	#cd ../..

	#cd projects/libcxx
	#git pull --rebase
	#git fetch
	#git checkout master
	#git svn rebase -l

	#cd ../..
else
	echo "Give \$WORKING_PATH first."
fi;

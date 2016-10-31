#!/bin/sh
WORKING_PATH="$1" 
if ! [ "$WORKING_PATH" = "" ]; then

        if [ ! -d "$WORKING_PATH" ]; then
                mkdir $WORKING_PATH
        fi;
	
	cd "$WORKING_PATH"
	echo "pull llvm ..."
	if [ ! -d "$WORKING_PATH/llvm-ykt" ]; then
                git clone https://github.com/clang-ykt/llvm.git "$WORKING_PATH/llvm-ykt"	# http://llvm.org/git/llvm.git
        fi;

	cd "$WORKING_PATH/llvm-ykt"
        if [ ! -d ".git" ]; then
                git remote add origin https://github.com/clang-ykt/llvm.git	# http://llvm.org/git/llvm.git
        fi;
                git pull --rebase
                git fetch
                git checkout master


	cd "$WORKING_PATH/llvm-ykt/tools"
	echo "pull clang ..."
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

	cd "$WORKING_PATH/llvm-ykt/tools/clang/tools"
	echo "pull clang-tools-extra ..."
	if [ ! -d "$WORKING_PATH/llvm/tools/clang/tools/clang-tools-extra" ]; then
		git clone http://llvm.org/git/clang-tools-extra	 # svn co http://llvm.org/svn/llvm-project/clang-tools-extra/trunk extra
	fi;
	cd clang-tools-extra
	if [ ! -d ".git" ]; then
		git remote add origin http://llvm.org/git/clang-tools-extra	 # svn co http://llvm.org/svn/llvm-project/clang-tools-extra/trunk extra
	fi;
		git pull --rebase
		git fetch
		git checkout master 

	cd "$WORKING_PATH/llvm-ykt/projects"
	echo "pull test-suite ..."
	if [ ! -d "$WORKING_PATH/llvm/projects/test-suite" ]; then
		git clone https://github.com/clang-ykt/test-suite.git
	fi;
	cd test-suite
	if [ ! -d ".git" ]; then
		git remote add origin https://github.com/clang-ykt/test-suite.git
	fi;
		git pull --rebase
		git fetch
		git checkout master 

	cd "$WORKING_PATH/llvm-ykt/tools"
	echo "pull polly ..."
	if [ ! -d "$WORKING_PATH/llvm/tools/polly" ]; then
		git clone https://github.com/clang-ykt/polly.git
	fi;
	cd polly
	if [ ! -d ".git" ]; then
		git remote add origin https://github.com/clang-ykt/polly.git
	fi;
		git pull --rebase
		git fetch
		git checkout master 

	cd "$WORKING_PATH/llvm-ykt/projects"
	echo "pull compiler-rt ..."
	if [ ! -d "$WORKING_PATH/llvm/projects/compiler-rt" ]; then
		git clone https://github.com/clang-ykt/compiler-rt.git
	fi;
	cd compiler-rt
	if [ ! -d ".git" ]; then
		git remote add origin https://github.com/clang-ykt/compiler-rt.git
	fi;
		git pull --rebase
		git fetch
		git checkout master 



	cd "$WORKING_PATH/llvm-ykt/projects"
	echo "pull openmp ..."
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


	cd "$WORKING_PATH/llvm-ykt/projects"
	echo "pull libcxxabi ..."
	if [ ! -d "$WORKING_PATH/llvm/projects/libcxxabi" ]; then
		git clone https://github.com/clang-ykt/libcxxabi.git
	fi;
	cd libcxxabi
	if [ ! -d ".git" ]; then
		git remote add origin https://github.com/clang-ykt/libcxxabi.git
	fi;
		git pull --rebase
		git fetch
		git checkout master 


	cd "$WORKING_PATH/llvm-ykt/projects"
	echo "pull libcxx ..."
	if [ ! -d "$WORKING_PATH/llvm/projects/libcxx" ]; then
		git clone https://github.com/clang-ykt/libcxx.git
	fi;
	cd libcxx
	if [ ! -d ".git" ]; then
		git remote add origin https://github.com/clang-ykt/libcxx.git
	fi;
		git pull --rebase
		git fetch
		git checkout master 
	echo "prepare build directory ..."
	cd "$WORKING_PATH"
	if [ ! -d "build-llvm-ykt" ]; then
		mkdir build-llvm-ykt #(in-tree build is not supported)
	fi;
	if [ ! -d "install-llvm-ykt" ]; then
		mkdir install-llvm-ykt
	fi;

	cd "$WORKING_PATH"

else
	echo "Give \$WORKING_PATH from argument 1."
fi;

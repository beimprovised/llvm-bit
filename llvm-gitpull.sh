#!/bin/sh
WORKING_PATH="$1" 		# $PWD
GITHUB_REPOSITORY_NAME="$2"	# clang-ykt or beimprovised
RELATIVE_SOURCE_PATH="$3"	# llvm-ykt or llvm-bit
if ! ( [ "$WORKING_PATH" = "" ] || [ "$GITHUB_REPOSITORY_NAME" = "" ] || [ "$RELATIVE_SOURCE_PATH" = "" ] ); then

        if [ ! -d "$WORKING_PATH" ]; then
                mkdir $WORKING_PATH
        fi;
	
	cd "$WORKING_PATH"
	echo "pull llvm ..."
#	RELATIVE_SOURCE_PATH="llvm-bit"
	SOURCE_PATH="$WORKING_PATH/$RELATIVE_SOURCE_PATH"

	if [ ! -d "$SOURCE_PATH" ]; then
		mkdir "$RELATIVE_SOURCE_PATH"
                git clone "https://github.com/$GITHUB_REPOSITORY_NAME/llvm.git" "$SOURCE_PATH"	# http://llvm.org/git/llvm.git
        fi;
	cd "$SOURCE_PATH"
        if [ ! -d ".git" ]; then
                git remote add origin "https://github.com/$GITHUB_REPOSITORY_NAME/llvm.git"	# http://llvm.org/git/llvm.git
        fi;
                git pull --rebase
                git fetch
                git checkout master


	cd "$SOURCE_PATH/tools"
	echo "pull clang ..."
	if [ ! -d "$SOURCE_PATH/tools/clang" ]; then
                git clone "https://github.com/$GITHUB_REPOSITORY_NAME/clang.git" "$SOURCE_PATH/tools/clang"	# http://llvm.org/git/llvm.git
        fi;

	cd "$SOURCE_PATH/tools/clang"
        if [ ! -d ".git" ]; then
                git remote add origin "https://github.com/$GITHUB_REPOSITORY_NAME/clang.git"	# http://llvm.org/git/llvm.git
        fi;
                git pull --rebase
                git fetch
                git checkout master

	cd "$SOURCE_PATH/tools/clang/tools"
	echo "pull clang-tools-extra ..."
	if [ ! -d "$SOURCE_PATH/tools/clang/tools/clang-tools-extra" ]; then
#		git clone http://llvm.org/git/clang-tools-extra	 # svn co http://llvm.org/svn/llvm-project/clang-tools-extra/trunk extra
		git clone "https://github.com/$GITHUB_REPOSITORY_NAME/clang-tools-extra.git"
	fi;
	cd clang-tools-extra
	if [ ! -d ".git" ]; then
#		git remote add origin http://llvm.org/git/clang-tools-extra	 # svn co http://llvm.org/svn/llvm-project/clang-tools-extra/trunk extra
		git remote add origin "https://github.com/$GITHUB_REPOSITORY_NAME/clang-tools-extra.git"	 # svn co http://llvm.org/svn/llvm-project/clang-tools-extra/trunk extra
	fi;
		git pull --rebase
		git fetch
		git checkout master 

	cd "$SOURCE_PATH/projects"
	echo "pull test-suite ..."
	if [ ! -d "$SOURCE_PATH/projects/test-suite" ]; then
		git clone "https://github.com/$GITHUB_REPOSITORY_NAME/test-suite.git"
	fi;
	cd test-suite
	if [ ! -d ".git" ]; then
		git remote add origin "https://github.com/$GITHUB_REPOSITORY_NAME/test-suite.git"
	fi;
		git pull --rebase
		git fetch
		git checkout master 

	cd "$SOURCE_PATH/tools"
	echo "pull polly ..."
	if [ ! -d "$SOURCE_PATH/tools/polly" ]; then
		git clone "https://github.com/$GITHUB_REPOSITORY_NAME/polly.git"
	fi;
	cd polly
	if [ ! -d ".git" ]; then
		git remote add origin "https://github.com/$GITHUB_REPOSITORY_NAME/polly.git"
	fi;
		git pull --rebase
		git fetch
		git checkout master 

	cd "$SOURCE_PATH/projects"
	echo "pull compiler-rt ..."
	if [ ! -d "$SOURCE_PATH/projects/compiler-rt" ]; then
		git clone "https://github.com/$GITHUB_REPOSITORY_NAME/compiler-rt.git"
	fi;
	cd compiler-rt
	if [ ! -d ".git" ]; then
		git remote add origin "https://github.com/$GITHUB_REPOSITORY_NAME/compiler-rt.git"
	fi;
		git pull --rebase
		git fetch
		git checkout master 



	cd "$SOURCE_PATH/projects"
	echo "pull openmp ..."
        if [ ! -d "$SOURCE_PATH/projects/openmp" ]; then
                git clone "https://github.com/$GITHUB_REPOSITORY_NAME/openmp.git" "$SOURCE_PATH/projects/openmp"    # http://llvm.org/git/llvm.git
        fi;

       	cd "$SOURCE_PATH/projects/openmp"
        if [ ! -d ".git" ]; then
                git remote add origin "https://github.com/$GITHUB_REPOSITORY_NAME/openmp.git"    # http://llvm.org/git/llvm.git
        fi;
                git pull --rebase
                git fetch
                git checkout master


	cd "$SOURCE_PATH/projects"
	echo "pull libcxxabi ..."
	if [ ! -d "$SOURCE_PATH/projects/libcxxabi" ]; then
		git clone "https://github.com/$GITHUB_REPOSITORY_NAME/libcxxabi.git"
	fi;
	cd libcxxabi
	if [ ! -d ".git" ]; then
		git remote add origin "https://github.com/$GITHUB_REPOSITORY_NAME/libcxxabi.git"
	fi;
		git pull --rebase
		git fetch
		git checkout master 


	cd "$SOURCE_PATH/projects"
	echo "pull libcxx ..."
	if [ ! -d "$SOURCE_PATH/projects/libcxx" ]; then
		git clone "https://github.com/$GITHUB_REPOSITORY_NAME/libcxx.git"
	fi;
	cd libcxx
	if [ ! -d ".git" ]; then
		git remote add origin "https://github.com/$GITHUB_REPOSITORY_NAME/libcxx.git"
	fi;
		git pull --rebase
		git fetch
		git checkout master 
	echo "prepare build directory ..."

	cd "$WORKING_PATH"

	if [ ! -d "build-$RELATIVE_SOURCE_PATH" ]; then
		mkdir "build-$RELATIVE_SOURCE_PATH" #(in-tree build is not supported)
	fi;
	if [ ! -d "install-$RELATIVE_SOURCE_PATH" ]; then
		mkdir "install-$RELATIVE_SOURCE_PATH"
	fi;

#	cd "$WORKING_PATH"

else
	echo "Give \$WORKING_PATH from argument 1, \$GITHUB_REPOSITORY_NAME from argument 2, and \$RELATIVE_SOURCE_PATH from argument 3."
fi;

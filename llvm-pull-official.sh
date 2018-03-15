#!/bin/bash
# updated 2016-10-22
# WORKING_PATH="$1"

LLVM_SOURCE_ROOT="$1"
NOT_HAS_GIT_SVN="$2"	# ""

if [ "$NOT_HAS_GIT_SVN" = "" ]; then
	echo "No git-svn synchonization specified."
fi;

if [ "$LLVM_SOURCE_ROOT" = "" ]; then
	echo "No source root specified. Use \"llvm\""
	LLVM_SOURCE_ROOT="llvm"
fi;

if ! [ "$WORKING_PATH"  = "" ]; then
	if [ ! -d "$WORKING_PATH" ]; then
		mkdir $WORKING_PATH
	fi;

	cd "$WORKING_PATH"
	if [ ! -d "$WORKING_PATH/$LLVM_SOURCE_ROOT" ]; then
		git clone http://llvm.org/git/llvm.git $LLVM_SOURCE_ROOT
	fi;

	echo "pull llvm ..."
	cd "$WORKING_PATH/$LLVM_SOURCE_ROOT"
	if [ ! -d ".git" ]; then
		git remote add origin http://llvm.org/git/llvm.git
	fi;
		git pull --rebase
		git fetch
		git checkout master

	if ! [ "$NOT_HAS_GIT_SVN" = "" ]; then
		if [ ! -d ".git/svn" ]; then
			echo "llvm svn initializing ..."
			git svn init https://llvm.org/svn/llvm-project/llvm/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l  # -l avoids fetching ahead of the git mirror.
		else
			git config --unset-all svn-remote.svn.url
			git config --unset-all svn-remote.svn.fetch
			git svn init https://llvm.org/svn/llvm-project/llvm/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		fi;
	fi;



	# If you have clang too:
	echo "pull clang ..."

	if [ ! -d "$WORKING_PATH/$LLVM_SOURCE_ROOT/tools" ]; then
		mkdir "$WORKING_PATH/$LLVM_SOURCE_ROOT/tools"
	fi;

	cd "$WORKING_PATH/$LLVM_SOURCE_ROOT/tools"
	if [ ! -d "$WORKING_PATH/$LLVM_SOURCE_ROOT/tools/clang" ]; then
		git clone http://llvm.org/git/clang.git
	fi;
	cd clang
	if [ ! -d ".git" ]; then
		git remote add origin http://llvm.org/git/clang.git
		#git clone http://llvm.org/git/clang.git llvm/tools/clang
	fi;
		git pull --rebase
		git fetch
		git checkout master

	if ! [ "$NOT_HAS_GIT_SVN" = "" ]; then
		if [ ! -d ".git/svn" ]; then
		echo "clang svn initializing ..."
			git svn init https://llvm.org/svn/llvm-project/cfe/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		else
			git config --unset-all svn-remote.svn.url
			git config --unset-all svn-remote.svn.fetch
			git svn init https://llvm.org/svn/llvm-project/cfe/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		fi;
	fi;

	# If you have clang too:
	echo "pull lldb ..."
	cd "$WORKING_PATH/$LLVM_SOURCE_ROOT/tools"
	if [ ! -d "$WORKING_PATH/$LLVM_SOURCE_ROOT/tools/lldb" ]; then
		git clone http://llvm.org/git/lldb.git
	fi;
	cd lldb
	if [ ! -d ".git" ]; then
		git remote add origin http://llvm.org/git/lldb.git
		#git clone http://llvm.org/git/lldb.git llvm/tools/lldb
	fi;
		git pull --rebase
		git fetch
		git checkout master

	if ! [ "$NOT_HAS_GIT_SVN" = "" ]; then
		if [ ! -d ".git/svn" ]; then
		echo "clang svn initializing ..."
			git svn init https://llvm.org/svn/llvm-project/lldb/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		else
			git config --unset-all svn-remote.svn.url
			git config --unset-all svn-remote.svn.fetch
			git svn init https://llvm.org/svn/llvm-project/lldb/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		fi;
	fi;

	if [ ! -d "$WORKING_PATH/$LLVM_SOURCE_ROOT/projects" ]; then
		mkdir "$WORKING_PATH/$LLVM_SOURCE_ROOT/projects"
	fi;

	cd "$WORKING_PATH/$LLVM_SOURCE_ROOT/projects"
	echo "pull compiler-rt ..."
	if [ ! -d "$WORKING_PATH/$LLVM_SOURCE_ROOT/projects/compiler-rt" ]; then
		git clone http://llvm.org/git/compiler-rt.git
	fi;
	cd compiler-rt
	if [ ! -d ".git" ]; then
		git remote add origin http://llvm.org/git/compiler-rt.git
		#git clone http://llvm.org/git/compiler-rt.git llvm/projects/compiler-rt
	fi;
		git pull --rebase
		git fetch
		git checkout master 
	
	if ! [ "$NOT_HAS_GIT_SVN" = "" ]; then
		if [ ! -d ".git/svn" ]; then
			git svn init https://llvm.org/svn/llvm-project/compiler-rt/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		else
			git config --unset-all svn-remote.svn.url
			git config --unset-all svn-remote.svn.fetch
			git svn init https://llvm.org/svn/llvm-project/compiler-rt/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		fi;
	fi;

	cd "$WORKING_PATH/$LLVM_SOURCE_ROOT/projects"
	echo "pull openmp ..."
	if [ ! -d "$WORKING_PATH/$LLVM_SOURCE_ROOT/projects/openmp" ]; then
		git clone http://llvm.org/git/openmp.git
	fi;
	cd openmp
	if [ ! -d ".git" ]; then
		git remote add origin http://llvm.org/git/openmp.git
		#git clone http://llvm.org/git/openmp.git llvm/projects/openmp
	fi;
		git pull --rebase
		git fetch
		git checkout master 

	if ! [ "$NOT_HAS_GIT_SVN" = "" ]; then
		if [ ! -d ".git/svn" ]; then
			git svn init https://llvm.org/svn/llvm-project/openmp/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		else 
			git config --unset-all svn-remote.svn.url
			git config --unset-all svn-remote.svn.fetch
			git svn init https://llvm.org/svn/llvm-project/openmp/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		fi;
	fi;
: '
	cd "$WORKING_PATH/$LLVM_SOURCE_ROOT/projects"
	echo "pull libcxx ..."
	if [ ! -d "$WORKING_PATH/$LLVM_SOURCE_ROOT/projects/libcxx" ]; then
		git clone http://llvm.org/git/libcxx.git
	fi;
	cd libcxx
	if [ ! -d ".git" ]; then
		git remote add origin http://llvm.org/git/libcxx.git
		#git clone http://llvm.org/git/libcxx.git llvm/projects/libcxx
	fi;
		git pull --rebase
		git fetch
		git checkout master 
	
	if ! [ "$NOT_HAS_GIT_SVN" = "" ]; then
		if [ ! -d ".git/svn" ]; then
			git svn init https://llvm.org/svn/llvm-project/libcxx/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		else
			git config --unset-all svn-remote.svn.url
			git config --unset-all svn-remote.svn.fetch
			git svn init https://llvm.org/svn/llvm-project/libcxx/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		fi;
	fi;

	cd "$WORKING_PATH/$LLVM_SOURCE_ROOT/projects"
	echo "pull libcxxabi ..."
	if [ ! -d "$WORKING_PATH/$LLVM_SOURCE_ROOT/projects/libcxxabi" ]; then
		git clone http://llvm.org/git/libcxxabi.git
	fi;
	cd libcxxabi
	if [ ! -d ".git" ]; then
		git remote add origin http://llvm.org/git/libcxxabi.git
		#git clone http://llvm.org/git/libcxxabi.git llvm/projects/libcxxabi
	fi;
		git pull --rebase
		git fetch
		git checkout master 
	
	if ! [ "$NOT_HAS_GIT_SVN" = "" ]; then
		if [ ! -d ".git/svn" ]; then
			git svn init https://llvm.org/svn/llvm-project/libcxxabi/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		else
			git config --unset-all svn-remote.svn.url
			git config --unset-all svn-remote.svn.fetch
			git svn init https://llvm.org/svn/llvm-project/libcxxabi/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		fi;
	fi;
'
	cd "$WORKING_PATH/$LLVM_SOURCE_ROOT/projects"
	echo "pull test-suite ..."
	if [ ! -d "$WORKING_PATH/$LLVM_SOURCE_ROOT/projects/test-suite" ]; then
		git clone http://llvm.org/git/test-suite.git
	fi;
	cd test-suite
	if [ ! -d ".git" ]; then
		git remote add origin http://llvm.org/git/test-suite.git
		#git clone http://llvm.org/git/test-suite.git llvm/projects/test-suite
	fi;
		git pull --rebase
		git fetch
		git checkout master 

	if ! [ "$NOT_HAS_GIT_SVN" = "" ]; then
		if [ ! -d ".git/svn" ]; then
			git svn init https://llvm.org/svn/llvm-project/test-suite/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		else
			git config --unset-all svn-remote.svn.url
			git config --unset-all svn-remote.svn.fetch
			git svn init https://llvm.org/svn/llvm-project/test-suite/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		fi;
	fi;

	cd "$WORKING_PATH/$LLVM_SOURCE_ROOT/tools"
	echo "pull polly ..."
	if [ ! -d "$WORKING_PATH/$LLVM_SOURCE_ROOT/tools/polly" ]; then
		git clone http://llvm.org/git/polly.git
	fi;
	cd polly
	if [ ! -d ".git" ]; then
		git remote add origin http://llvm.org/git/polly.git
		#git clone http://llvm.org/git/polly.git llvm/tools/polly
	fi;
		git pull --rebase
		git fetch
		git checkout master 

	if ! [ "$NOT_HAS_GIT_SVN" = "" ]; then
		if [ ! -d ".git/svn" ]; then
			git svn init https://llvm.org/svn/llvm-project/polly/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		else
			git config --unset-all svn-remote.svn.url
			git config --unset-all svn-remote.svn.fetch
			git svn init https://llvm.org/svn/llvm-project/polly/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		fi;
	fi;

	cd "$WORKING_PATH/$LLVM_SOURCE_ROOT/tools/clang/tools"
	echo "pull clang-tools-extra ..."
	if [ ! -d "$WORKING_PATH/$LLVM_SOURCE_ROOT/tools/clang/tools/clang-tools-extra" ]; then
		git clone http://llvm.org/git/clang-tools-extra.git	 # svn co http://llvm.org/svn/llvm-project/clang-tools-extra/trunk extra
	fi;

	if [ ! -d "$WORKING_PATH/$LLVM_SOURCE_ROOT/tools/clang/tools" ]; then
		mkdir "$WORKING_PATH/$LLVM_SOURCE_ROOT/tools/clang/tools"
	fi;


	cd clang-tools-extra
	if [ ! -d ".git" ]; then
		git remote add origin http://llvm.org/git/clang-tools-extra.git	 # svn co http://llvm.org/svn/llvm-project/clang-tools-extra/trunk extra
		#git clone http://llvm.org/git/clang-tools-extra llvm/tools/clang/tools/clang-tools-extra
	fi;
		git pull --rebase
		git fetch
		git checkout master 

	if ! [ "$NOT_HAS_GIT_SVN" = "" ]; then
		if [ ! -d ".git/svn" ]; then
			git svn init https://llvm.org/svn/llvm-project/clang-tools-extra/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		else
			git config --unset-all svn-remote.svn.url
			git config --unset-all svn-remote.svn.fetch
			git svn init https://llvm.org/svn/llvm-project/clang-tools-extra/trunk --username=$whoami
			git config svn-remote.svn.fetch :refs/remotes/origin/master
			git svn rebase -l
		fi;
	fi;

	echo "prepare build directory ..."
	cd "$WORKING_PATH"
	if [ ! -d "build-$LLVM_SOURCE_ROOT" ]; then
		mkdir "build-$LLVM_SOURCE_ROOT" #(in-tree build is not supported)
	fi;
	if [ ! -d "install-$LLVM_SOURCE_ROOT" ]; then
		mkdir "install-$LLVM_SOURCE_ROOT"
	fi;

	cd "$WORKING_PATH"
else
	echo "Export \$WORKING_PATH to make sure under where you want to create the source tree."
fi;

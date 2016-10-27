#!/bin/bash
# updated 2016-10-22
WORKING_PATH="$1"		# $HOME/working
if ! [ "$WORKING_PATH"  = "" ]; then
	if [ ! -d "$WORKING_PATH" ]; then
		mkdir $WORKING_PATH
	fi;

	cd "$WORKING_PATH"
	if [ ! -d "$WORKING_PATH/llvm" ]; then
		git clone http://llvm.org/git/llvm.git
	fi;

	echo "pull llvm ..."
	cd "$WORKING_PATH/llvm"
	if [ ! -d ".git" ]; then
		git remote add origin http://llvm.org/git/llvm.git
	fi;
		git pull --rebase
		git fetch
		git checkout master
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




	# If you have clang too:
	echo "pull clang ..."
	cd "$WORKING_PATH/llvm/tools"
	if [ ! -d "$WORKING_PATH/llvm/tools/clang" ]; then
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

	cd "$WORKING_PATH/llvm/projects"
	echo "pull compiler-rt ..."
	if [ ! -d "$WORKING_PATH/llvm/projects/compiler-rt" ]; then
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

	cd "$WORKING_PATH/llvm/projects"
	echo "pull openmp ..."
	if [ ! -d "$WORKING_PATH/llvm/projects/openmp" ]; then
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

	cd "$WORKING_PATH/llvm/projects"
	echo "pull libcxx ..."
	if [ ! -d "$WORKING_PATH/llvm/projects/libcxx" ]; then
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

	cd "$WORKING_PATH/llvm/projects"
	echo "pull libcxxabi ..."
	if [ ! -d "$WORKING_PATH/llvm/projects/libcxxabi" ]; then
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


	cd "$WORKING_PATH/llvm/projects"
	echo "pull test-suite ..."
	if [ ! -d "$WORKING_PATH/llvm/projects/test-suite" ]; then
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

	cd "$WORKING_PATH/llvm/tools"
	echo "pull polly ..."
	if [ ! -d "$WORKING_PATH/llvm/tools/polly" ]; then
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

	cd "$WORKING_PATH/llvm/tools/clang/tools"
	echo "pull clang-tools-extra ..."
	if [ ! -d "$WORKING_PATH/llvm/tools/clang/tools/clang-tools-extra" ]; then
		git clone http://llvm.org/git/clang-tools-extra	 # svn co http://llvm.org/svn/llvm-project/clang-tools-extra/trunk extra
	fi;
	cd clang-tools-extra
	if [ ! -d ".git" ]; then
		git remote add origin http://llvm.org/git/clang-tools-extra	 # svn co http://llvm.org/svn/llvm-project/clang-tools-extra/trunk extra
		#git clone http://llvm.org/git/clang-tools-extra llvm/tools/clang/tools/clang-tools-extra
	fi;
		git pull --rebase
		git fetch
		git checkout master 
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

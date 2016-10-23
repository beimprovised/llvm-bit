cd ./llvm-ykt

echo "------- LLVM ----------"

git pull --rebase
#git fetch
#git checkout master
#git svn rebase -l

echo "------- Clang ----------"

cd tools/clang

git pull --rebase
#git fetch 
#git checkout master
#git svn rebase -l
cd ../..

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

cd projects/openmp

git pull --rebase
#git fetch 
#git checkout master
#git svn rebase -l


cd ../..

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

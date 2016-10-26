cd llvm

echo "------- LLVM ----------"

git pull --rebase

echo "------- Clang ----------"

cd tools/clang

git pull --rebase

cd ../..

echo "------- Polly ----------"

cd tools/polly

git pull --rebase

cd ../..

echo "------- Compiler-rt ----------"

cd projects/compiler-rt

git pull --rebase

cd ../..

echo "------- OpenMP ----------"

cd projects/openmp

git pull --rebase

cd ../..

echo "------- libcxx ----------"
cd $WORKING_PATH/llvm/projects/libcxx

git pull --rebase


echo "------- libcxxabi ----------"

cd projects/libcxxabi

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


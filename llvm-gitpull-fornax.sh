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

echo "------- libcxxabi ----------"

cd projects/libcxxabi

git pull --rebase

echo "cmake config ..."
if ! [ "$WORKING_PATH" = "" ] ; then

	cmake -DCMAKE_INSTALL_PREFIX=$WORKING_PATH/install-llvm \
	-DPOLLY_ENABLE_GPGPU_CODEGEN=ON \
	-DLLVM_ENABLE_LIBCXX=ON \
	-G "Unix Makefiles" \
	$WORKING_PATH/llvm;

else
    echo "export WORKING_PATH first."

fi;

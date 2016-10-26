echo "cmake config ..."
if ! [ "$WORKING_PATH" = "" ] ; then

        TARGET_DIR=$WORKING_PATH/build-llvm
        if [ -d "$TARGET_DIR" ]; then
          # Control will enter here if $DIRECTORY exists.
                cd $TARGET_DIR

		cmake -DCMAKE_INSTALL_PREFIX=$WORKING_PATH/install-llvm -P cmake_install.cmake
        else
                echo "can't find the directory \$TARGET_DIR"
        fi;

else
    echo "export WORKING_PATH first."

fi;


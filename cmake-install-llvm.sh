if [ -d "$WORKING_PATH" ]; then
	if ! [ "$1" = "" ]; then
		RELATIVE_SOURCE_PATH="$1"
		BUILD_DIR="$WORKING_PATH/build-$RELATIVE_SOURCE_PATH"
		if ! [ -d "$BUILD_DIR" ]; then
			mkdir "$BUILD_DIR"
		fi;
		INSTALL_DIR="$WORKING_PATH/install-$RELATIVE_SOURCE_PATH"
		if ! [ -d "$INSTALL_DIR" ]; then
			mkdir "$INSTALL_DIR"
		fi;

			cd "$BUILD_DIR"
			cmake -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" -P cmake_install.cmake	# "$WORKING_PATH/$RELATIVE_SOURCE_PATH"
	else
		echo "Provide relative source path from argument 1."
	fi;
else
	echo "Can't find directory \$WORKING_PATH from environment parameters."
fi;


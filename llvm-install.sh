if [ -d "$WORKING_PATH" ]; then
	CMAKE="$1"                      # "/opt/cmake/bin/cmake"
	if [ -f "$CMAKE" ]; then
		if ! [ "$2" = "" ]; then
			RELATIVE_SOURCE_PATH="$2"
			BUILD_DIR="$WORKING_PATH/build-$RELATIVE_SOURCE_PATH"
			if ! [ -d "$BUILD_DIR" ]; then
				mkdir "$BUILD_DIR"
			fi;
			INSTALL_DIR="$WORKING_PATH/install-$RELATIVE_SOURCE_PATH"
			if ! [ -d "$INSTALL_DIR" ]; then
				mkdir "$INSTALL_DIR"
			fi;

			cd "$BUILD_DIR"
			$CMAKE -DCMAKE_INSTALL_PREFIX:PATH="$INSTALL_DIR" -P cmake_install.cmake	# "$WORKING_PATH/$RELATIVE_SOURCE_PATH"
		else
			echo "Provide relative source path from argument 2, please."
		fi;
	else
		echo "Give where CMake location from argument 1, please." 
	fi;
else
	echo "Can't find directory \$WORKING_PATH from environment parameters."
fi;


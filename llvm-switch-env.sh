#!/bin/sh
ORIGINAL_RELATIVE_INSTALL_PATH=$1	# llvm
NEW_ABSOLUTE_INSTALL_PATH=$2			# llvm-bit or llvm-ykt
if ! ( [ "$ORIGINAL_RELATIVE_INSTALL_PATH" = "" ] || [ "$NEW_ABSOLUTE_INSTALL_PATH" = "" ] ); then
if ! [ "$WORKING_PATH" = "" ] ; then
#	SRC_ROOT_ORIGINAL="$WORKING_PATH/$ORIGINAL_RELATIVE_INSTALL_PATH"
#	BUILD_ROOT_ORIGINAL="$WORKING_PATH/build-$ORIGINAL_RELATIVE_INSTALL_PATH"
#	OBJ_ROOT_ORIGINAL="$WORKING_PATH/install-$ORIGINAL_RELATIVE_INSTALL_PATH"

#	SRC_ROOT="$WORKING_PATH/$NEW_ABSOLUTE_INSTALL_PATH"
#	BUILD_ROOT="$WORKING_PATH/build-$NEW_ABSOLUTE_INSTALL_PATH"
	OBJ_ROOT=$NEW_ABSOLUTE_INSTALL_PATH	#"$WORKING_PATH/install-$NEW_ABSOLUTE_INSTALL_PATH"

#	export SRC_ROOT
	export OBJ_ROOT

	# http://stackoverflow.com/questions/918886/how-do-i-split-a-string-on-a-delimiter-in-bash

	# deal with CPATH
	ADDR=""
	tmp=""
	IFS=':' read -ra ADDR <<< "$CPATH"
	#while IFS=':' read -ra ADDR; do
	for i in "${ADDR[@]}"; do
		if [[ ( "${i//$ORIGINAL_RELATIVE_INSTALL_PATH}" = "$i" ) && ( "${i//$NEW_ABSOLUTE_INSTALL_PATH}" = "$i" ) ]]; then
			if [ "$tmp" = "" ] ; then
				tmp=$i;
#				echo $i;
			else
				tmp=$tmp:$i;
#				echo $i;
			fi;
		fi;

	done;
	# done <<< "$CPATH";
	append=""
#	append=$OBJ_ROOT/include:$OBJ_ROOT/include/c++/v1:$OBJ_ROOT/lib:$OBJ_ROOT/bin	#:$OBJ_ROOT_ORIGINAL/include:$OBJ_ROOT_ORIGINAL/lib:$OBJ_ROOT_ORIGINAL/bin
	append=$OBJ_ROOT/include:$OBJ_ROOT/lib:$OBJ_ROOT/bin	#:$OBJ_ROOT_ORIGINAL/include:$OBJ_ROOT_ORIGINAL/lib:$OBJ_ROOT_ORIGINAL/bin
	CPATH=""
	if [ "$tmp" = "" ] ; then
		CPATH=$append
	else
		CPATH=$append:$tmp
	fi;

	export CPATH

	# deal with PATH
	ADDR=""
	tmp=""
	IFS=':' read -ra ADDR <<< "$PATH"
	#while IFS=':' read -ra ADDR; do
	for i in "${ADDR[@]}"; do
		if [[ ( "${i//$ORIGINAL_RELATIVE_INSTALL_PATH}" = "$i" ) && ( "${i//$NEW_ABSOLUTE_INSTALL_PATH}" = "$i" ) ]]; then
			if [ "$tmp" = "" ] ; then
				tmp=$i;
#				echo $i;
			else
				tmp=$tmp:$i;
#				echo $i;
			fi;
		fi;

	done;
	# done <<< "$CPATH";
	append=""
#	append=$OBJ_ROOT/include:$OBJ_ROOT/include/c++/v1:$OBJ_ROOT/lib:$OBJ_ROOT/bin	#:$OBJ_ROOT_ORIGINAL/include:$OBJ_ROOT_ORIGINAL/lib:$OBJ_ROOT_ORIGINAL/bin
	append=$OBJ_ROOT/include:$OBJ_ROOT/lib:$OBJ_ROOT/bin	#:$OBJ_ROOT_ORIGINAL/include:$OBJ_ROOT_ORIGINAL/lib:$OBJ_ROOT_ORIGINAL/bin
	PATH=""
	if [ "$tmp" = "" ] ; then
		PATH=$append
	else
		PATH=$append:$tmp
	fi;

	export PATH

	if ! [ "$ACCELERATOR_TOOLKIT" = "" ]; then

#		ACCELERATOR_TOOLKIT="$1"	#"/usr/lib/nvidia-cuda-toolkit/libdevice" 

		# deal with LD_LIBRARY_PATH
		ADDR=""
		tmp=""
		IFS=':' read -ra ADDR <<< "$LD_LIBRARY_PATH"
		for i in "${ADDR[@]}"; do
			if [[ ( "${i//$ORIGINAL_RELATIVE_INSTALL_PATH}" = "$i" ) && ( "${i//$NEW_ABSOLUTE_INSTALL_PATH}" = "$i" ) && ( "${i//$ACCELERATOR_TOOLKIT}" = "$i" ) ]]; then
				if [ "$tmp" = "" ] ; then
					tmp=$i;
#					echo $i;
				else
					tmp=$tmp:$i;
#					echo $i;
				fi;
			fi;
		done;
		
		append=""
		append=$OBJ_ROOT/lib:$ACCELERATOR_TOOLKIT
		LD_LIBRARY_PATH=""
		if [ "$tmp" = "" ] ; then
			LD_LIBRARY_PATH=$append
		else
			LD_LIBRARY_PATH=$append:$tmp
		fi;
		
		export LD_LIBRARY_PATH

		# deal with LIBRARY_PATH
		ADDR=""
		tmp=""
		IFS=':' read -ra ADDR <<< "$LIBRARY_PATH"
		for i in "${ADDR[@]}"; do
			if [[ ( "${i//$ORIGINAL_RELATIVE_INSTALL_PATH}" = "$i" ) && ( "${i//$NEW_ABSOLUTE_INSTALL_PATH}" = "$i" ) && ( "${i//$ACCELERATOR_TOOLKIT}" = "$i" ) ]]; then
				if [ "$tmp" = "" ] ; then
					tmp=$i;
#					echo $i;
				else
					tmp=$tmp:$i;
#					echo $i;
				fi;
			fi;
		done;
		append=""
		append=$OBJ_ROOT/lib:$ACCELERATOR_TOOLKIT
		LIBRARY_PATH=""

		if [ "$tmp" = "" ] ; then
			LIBRARY_PATH=$append
		else
			LIBRARY_PATH=$append:$tmp
		fi;
		
		export LIBRARY_PATH
	else
		echo "\$ACCELERATOR_TOOLKIT path has not provided."
	fi;
else
	echo "export WORKING_PATH first."
fi;
else
	echo "Provide \$ORIGINAL_RELATIVE_INSTALL_PATH and \$NEW_ABSOLUTE_INSTALL_PATH from arguments 1 and 2."
fi;
#export OMPTARGET_LIBS=/home/hyang/install-$NEW_ABSOLUTE_INSTALL_PATH/lib	#<path to libomptarget project>/lib
#export LIBOMP_LIB=/home/hyang/install-$NEW_ABSOLUTE_INSTALL_PATH/lib	#<path to libomp project>/runtime/p8build/src/
#export LIBRARY_PATH=$OMPTARGET_LIBS:$LIBRARY_PATH
#export LD_LIBRARY_PATH=$LIBOMP_LIB:$OMPTARGET_LIBS:/opt/nvidia/cuda/lib64:$LD_LIBRARY_PATH


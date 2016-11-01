#!/bin/sh
RELATIVE_SOURCE_PATH_ORIGINAL=$1	# llvm
RELATIVE_SOURCE_PATH=$2			# llvm-bit or llvm-ykt
if ! ( [ "$RELATIVE_SOURCE_PATH_ORIGINAL" = "" ] || [ "$RELATIVE_SOURCE_PATH" = "" ] ); then
if ! [ "$WORKING_PATH" = "" ] ; then
	SRC_ROOT_ORIGINAL="$WORKING_PATH/$RELATIVE_SOURCE_PATH_ORIGINAL"
	BUILD_ROOT_ORIGINAL="$WORKING_PATH/build-$RELATIVE_SOURCE_PATH_ORIGINAL"
	OBJ_ROOT_ORIGINAL="$WORKING_PATH/install-$RELATIVE_SOURCE_PATH_ORIGINAL"

	SRC_ROOT="$WORKING_PATH/$RELATIVE_SOURCE_PATH"
	BUILD_ROOT="$WORKING_PATH/build-$RELATIVE_SOURCE_PATH"
	OBJ_ROOT="$WORKING_PATH/install-$RELATIVE_SOURCE_PATH"

	export SRC_ROOT
	export OBJ_ROOT

	# http://stackoverflow.com/questions/918886/how-do-i-split-a-string-on-a-delimiter-in-bash

	# deal with CPATH
	ADDR=""
	IFS=':' read -ra ADDR <<< "$CPATH"
	#while IFS=':' read -ra ADDR; do
	for i in "${ADDR[@]}"; do
		if [[ ! ( "${i/$OBJ_ROOT_ORIGINAL}" = "$i" ) ]]; then
			CPATH=${CPATH/$i}; 
		fi;
		if [[ ! ( "${i/$OBJ_ROOT}" = "$i" ) ]]; then
			CPATH=${CPATH/$i}; 
		fi;
		if [[ ! ( "${i/$BUILD_ROOT_ORIGINAL}" = "$i" ) ]]; then
			CPATH=${CPATH/$i}; 
		fi;
		if [[ ! ( "${i/$BUILD_ROOT}" = "$i" ) ]]; then
			CPATH=${CPATH/$i}; 
		fi;

	done;
	#done <<< "$CPATH";
	ADDR=""
	tmp=""
	IFS=':' read -ra ADDR <<< "$CPATH"
	#while IFS=':' read -ra ADDR; do
	for i in "${ADDR[@]}"; do
		if [[ ! ( "$i" = "" ) ]] ; then
			if [ "$tmp" = "" ] ; then
				tmp=$i
			else
				tmp=$tmp:$i
			fi;
		fi;
	done
	#done <<< "$CPATH";
	if [ "$tmp" = "" ] ; then
		CPATH=$OBJ_ROOT/include:$OBJ_ROOT/lib:$OBJ_ROOT/bin:$OBJ_ROOT_ORIGINAL/include:$OBJ_ROOT_ORIGINAL/lib:$OBJ_ROOT_ORIGINAL/bin
#		CPATH=$OBJ_ROOT/include:$tmp
	else
		CPATH=$OBJ_ROOT/include:$OBJ_ROOT/lib:$OBJ_ROOT/bin:$OBJ_ROOT_ORIGINAL/include:$OBJ_ROOT_ORIGINAL/lib:$OBJ_ROOT_ORIGINAL/bin:$tmp
#		CPATH=$OBJ_ROOT/include:$tmp
	fi;

	export CPATH

	# deal with PATH
	ADDR=""
	IFS=':' read -ra ADDR <<< "$PATH"
	for i in "${ADDR[@]}"; do
		if [[ ! ( "${i/$OBJ_ROOT_ORIGINAL}" = "$i" ) ]]; then
			PATH=${PATH/$i}; 
		fi;
		if [[ ! ( "${i/$OBJ_ROOT}" = "$i" ) ]]; then
			PATH=${PATH/$i}; 
		fi;
		if [[ ! ( "${i/$BUILD_ROOT_ORIGINAL}" = "$i" ) ]]; then
			PATH=${PATH/$i}; 
		fi;
		if [[ ! ( "${i/$BUILD_ROOT}" = "$i" ) ]]; then
			PATH=${PATH/$i}; 
		fi;

	done;
	ADDR=""
	tmp=""
	IFS=':' read -ra ADDR <<< "$PATH"
	for i in "${ADDR[@]}"; do
		if [[ ! ( "$i" = "" ) ]] ; then
			if [ "$tmp" = "" ] ; then
				tmp=$i
			else
				tmp=$tmp:$i
			fi;
		fi;
	done
	if [ "$tmp" = "" ] ; then
		PATH=$OBJ_ROOT/include:$OBJ_ROOT/lib:$OBJ_ROOT/bin:$OBJ_ROOT_ORIGINAL/include:$OBJ_ROOT_ORIGINAL/lib:$OBJ_ROOT_ORIGINAL/bin
	else
		PATH=$OBJ_ROOT/include:$OBJ_ROOT/lib:$OBJ_ROOT/bin:$OBJ_ROOT_ORIGINAL/include:$OBJ_ROOT_ORIGINAL/lib:$OBJ_ROOT_ORIGINAL/bin:$tmp
	fi;

	export PATH

	if ! [ "$ACCELERATOR_TOOLKIT" = "" ]; then

#		ACCELERATOR_TOOLKIT="$1"	#"/usr/lib/nvidia-cuda-toolkit/libdevice" 

		# deal with LD_LIBRARY_PATH
		ADDR=""
		IFS=':' read -ra ADDR <<< "$LD_LIBRARY_PATH"
		for i in "${ADDR[@]}"; do
			if [[ ! ( "${i/$OBJ_ROOT_ORIGINAL}" = "$i" ) ]]; then
				LD_LIBRARY_PATH=${LD_LIBRARY_PATH/$i}; 
			fi;
			if [[ ! ( "${i/$OBJ_ROOT}" = "$i" ) ]]; then
				LD_LIBRARY_PATH=${LD_LIBRARY_PATH/$i}; 
			fi;
			if [[ ! ( "${i/$BUILD_ROOT_ORIGINAL}" = "$i" ) ]]; then
				LD_LIBRARY_PATH=${LD_LIBRARY_PATH/$i}; 
			fi;
			if [[ ! ( "${i/$BUILD_ROOT}" = "$i" ) ]]; then
				LD_LIBRARY_PATH=${LD_LIBRARY_PATH/$i}; 
			fi;

			if [[ ! ( "${i/$ACCELERATOR_TOOLKIT}" = "$i" ) ]]; then
				LD_LIBRARY_PATH=${LD_LIBRARY_PATH/$i}; 
			fi;
		done;
		ADDR=""
		tmp=""
		IFS=':' read -ra ADDR <<< "$LD_LIBRARY_PATH"
		for i in "${ADDR[@]}"; do
			if [[ ! ( "$i" = "" ) ]] ; then
				if [ "$tmp" = "" ] ; then
					tmp=$i
				else
					tmp=$tmp:$i
				fi;
			fi;
		done
		if [ "$tmp" = "" ] ; then
			LD_LIBRARY_PATH=$OBJ_ROOT/lib:$OBJ_ROOT_ORIGINAL/lib:$ACCELERATOR_TOOLKIT
		else
			LD_LIBRARY_PATH=$OBJ_ROOT/lib:$OBJ_ROOT_ORIGINAL/lib:$ACCELERATOR_TOOLKIT:$tmp
		fi;
		
		export LD_LIBRARY_PATH

		# deal with LIBRARY_PATH
		ADDR=""
		IFS=':' read -ra ADDR <<< "$LIBRARY_PATH"
		for i in "${ADDR[@]}"; do
			if ! [ "${i/$OBJ_ROOT_ORIGINAL}" = "$i" ]; then
				LIBRARY_PATH=${LIBRARY_PATH/$i}; 
			fi;
			if ! [ "${i/$OBJ_ROOT}" = "$i" ]; then
				LIBRARY_PATH=${LIBRARY_PATH/$i}; 
			fi;
			if ! [ "${i/$BUILD_ROOT_ORIGINAL}" = "$i" ]; then
				LIBRARY_PATH=${LIBRARY_PATH/$i}; 
			fi;
			if ! [ "${i/$BUILD_ROOT}" = "$i" ]; then
				LIBRARY_PATH=${LIBRARY_PATH/$i}; 
			fi;

			if ! [ "${i##$ACCELERATOR_TOOLKIT}" = "$i" ]; then
				LIBRARY_PATH=${LIBRARY_PATH/$i}; 
			fi;
		done;
		ADDR=""
		tmp=""
		IFS=':' read -ra ADDR <<< "$LIBRARY_PATH"
		for i in "${ADDR[@]}"; do
			if ! [ "$i" = "" ] ; then
				if [ "$tmp" = "" ] ; then
					tmp=$i
				else
					tmp=$tmp:$i
				fi;
			fi;
		done
		if [ "$tmp" = "" ] ; then
			LIBRARY_PATH=$OBJ_ROOT/lib:$OBJ_ROOT_ORIGINAL/lib:$ACCELERATOR_TOOLKIT
		else
			LIBRARY_PATH=$OBJ_ROOT/lib:$OBJ_ROOT_ORIGINAL/lib:$ACCELERATOR_TOOLKIT:$tmp
		fi;
		
		export LIBRARY_PATH
	else
		echo "\$ACCELERATOR_TOOLKIT path has not provided."
	fi;
else
	echo "export WORKING_PATH first."
fi;
else
	echo "Provide \$RELATIVE_SOURCE_PATH_ORIGINAL and \$RELATIVE_SOURCE_PATH from arguments 1 and 2."
fi;
#export OMPTARGET_LIBS=/home/hyang/install-$RELATIVE_SOURCE_PATH/lib	#<path to libomptarget project>/lib
#export LIBOMP_LIB=/home/hyang/install-$RELATIVE_SOURCE_PATH/lib	#<path to libomp project>/runtime/p8build/src/
#export LIBRARY_PATH=$OMPTARGET_LIBS:$LIBRARY_PATH
#export LD_LIBRARY_PATH=$LIBOMP_LIB:$OMPTARGET_LIBS:/opt/nvidia/cuda/lib64:$LD_LIBRARY_PATH


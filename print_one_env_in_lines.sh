#substr="$WORKING_PATH/install-llvm/usr/local"
#replace="$WORKING_PATH/install-llvm"

#IFS=':' read -ra ADDR <<< "$PATH"
##while IFS=':' read -ra ADDR; do
#	for i in "${ADDR[@]}"; do
#		if [ ! "${i/$substr}" = "$i" ] ; then
##			echo $i;
#			PATH=${PATH/$i};	#echo $i;          # process "$i"
#		fi;
#		echo $i
#	done
##done <<< "$PATH";
if ! [ "$1" = "" ]; then
#echo "before clear: $ADDR"	#not empty
ADDR=""
#echo "after clear: $ADDR"	#empty
tmp=""
IFS=':' read -ra ADDR <<< "$1"
##while IFS=':' read -ra ADDR; do 

	for i in "${ADDR[@]}"; do 
		if [ ! "$i" = "" ] ; then
			if [ "$tmp" = "" ] ; then
#				tmp=$i		#
				echo $i;
			else
#				tmp=$tmp:$i	#
				echo $i;
			fi;
		fi;
	done
##done <<< "$PATH"

#PATH=$replace/include:$replace/lib:$replace/bin:$tmp
#export PATH
else
	echo "Provided environment parameter is null or should you provide an environment parameter name which you want print begin with \$"
fi;

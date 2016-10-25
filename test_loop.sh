substr="/home/beimprovised/working/install-llvm/usr/local"
replace="/home/beimprovised/working/install-llvm"

IFS=':' read -ra ADDR <<< "$PATH"

#while IFS=':' read -ra ADDR; do
	for i in "${ADDR[@]}"; do
		if [ ! "${i/$substr}" = "$i" ] ; then
			PATH=${PATH/$i};	#echo $i;          # process "$i"
		fi;
	done
#done <<< "$PATH";
echo "before clear: $ADDR"	#not empty
ADDR=""
echo "after clear: $ADDR"	#empty
tmp=""
IFS=':' read -ra ADDR <<< "$PATH"
#while IFS=':' read -ra ADDR; do 

	for i in "${ADDR[@]}"; do 
		if [ ! "$i" = "" ] ; then
			if [ "$tmp" = "" ] ; then
				tmp=$i		#echo $i;
			else
				tmp=$tmp:$i	#echo $i;
			fi;
		fi;
	done
#done <<< "$PATH"

PATH=$replace/include:$replace/lib:$replace/bin:$tmp
export PATH

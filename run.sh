#!/bin/sh

DEV=$1
count=0

while true; do
	dd if=4K_random of=${DEV} bs=4K count=1 seek=$count
	ret=$?
	if [ $ret != 0 ]; then
		exit 0
	fi

	echo $count
	
	count=$((${count}+1))
done

#!/bin/sh

DEV=$1

zero_md5=`md5sum 4K_zero|awk '{print $1}'`
random_md5=`md5sum 4K_random|awk '{print $1}'`
first_zero=0
count=0

while true; do
	rm -rf read_4K
	dd if=${DEV} of=read_4K bs=4K count=1 skip=$count
	read_size=`ls -l read_4K|awk '{print $5}'`
	if [ ${read_size} == 0 ]; then
		echo "Success: read 0 bytes. check finished at block count: $count"
		exit 0
	fi

	read_md5=`md5sum read_4K|awk '{print $1}'`

	if [ $read_md5 != $zero_md5 ]; then
		if [ ${first_zero} == 1 ]; then
			echo "Not zero data, but first zero is already found. at block count: ${count}"
			exit 1
		fi

		if [ $read_md5 != $random_md5 ]; then
			echo "Found data is not equal with expected: at block count ${count}"	
			exit 1
		fi
	else
		if [ ${first_zero} == 0 ]; then
			echo "Found first zero block: at block count ${count}"
			first_zero=1
		fi
	fi
	count=$((${count}+1))
done

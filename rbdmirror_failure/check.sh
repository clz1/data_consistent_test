#!/bin/sh

DEV_primary=$1
DEV_passive=$2

zero_md5=`md5sum 4K_zero|awk '{print $1}'`
first_zero=0
count=0

while true; do
	rm -rf read_4K_primary
	rm -rf read_4K_passive

	dd if=${DEV_primary} of=read_4K_primary bs=4K count=1 skip=$count >/dev/null 2>&1
	dd if=${DEV_passive} of=read_4K_passive bs=4K count=1 skip=$count >/dev/null 2>&1

	read_passive_size=`ls -l read_4K_passive|awk '{print $5}'`
	if [ ${read_passive_size} == 0 ]; then
		echo "Success: read 0 bytes. check finished at block count: $count"
		exit 0
	fi

	read_primary_md5=`md5sum read_4K_primary|awk '{print $1}'`
	read_passive_md5=`md5sum read_4K_passive|awk '{print $1}'`

	if [ ${read_passive_md5} != ${zero_md5} ]; then
		if [ ${first_zero} == 1 ]; then
			echo "Not zero data, but first zero is already found. at block count: ${count}"
			exit 1
		fi

		if [ ${read_passive_md5} != ${read_primary_md5} ]; then
			echo "Found data is not equal with expected: at block count ${count}"
			exit 1
		fi

		echo "Found data is equal with read_primary_md5: at block count ${count}"
	else
		if [ ${first_zero} == 0 ]; then
			echo "Found first zero block: at block count ${count}"
			first_zero=1
		fi

		echo "Found zero block and first zero block has been ok: at block count ${count}"
	fi

	count=$((${count}+1))
done

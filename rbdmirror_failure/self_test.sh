#!/bin/sh

sh check.sh err_first_4k_fail_1.img err_first_4k_fail_2.img > /dev/null 2>&1
if [ $? != 1 ]; then
	echo "check pass, but fail expected"
	exit 1;
else
    echo "Success check first 4k fail"
fi
sh check.sh err_second_4k_fail_1.img err_second_4k_fail_2.img > /dev/null 2>&1
if [ $? != 1 ]; then
	echo "check pass, but fail expected"
	exit 1;
else
    echo "Success check second 4k fail"
fi
sh check.sh all_4K_same1.img all_4K_same2.img > /dev/null 2>&1
if [ $? != 0 ]; then
	echo "check fail, but success expected"
	exit 1;
else
    echo "Success check all 4k same"
fi
sh check.sh part_4K_same1.img part_4K_same2.img > /dev/null 2>&1
if [ $? != 0 ]; then
	echo "check fail, but success expected"
	exit 1;
else
    echo "Success check part 4k same"
fi

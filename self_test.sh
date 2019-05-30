#!/bin/sh

sh check.sh err_first_4K_fail.img
if [ $? != 1 ]; then
	echo "check pass, but fail expected"
	exit 1;
fi
sh check.sh err_second_4K_fail.img
if [ $? != 1 ]; then
	echo "check pass, but fail expected"
	exit 1;
fi
sh check.sh first_4K_random.img
if [ $? != 0 ]; then
	echo "check fail, but success expected"
	exit 1;
fi
sh check.sh first_4K_zero.img
if [ $? != 0 ]; then
	echo "check fail, but success expected"
	exit 1;
fi

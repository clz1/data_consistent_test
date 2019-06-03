#!/bin/sh

DEV=$1
SIZE=$2


fio --name test --rw=write --bs=4k --size=${SIZE} --ioengine=libaio --iodepth=1 --numjobs=1 --filename=${DEV} --direct=1 --group_reporting --eta-newline 1

echo "fio write end"

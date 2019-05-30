data consistent testing

(1) run command as below on primary image
sh run.sh /dev/vdb

(2) mirror stop

(3) check data mirroring, run command for secondary image
sh check.sh /dev/vdc

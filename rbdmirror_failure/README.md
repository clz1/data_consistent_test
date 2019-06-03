data consistent testing

For mirroring case:

	prepare a all zero image. 

	(1) run command as below on primary image
	sh run.sh /dev/vdb

	(2) mirror stop

	(3) check data mirroring, run command for secondary image
	sh check.sh /dev/vdc

For power failure case:

	prepare a all zero disk.

	(1) run command as below on target disk
	sh run.sh /dev/sdb

	(2) power failure

	(3) power on and check the same disk
	sh check.sh /dev/sdb

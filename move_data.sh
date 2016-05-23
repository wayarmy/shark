#!/bin/bash
#	Script that rsync from old server (running server) to another server (the new server with OS Base installed)
#	Check list user and group from old server, and import new user/group to new server
#	Rsync all file, library, ... from old server to new server, not overwrite exist files and exist librarry
#	
#	Pre-pair: rsync installed on both two server
#		- import your private key on new server
#		- import your public key on old server
# 	After that: run it from New Server
# This will maybe get some problem. Please fix this by yourself, or contact: quanpc@topica.edu.vn (+84) 936 555 695
# Author: @wayarmy
# MIT License


# Check list user and group old server:
function import_new_user() {
	ssh root@$1 cat /etc/passwd | while read line; do
		user=$(echo $line | awk -F ':' '{print $1}')
		if [ $(grep $user /etc/passwd | wc -l) = 0 ]; then
			echo "$line:" >> /etc/passwd
		fi
	done
	ssh root@$1 cat /etc/shadow | while read line; do
		user=$(echo $line | awk -F ':' '{print $1}')
		if [ $(grep $user /etc/shadow | wc -l)  = 0 ]; then
			echo "$line:" >> /etc/shadow
		fi
	done
}

function import_new_group() {
	ssh root@$1 cat /etc/group | while read line; do
		user=$(echo $line | awk -F ':' '{print $1}')
		if [ $(grep $user /etc/group | wc -l) = 0 ]; then
			echo "$line:" >> /etc/group
		fi
	done
}

printf "%s" "Please specify your old-server (IP-Address or Hostname) :"
read OLDSERV

if [ $OLDSERV != "" ]
then
	import_new_user $OLDSERV
	import_new_group $OLDSERV
	rsync -aAXvP --ignore-existing --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/etc/sysconfig/network-scripts/*","/etc/network/interfaces"} root@$OLDSERV:/* /
else
	echo "Please choose the old server and run this command again!!!"
	exit
fi
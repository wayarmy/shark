* Script that rsync from old server (running server) to another server (the new server with OS Base installed)
  	Check list user and group from old server, and import new user/group to new server
	Rsync all file, library, ... from old server to new server, not overwrite exist files and exist librarry

	
* Pre-pair: 
	- rsync installed on both two server
		With Centos:  "yum -y install rsync"
		With Ubuntu: "apt-get install rsync"
	- Create or import your private key on new server
		ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
	- Copy your public key to old server
		ssh-copy-id user@123.45.56.78
	After that: run it from "New Server"


* Command: 
	sh move_data.sh


* This will maybe get some problem. Please fix this by yourself, or contact: quanpc@topica.edu.vn (+84) 936 555 695
 Author: @wayarmy


* License: 
MIT License
# arch-amd64 #

## Build steps ##

1. edit pacman.conf to use prefered mirror
2. run
	```bash
	sudo ./mkrootfs.sh
	```
3. run
	```bash
	cat rootfs.tar | sudo docker import arch-amd64
	```

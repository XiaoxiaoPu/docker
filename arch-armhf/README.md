# arch-armhf #

## Build steps ##

1. edit pacman.conf to use prefered mirror
2. run
	```bash
	sudo ./mkrootfs.sh
	```
3. run
	```bash
	cat rootfs.tar | sudo docker import arch-armhf
	```

## Running ##

Before running, run commands below as root:

```bash
echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-wrapper:' > /proc/sys/fs/binfmt_misc/register
```

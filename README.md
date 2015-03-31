 # Arch Linux ARM #

A minimal Arch Linux ARM docker image for i686/x86_64 host.

## Build requirements ##

1. An i686/x86_64 Archlinux box
2. Install arch-install-scripts
3. binfmt_misc enabled kernel

## Running requirements ##

1. binfmt_misc enabled kernel

## Build steps ##

1. edit pacman.conf to use prefered mirror
2. run `mkrootfs.sh` as root
	```bash
	sudo ./mkrootfs.sh
	```
3. run
	```bash
	sudo docker build -t=archlinuxarm .
	```
	or
	```bash
	sudo docker import rootfs.tar archlinuxarm
	```

## Running ##

Before running, run commands below as root:

```bash
echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-wrapper:' > /proc/sys/fs/binfmt_misc/register
```

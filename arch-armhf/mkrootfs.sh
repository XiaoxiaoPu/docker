#!/usr/bin/env bash

# Xiaoxiao Pu <i@xiaoxiao.im>

set -e

ROOTFS=/tmp/armhf-rootfs
mkdir -p $ROOTFS
chmod 755 $ROOTFS

# get qemu-arm
curl -s -o qemu.deb http://ftp.debian.org/debian/pool/main/q/qemu/qemu-user-static_2.2+dfsg-5exp_amd64.deb
bsdtar -xf qemu.deb data.tar.xz
bsdtar -xf data.tar.xz usr/bin/qemu-arm-static
mkdir -p $ROOTFS/usr/bin
cp usr/bin/qemu-arm-static $ROOTFS/usr/bin/qemu-arm
rm -rf usr/ data.tar.xz qemu.deb

# compile qemu-wrapper
gcc -pipe -static -O2 -o qemu-wrapper qemu-wrapper.c
strip qemu-wrapper
mv qemu-wrapper $ROOTFS/usr/bin/qemu-wrapper

# binfmt_misc
echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-wrapper:' > /proc/sys/fs/binfmt_misc/register

pacstrap -C ./pacman.conf -d -G -M $ROOTFS pacman sed shadow

arch-chroot $ROOTFS /bin/sh -c 'rm -r /usr/share/man/*'
arch-chroot $ROOTFS /bin/sh -c 'ln -s /usr/share/zoneinfo/UTC /etc/localtime'
echo 'en_US.UTF-8 UTF-8' > $ROOTFS/etc/locale.gen
arch-chroot $ROOTFS locale-gen

# rebuild /dev
DEV=$ROOTFS/dev
rm -rf $DEV
mkdir -p $DEV
mknod -m 666 $DEV/null c 1 3
mknod -m 666 $DEV/zero c 1 5
mknod -m 666 $DEV/random c 1 8
mknod -m 666 $DEV/urandom c 1 9
mkdir -m 755 $DEV/pts
mkdir -m 1777 $DEV/shm
mknod -m 666 $DEV/tty c 5 0
mknod -m 600 $DEV/console c 5 1
mknod -m 666 $DEV/tty0 c 4 0
mknod -m 666 $DEV/full c 1 7
mknod -m 600 $DEV/initctl p
mknod -m 666 $DEV/ptmx c 5 2
ln -sf /proc/self/fd $DEV/fd

# binfmt_misc
echo '-1' > /proc/sys/fs/binfmt_misc/register/arm

# tar
tar --numeric-owner --xattrs --acls -C $ROOTFS -cf rootfs.tar .

# clean up
rm -rf $ROOTFS

echo Done!

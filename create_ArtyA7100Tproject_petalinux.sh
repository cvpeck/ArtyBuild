#!/bin/sh
#TODO source environments

petalinux-create --type project --template microblaze --name artytest.petalinux
mkdir -p artytest.petalinux/images/linux/sysroot_dir
cp artytest.vitis/design_1_wrapper.xsa artytest.petalinux/
cd artytest.petalinux
petalinux-config --get-hw-description
petalinux-config -c u-boot
petalinux-config -c kernel
petalinux-config -c rootfs
petalinux-build
cd images/linux/
petalinux-package --boot --fsbl fs-boot.elf --u-boot u-boot.elf --mmi ../../../artytest.runs/impl_1/design_1_wrapper.mmi --fpga ../../../artytest.runs/impl_1/design_1_wrapper.bit --force --flash-size 16 --flash-intf SPIx4


TOP = $(shell pwd)
include $(TOP)/config.mk

all: kernel toolchain

clean: clean-kernel

# ===============================
#  QEMU Test
# ===============================

test: kernel/kernel.bin
	qemu-system-i386 -kernel kernel/kernel.bin

# ===============================
#  Kernel
# ===============================

kernel: kernel/kernel.bin

clean-kernel:
	make TOP=$(TOP) -C kernel clean	

kernel/kernel.bin: toolchain
	make TOP=$(TOP) -C kernel

# ===============================
#  Toolchain
# ===============================

toolchain: toolchain/local/bin/$(TARGET)-ld toolchain/local/bin/$(TARGET)-gcc

toolchain/local/bin/$(TARGET)-ld:
	make TOP=$(TOP) -C toolchain binutils

toolchain/local/bin/$(TARGET)-gcc:
	make TOP=$(TOP) -C toolchain gcc


#
# Imported variables from command-line:
# TARGET=i686-elf
#
include $(TOP)/config.mk

all: kernel.bin

clean:
	make TOP=$(TOP) -C src clean
	rm kernel.bin

kernel.bin:
	make TOP=$(TOP) -C src
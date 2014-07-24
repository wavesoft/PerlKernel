
#
# Imported variables from command-line:
# TARGET=i686-elf
#
include $(TOP)/config.mk
include $(TOP)/kernel/src/config.mk
BINDIR=$(TOP)/toolchain/local/bin/$(TARGET)

AS_BIN=$(BINDIR)-as
AS_FLAGS=
CC_BIN=$(BINDIR)-gcc
CC_FLAGS=\
	-I$(TOP)/kernel/include \
	-I$(TOP)/kernel/include/core \
	-DNO_MALLOC_STATS \
	-DLACKS_TIME_H \
	-DLACKS_SYS_MMAN_H \
	-DLACKS_FCNTL_H \
	-DLACKS_UNISTD_H \
	-DLACKS_SYS_PARAM_H

all: ../kernel.bin

clean:
	rm -f $(OBJECTS)

../kernel.bin: linker.ld $(OBJECTS)
	$(CC_BIN) $(CC_FLAGS) -T linker.ld -o ../kernel.bin -ffreestanding -O2 -nostdlib $(OBJECTS) -lgcc

%.o: %.s
	$(AS_BIN) $(AS_FLAGS) $< -o $@

%.o: %.c
	$(CC_BIN) $(CC_FLAGS) -c $< -o $@ -std=gnu99 -ffreestanding -O2 -Wall -Wextra

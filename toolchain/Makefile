
#
# Imported variables from command-line:
# TARGET=i686-elf
#
include $(TOP)/config.mk

# Directories
DIR_SRC_BINUTILS = src/binutils-$(VERSION_BINUTILS)
DIR_SRC_GCC = src/gcc-$(VERSION_GCC)

all: binutils gcc

src:
	mkdir src

local:
	mkdir local

# =============================
# Binary utils
# =============================

binutils: local/bin/$(TARGET)-ld

src/binutils-$(VERSION_BINUTILS).tar.gz:
	wget -O src/binutils-$(VERSION_BINUTILS).tar.gz $(URL_BINUTILS)

$(DIR_SRC_BINUTILS): src src/binutils-$(VERSION_BINUTILS).tar.gz
	cd src; tar -zxf binutils-$(VERSION_BINUTILS).tar.gz

# Binutils binaries
local/bin/$(TARGET)-ld: local $(DIR_SRC_BINUTILS)
	cd $(DIR_SRC_BINUTILS); ./configure --target=$(TARGET) --prefix="$(TOP)/toolchain/local" --disable-nls --disable-werror && make && make install


# =============================
# GCC
# =============================

gcc: local/bin/$(TARGET)-gcc

# GCC files
src/gcc-$(VERSION_GCC).tar.gz: src
	wget -O src/gcc-$(VERSION_GCC).tar.gz $(URL_GCC)

# GCC sources
$(DIR_SRC_GCC): src/gcc-$(VERSION_GCC).tar.gz
	cd src; tar -zxf gcc-$(VERSION_GCC).tar.gz

# GCC outside build directory
$(DIR_SRC_GCC)-build: $(DIR_SRC_GCC) $(DIR_SRC_GCC)/libiconv $(DIR_SRC_GCC)/gmp $(DIR_SRC_GCC)/mpfr $(DIR_SRC_GCC)/mpc
	mkdir $(DIR_SRC_GCC)-build
	cd $(DIR_SRC_GCC)-build; PATH=$(PATH):local/bin ../gcc-$(VERSION_GCC)/configure --target=$(TARGET) --prefix="$(TOP)/toolchain/local" --disable-nls --enable-languages=c,c++ --without-headers

# GCC Binaries
local/bin/$(TARGET)-gcc: local $(DIR_SRC_GCC)-build
	cd $(DIR_SRC_GCC)-build; PATH=$(PATH):local/bin make all-gcc && PATH=$(PATH):local/bin make all-target-libgcc && make install-gcc && make install-target-libgcc

# Libraries
$(DIR_SRC_GCC)/libiconv: $(DIR_SRC_GCC) src/libiconv-$(VERSION_LIBICONV).tar.gz
	cd $(DIR_SRC_GCC); tar -zxf ../libiconv-$(VERSION_LIBICONV).tar.gz; mv libiconv-* libiconv

$(DIR_SRC_GCC)/gmp: $(DIR_SRC_GCC) src/gmp-$(VERSION_GMP).tar.bz2
	cd $(DIR_SRC_GCC); tar -jxf ../gmp-$(VERSION_GMP).tar.bz2; mv gmp-* gmp

$(DIR_SRC_GCC)/mpfr: $(DIR_SRC_GCC) src/mpfr-$(VERSION_MPFR).tar.gz
	cd $(DIR_SRC_GCC); tar -zxf ../mpfr-$(VERSION_MPFR).tar.gz; mv mpfr-* mpfr

$(DIR_SRC_GCC)/mpc: $(DIR_SRC_GCC) src/mpc-$(VERSION_MPC).tar.gz
	cd $(DIR_SRC_GCC); tar -zxf ../mpc-$(VERSION_MPC).tar.gz; mv mpc-* mpc

# =============================
# Additional libraries for GCC
# =============================

src/libiconv-$(VERSION_LIBICONV).tar.gz:
	wget -O src/libiconv-$(VERSION_LIBICONV).tar.gz $(URL_ICONV)

src/gmp-$(VERSION_GMP).tar.bz2:
	wget -O src/gmp-$(VERSION_GMP).tar.bz2 $(URL_GMP)

src/mpfr-$(VERSION_MPFR).tar.gz:
	wget -O src/mpfr-$(VERSION_MPFR).tar.gz $(URL_MPFR)

src/mpc-$(VERSION_MPC).tar.gz:
	wget -O src/mpc-$(VERSION_MPC).tar.gz $(URL_MPC)

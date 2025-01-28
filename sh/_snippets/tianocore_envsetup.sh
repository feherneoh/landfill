#!/usr/bin/env bash

TIANOPATH=/fill/me/out
EDKPATH="$TIANOPATH/edk2"
PLATPATH="$TIANOPATH/edk2-platforms"
NONOSIPATH="$TIANOPATH/edk2-non-osi"
EDKWORKSPACE="$TIANOPATH"

export EDK_TOOLS_PATH="$EDKPATH/BaseTools"
export PACKAGES_PATH="$EDKPATH:$PLATPATH:$NONOSIPATH:$TIANOPATH/Packages"
export CONF_PATH="$EDKWORKSPACE/Conf"

export GCC_BIN=/usr/bin/
export GCC_ARM_PREFIX=arm-none-eabi-
export GCC_AARCH64_PREFIX=aarch64-linux-gnu-
export GCC_RISCV64_PREFIX=riscv64-unknown-elf-

if ! make -C "$EDK_TOOLS_PATH"
then
	exit -1
fi 

. "$EDKPATH/edksetup.sh" BaseTools

bash


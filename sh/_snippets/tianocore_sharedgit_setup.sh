#!/usr/bin/env bash

TIANOGIT=/fill/me/out/edk2.git
PLATFORMGIT=/fill/me/out/edk2-platforms.git
NONOSIGIT=/fill/me/out/edk2-non-osi.git

mkdir -p edk2 edk2-platforms Packages Conf

git --git-dir "$TIANOGIT" worktree add edk2 master
git -C edk2 submodule update --init

git --git-dir "$PLATFORMGIT" worktree add edk2-platforms master
git -C edk2-platforms submodule update --init


git --git-dir "$NONOSIGIT" worktree add edk2-non-osi master
#git -C edk2-non-osi submodule update --init

cat > setup.sh << EOF
#!/usr/bin/env bash

TIANOPATH=$(realpath .)
EDKPATH="\$TIANOPATH/edk2"
PLATPATH="\$TIANOPATH/edk2-platforms"
NONOSIPATH="\$TIANOPATH/edk2-non-osi"
EDKWORKSPACE="\$TIANOPATH"

export EDK_TOOLS_PATH="\$EDKPATH/BaseTools"
export PACKAGES_PATH="\$EDKPATH:\$PLATPATH:\$NONOSIPATH:\$TIANOPATH/Packages"
export CONF_PATH="\$EDKWORKSPACE/Conf"

export GCC_BIN=/usr/bin/
export GCC_ARM_PREFIX=arm-eabi-
export GCC_AARCH64_PREFIX=aarch64-elf-
export GCC_RISCV64_PREFIX=riscv64-unknown-elf-

if ! make -C "$EDK_TOOLS_PATH"
then
	exit -1
fi 

. "$EDKPATH/edksetup.sh" BaseTools

bash

EOF

chmod a+x setup.sh
./setup.sh

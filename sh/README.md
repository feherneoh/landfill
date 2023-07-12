# Landfill for shell scripts

I'm mainly use BASH, so anything in this folder is NOT guaranteed to work in other shells

| Name                       | Distro           | Arch     | Description |
| -------------------------- | ---------------- | -------- | ----------- |
| `kexec-archiso`            | ArchLinux        | AMD64    | Load the ArchLinux installer kernel and ramdisk for netbooting them. Boot with `systemctl kexec` |
| `kexec-self-*`             | ArchLinux        | *Any*    | Load installed kernel and ramdisk for kexec. Great for servers where reboot would take ages. Boot with `systemctl kexec` |

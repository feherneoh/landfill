# Landfill for shell scripts

I'm mainly use BASH, so anything in this folder is NOT guaranteed to work in other shells

| Name                       | Distro           | Arch     | Description |
| -------------------------- | ---------------- | -------- | ----------- |
| `aur-install`              | ArchLinux        | *Any*    | Simple AUR package builder and installer. Comes handy for building AUR helpers found on AUR |
| `kexec-archiso`            | ArchLinux        | AMD64    | Load the ArchLinux installer kernel and ramdisk for netbooting them. Boot with `systemctl kexec` |
| `kexec-self-*`             | ArchLinux        | *Any*    | Load installed kernel and ramdisk for kexec. Great for servers where reboot would take ages. Boot with `systemctl kexec` |
| [webradio](./webradio/)    | *Any*            | *Any*    | Webradio player scripts meant to be used with Icecast |
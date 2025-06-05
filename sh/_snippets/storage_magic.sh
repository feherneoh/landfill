### LVM create single-disk VG
pvcreate -M lvm2 /dev/blockdevice
vgcreate volumegroup /dev/blockdevice

### LVM create linear LV
lvcreate -n data-lv -L $size data-vg

### LVM extend
pvresize /dev/blockdevice # to resize the LVM container on the disk/partition, affects the volume group size too. `vgextend`` is to add new disks, not to resize existing ones
lvextend /dev/volumegroup/logicalvolume --size +512G # use prefix to specify relative size

### BTRFS
btrfs filesystem resize max /mnt/point

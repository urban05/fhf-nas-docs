# FHF NAS docs

## SnapRAID
SnapRAID config located at `/etc/snapraid.conf`

### Expanding Array
uncomment or add relevant lines when adding new disks, be sure to prepare the disk,

first formatting `sudo mkfs.ext4 /dev/sdX`,

then creating mount point `sudo mkdir -p /mnt/diskX`,

then testing the mount with `sudo mount /dev/sdX /mnt/diskX` and `df -h`

then note down UUID of the disk with `blkid`

lastly add them to fstab with `sudo nano /etc/fstab` and adding the line `UUID=xxxx-xxxx  /mnt/diskX  ext4  defaults  0  2`.

### Scripts
SnapRAID all in one script used ([https://github.com/auanasgheps/snapraid-aio-script]), 

found at `~/scripts/snapraid-aio-script-3.4-beta3/snapraid-aio-script.sh`, 

config in the same dir,
should send discord and email notification (latter currently not working).

Cronjob configured in roots crontab to run script every day at 8AM.

### Pooling
SnapRAID is pooled using mergerFS,

to add more drives run `sudo mergerfs -o defaults,allow_other,use_ino,category.create=mfs /mnt/disk1:/mnt/disk2:/mnt/disk3 /mnt/pool
`,

verify and then add `/mnt/disk1:/mnt/disk2:/mnt/disk3 /mnt/pool fuse.mergerfs defaults,allow_other,use_ino,category.create=mfs 0 0` to fstab `sudo nano /etc/fstab`.

## Network Share
FHF-NAS is using a SAMBA SMB networkshare on /mnt/pool

TODO: pool drives, make pool accesible over the network, make files in pool accesible on mobile, make NAS accesible for managed devices via Zero Trust

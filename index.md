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
should send discord and email notification,
TODO: Test mailx, verify spindown of drives when idle, add cronjob for script, pool drives, make pool accesible over the network, make files in pool accesible on mobile, make NAS accesible for managed devices via Zero Trust

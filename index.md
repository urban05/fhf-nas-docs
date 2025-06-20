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
should send discord notification.

Cronjob configured in roots crontab to run script every day at 8AM.

### Pooling
SnapRAID is pooled using mergerFS,

to add more drives run `sudo mergerfs -o defaults,allow_other,use_ino,category.create=mfs /mnt/disk1:/mnt/disk2:/mnt/disk3 /mnt/pool
`,

verify and then add `/mnt/disk1:/mnt/disk2:/mnt/disk3 /mnt/pool fuse.mergerfs defaults,allow_other,use_ino,category.create=mfs 0 0` to fstab `sudo nano /etc/fstab`.

## Groups
The useres `fhfnas` and `www-data` are in the group `smb`, the group owns the `smb` folders for the networkshare

## Network Share
FHF-NAS is using a SAMBA SMB networkshare on `/mnt/pool/smb` and `/FHFshare/smb`,

it is structured into `Main` and `Share`. 

`Main` is the multiple TB big Array of SnapRAID drives, 
it has some data parity and is protected against loss of one drive.
It contains the folder `FinishedProjects`, which is considered for backups, and the `Archive`, which will not be backed-up.
Anything which can not be lost, should be in `Main/FinishedProjects`.

`Share` is some GBs from the NVMe Drive. It should be used for quick file sharing or storage of small and non-important files.
It has no parity and is not regularly backed-up.

### Connecting to the Networkshare
To Connect to the networkshare under windows, simply connect to the Zero Trust Network and type `\\192.168.0.48` in the file explorer and enter the username and password told to you.
It is also recommended to add the networkshare to your system overview, by right-clicking on the two folders shown to you under `\\192.168.0.48` and selecting `connect network share`

## Nextcloud
For access over a mobile device a nextcloud instance is running inside a docker container, created using `nc-docker-compose.yaml`. Ensure that your device is connected to the ZeroTrust Network and use the provided QR Code to log into the app.

## Notifications
FHF-NAS is sending notifications on a Discord Webhook on multiple events.

`~/scripts/snapraid-aio-script-3.4-beta3/snapraid-aio-script.sh` sends one on run with details.
when booting, rebooting, shutting down or halting  `~/scripts/discord-notify/discord_notify.sh` sends notification using the services `/etc/systemd/system/discord_startup.service`  and `/etc/systemd/system/discord_shutdown.service`,
when an SSH session is started and stopped, sends notification with tail of `/etc/bash.bashrc`,
when SSH login fails, sends notification from fail2ban using `/etc/fail2ban/action.d/discord.conf`.

#!/bin/bash 

get_disk () {
 echo "Enter the disk name: "
 read disk
 echo $disk
 sudo mount $disk /mnt
 echo "Disk mounted successfully"
 sudo mount --bind /dev /mnt/dev
 sudo mount -t proc proc /mnt/proc
 sudo mount -t sysfs sysfs /mnt/sys
}

caprice_chroot () {
 sudo chroot /mnt deluser live
 sudo chroot /mnt rm -rvf /home/live
 sudo chroot /mnt cp /etc/lightdm.conf.bak /etc/lightdm.conf
 echo "System Setup Complete!"
}

free_disk () {
 umount /mnt/dev
 umount /mnt/proc
 umount /mnt/sys
 umount /mnt
}

caprice_reboot () {
 systemctl -i reboot
}

sudo calamares && get_disk && caprice_chroot && free_disk && caprice_reboot


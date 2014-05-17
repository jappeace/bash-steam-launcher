#! /bin/bash
NEW_ROOT="/mnt/32bit"

echo "prep for chrooting"
echo "mounting virtual fs'es"
mount -o bind /dev $NEW_ROOT/dev
mount -o bind /dev/pts $NEW_ROOT/dev/pts
mount -o bind /dev/shm $NEW_ROOT/dev/shm
mount -o bind /proc $NEW_ROOT/proc
mount -o bind /sys $NEW_ROOT/sys

echo "give the new root acces to daemons and stuff like that"
#(when I read one of the error mesages a game was complaining it could not find dbus)
#also bumblbee does not work without this (you can hack arround this but not dbus)
mount -o bind /run $NEW_ROOT/run

echo "mounting portage"
mount -o bind /usr/portage $NEW_ROOT/usr/portage/

echo "mounting tmp (which is tmpfs, so fast)"
mount -o bind /tmp $NEW_ROOT/tmp

echo "chroot into 32 bit envoirement and execute chrootedCommands"
linux32 chroot $NEW_ROOT /bin/bash -c "sudo -u steam steam"

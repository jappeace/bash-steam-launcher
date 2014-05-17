#! /bin/bash
NEW_ROOT="/mnt/32bit"

# make the x server accesable
xhost +

#prep for chrooting
#virtual fs'es
mount -o bind /dev $NEW_ROOT/dev
mount -o bind /dev/pts $NEW_ROOT/dev/pts
mount -o bind /dev/shm $NEW_ROOT/dev/shm
mount -o bind /proc $NEW_ROOT/proc
mount -o bind /sys $NEW_ROOT/sys

#give the new root acces to daemons and stuff like that
#(when I read one of the error mesages a game was complaining it could not find dbus)
#also bumblbee does not work without this (you can hack arround this but not dbus)
mount -o bind /run $NEW_ROOT/run

#portage
mount -o bind /usr/portage $NEW_ROOT/usr/portage/

# tmp
mount -o bind /tmp $NEW_ROOT/tmp

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

linux32 chroot $NEW_ROOT $DIR/chrootedCommands.sh

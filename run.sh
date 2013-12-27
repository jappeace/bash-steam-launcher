#! /bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

RUNFILE=$DIR"/bootstrap.sh"
PERM=`sudo -l | grep $RUNFILE`
echo $PERM
if [$PERM == ""] 
then
	echo "adding " $RUNFILE " to run as root without password, ctrl+c to cancel"
	echo "the command: sudo sh -c '%wheel ALL=(root) NOPASSWD: '$RUNFILE >> /etc/sudoers"
	sudo sh -c "%wheel ALL=(root) NOPASSWD: "$RUNFILE >> /etc/sudoers
fi
sudo bash $RUNFILE

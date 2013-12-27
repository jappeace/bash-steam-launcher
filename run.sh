#! /bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

RUNFILE=$DIR"/bootstrap.sh"
EXEC="/usr/local/bin/runsteam"
PERM=`sudo -l | grep $EXEC`
echo $PERM
if [$PERM == ""] 
then
	sudo ln -s $DIR"/run.sh" $EXEC
	sudo chmod +x $EXEC
	echo "please add the following line to the opening editor:"
	echo "%wheel ALL=(root) NOPASSWD: $EXEC"
	sudo visudo
	echo "now rerun this script"
else
	sudo bash $RUNFILE
fi

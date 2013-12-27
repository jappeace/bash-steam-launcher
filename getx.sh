#! /bin/bash
if [[ $EUID -ne 0 ]]; then
	echo "need root exit to switch between users (allow the x from me and then write the cookie to steams home)"
	exit 1
fi

source $1

echo "deleting old files"
rm $origFile $steamFile
rm $steamHome"/.Xauthority"

echo "extracting magic cookie"
sudo -u $user xauth nextract $userFile ":0"

echo "moving the cookie to the steam directory"
mv $userFile $steamHome/

echo "fixing permisions"
chown $steam:$steam $steamFile
chmod 777 $steamFile
chmod 664 $userHome"/"$xauth
chmod -R 771 "/run/gdm"

echo "importing the cookie"
(
	sudo -u $steam xauth -i nmerge $steamFile
)
echo "cleaning up"
rm $origFile $steamFile

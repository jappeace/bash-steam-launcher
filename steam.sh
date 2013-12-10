#! /bin/bash
if [[ $EUID -ne 0 ]]; then
	echo "need root exit to switch between users (allow the x from me and then write the cookie to steams home)"
	exit 1
fi

#the steam user
$steam="steam"
#the user that has acces to the x server
$user="jappie"
$steamHome="/home/"$steam
$userHome="/home/"$user
$userFile=$userHome/"display"
$steamFile=$steamHome/"display"
rm $origFile $steamFile
sudo -u $user xauth nextract $userFile :0
sudo mv $userFile $steamHome/
sudo chown $steam:$steam $steamFile
sudo -u $steam nmerge $steamFile

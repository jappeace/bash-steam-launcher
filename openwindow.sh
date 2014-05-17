source $1

# run bumblebee
sudo bumblebeed --daemon

# run steam with bumblebee, primusrun
sudo -u $steam optirun $steamHome"/steam/steam.sh"

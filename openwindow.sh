source $1

# run bumblebee
sudo bumblebeed --daemon

# run steam with bumblebee, primusrun
sudo -u $steam bash primusrun $steamHome"/steam/steam.sh"

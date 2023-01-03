#!/bin/bash
 
# GPU Screen recording
# Sends a desktop notification.
# Made by xpander


# GPU recorder parameters
screen="DP-4"
replaybuffer="180" # in seconds
areasize="1920x1080"
container="mp4"
framerate="60"
quality="ultra" #options 'medium', 'high', 'very_high' or 'ultra'
audio="alsa_output.usb-Focusrite_Scarlett_2i2_USB-00.analog-stereo.monitor"

# Date function
DATE="`which date`"

# Location and filename
location="/mnt/backup/youtube/"
filename="`$DATE +%d%m%Y_%H.%M.%S`.$container"

# Notification time
ntime=1000 # in milliseconds

# Send notification for recording start
notify-send -t $ntime --urgency=critical --icon="nvidia" "GPU-Recorder" "Recording started" 	

# Work starts here:
# option -f records specified display
# option -b records replay buffer with specified time
# option -w records a window of specified size

if [[ $# -eq 1 ]]; then
case $1 in 
	"-f")
	gpu-screen-recorder -w $screen -c $container -f $framerate -q $quality -a $audio -o $location$filename;;
	"-b")
	gpu-screen-recorder -w $screen -c $container -f $framerate -q $quality -a $audio -r $replaybuffer -o $location$filename;;
	"-w")
	gpu-screen-recorder -w $screen -s $areasize -c $container -f $framerate -q $quality -a $audio -r $replaybuffer -o $location$filename;;
	*)
    echo "Wrong option";;
    esac
fi

# Send finishing notification after file checking
cd $location
if ls -f "$filename";
then notify-send -t $ntime --urgency=critical --icon="nvidia" "GPU-Recorder" "Recording finished";
else notify-send -t $ntime --urgency=critical --icon=error "Error" "Failed to Create the file";
fi

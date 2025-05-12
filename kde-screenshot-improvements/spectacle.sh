#!/bin/bash

windowname=()

if ! command -v kdotool > /dev/null
then
	echo "You are missing kdotool from https://github.com/jinliu/kdotool. Please install this before using this script"
	exit 1
fi

if ! command -v wl-paste > /dev/null
then
	echo "You are missing wl-clipboard. Please install this before using this script"
fi

#Clear the clipboard, to validate we're saving an image
wl-copy --clear

#Take a screenshot with Spectacle in Region mode, to clipboard, supressing notifs (which hangs spectacle otherwise)
spectacle -bcrsn > /dev/null

#Get relevant information of the window below the mouse cursor.
windowid=$(kdotool getmouselocation --shell | grep WINDOW)
windowid=${windowid//"WINDOW="/}

#echo $windowid

#Get pid of process for filename
windowpid=$(kdotool getwindowpid $windowid)
#echo $windowpid
windowname=$(ps -p $windowpid -o comm=)
#echo $windowname

#Strip spaces from process name if there
windowname=${windowname// /}

#Strip .exe from the process name if there
windowname=${windowname//".exe"/}
#echo $windowname

#Check if the directory structure already exists. If not, create it
if [ ! -d "$HOME/Pictures/Screenshots/$(date +%Y)/$(date +%B)/" ];
then
	if [ ! -d "$HOME/Pictures/Screenshots/$(date +%Y)/" ];
	then
		if [ ! -d "$HOME/Pictures/Screenshots" ];
		then
			mkdir "$HOME/Pictures/Screenshots"
		fi
		mkdir "$HOME/Pictures/Screenshots/$(date +%Y)/"
	fi
	mkdir "$HOME/Pictures/Screenshots/$(date +%Y)/$(date +%B)/"
fi

#Test if clipboard contains image. Exit without saving if not.
if wl-paste -l | grep -q 'image';
then
	#echo "picture found"
	#Output clipboard to Screenshots for archiving
	wl-paste > $HOME/Pictures/Screenshots/$(date +%Y)/$(date +%B)/$windowname-$(date '+%Y-%m-%d-%T').png
else
	exit
fi





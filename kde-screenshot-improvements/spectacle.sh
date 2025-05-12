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

#Get relevant information of the window below the mouse cursor.
windowid=$(kdotool getmouselocation --shell | grep WINDOW)
windowid=${windowid//"WINDOW="/}

echo $windowid

windowpid=$(kdotool getwindowpid $windowid)

#echo $windowclass
#echo $windowname
echo $windowpid
windowname=$(ps -p $windowpid -o comm=)
echo $windowname

#Strip spaces from process name if there
windowname=${windowname// /}

#Strip .exe from the process name if there
windowname=${windowname//".exe"/}
echo $windowname

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

#Take a screenshot with Spectacle in Region mode
spectacle -bcrs

#Output clipboard to Screenshots for archiving
wl-paste > $HOME/Pictures/Screenshots/$(date +%Y)/$(date +%B)/$(date '+%Y-%m-%d-%T').png








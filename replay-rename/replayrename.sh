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
windowid=$(kdotool getactivewindow)
#windowid=${windowid//"WINDOW="/}

#echo $windowid

#Get pid of process for filename
#windowpid=$(kdotool getwindowpid $windowid)
#echo $windowpid
windowname=$(kdotool getwindowname $windowid)
#echo $windowname

#Strip spaces from process name if there
windowname=${windowname// /}

#Strip .exe from the process name if there
windowname=${windowname//".exe"/}
#echo $windowname

newfile=$(dirname $1)
newfile="${newfile}/$windowname-$(date '+%Y-%m-%d-%T').mp4"

mv "$1" "$newfile"

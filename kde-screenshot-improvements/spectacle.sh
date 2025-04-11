#!/bin/bash

if ! command -v kdotool > /dev/null
then
	echo "You are missing kdotool from https://github.com/jinliu/kdotool. Please install this before using this script"
	exit 1
fi

#Get relevant information of the window below the mouse cursor.
windowid=$(kdotool getmouselocation --shell | grep WINDOW)
windowid=${windowid//"WINDOW="/}

#debug
echo $windowid
#kdotool getmouselocation --shell

#Get the window class for a short-but-sweet summary of the window under the cursor
windowclass=$(kdotool getwindowclassname $windowid)
#kdotool getwindowclassname $windowid

echo $windowclass

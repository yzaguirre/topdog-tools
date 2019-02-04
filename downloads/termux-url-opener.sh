#!/bin/bash
# This goes in ~/bin/termux-url-opener
#
# A menu driven shell script sample template
# https://bash.cyberciti.biz/guide/Menu_driven_scripts
if [[ x"$1" = "x" ]];
then
  echo 'HELP: termux-url-opener https://youtube.com/watch?v=1234'
  exit 0
fi
## ----------------------------------
# Step #1: Define variables
# ----------------------------------
EDITOR=vim
PASSWD=/etc/passwd
RED='\033[0;41;30m'
STD='\033[0;0;39m'
VIDEO_DIR=~/storage/movies
MUSIC_DIR=~/storage/music
VIDEO_REMOTE_DIR=/var/www/html/qr/v
VIDEO_LINK=$1
# ----------------------------------
# Step #2: User defined function
# ----------------------------------
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}
descargarm4a(){
	echo "Descargar m4a"
	cd $MUSIC_DIR
	youtube-dl -f 140 "$VIDEO_LINK"
        pause
}
descargar360(){
	echo "Descargar 360"
	cd $VIDEO_DIR
	youtube-dl -f 18 "$VIDEO_LINK"
        pause
}
descargar720(){
	echo "Descargar 720"
	cd $VIDEO_DIR
	youtube-dl -f 22/18 "$VIDEO_LINK"
        pause
}
descargar1080(){
	echo "Descargar 1080"
	cd $VIDEO_DIR
	youtube-dl -f 137+140/22/18 "$VIDEO_LINK"
        pause
}
descargarm4aRemote(){
	echo "Descargar m4a Remote"
	ssh do "cd '$VIDEO_REMOTE_DIR' || exit; youtube-dl -f 140 '$VIDEO_LINK'"
        pause
}
descargar360Remote(){
	echo "Descargar 360 Remote"
	ssh do "cd '$VIDEO_REMOTE_DIR' || exit; youtube-dl -f 18 '$VIDEO_LINK'"
        pause
}
descargar720Remote(){
	echo "Descargar 720 Remote"
	ssh do "cd '$VIDEO_REMOTE_DIR' || exit; youtube-dl -f 22 '$VIDEO_LINK'"
        pause
}
descargar1080Remote(){
	echo "Descargar 1080 Remote"
	ssh do "cd '$VIDEO_REMOTE_DIR' || exit; youtube-dl -f 137+140 '$VIDEO_LINK'"
        pause
}

# function to display menus
show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo " M A I N - M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Descargar m4a"
	echo "2. Descargar 360"
	echo "3. Descargar 720"
	echo "4. Descargar 1080"
	echo "q. Descargar m4a remote"
	echo "w. Descargar 360 remote"
	echo "e. Descargar 720 remote"
	echo "r. Descargar 1080 remote"
	echo "6. Exit"
}
# read input from the keyboard and take a action
# invoke the one() when the user select 1 from the menu option.
# invoke the two() when the user select 2 from the menu option.
# Exit when user the user select 3 form the menu option.
read_options(){
	local choice
	read -p "Enter choice [ 1 - 6 qwer ] " choice
	case $choice in
		1) descargarm4a ;;
		2) descargar360 ;;
		3) descargar720 ;;
		4) descargar1080 ;;
		q) descargarm4aRemote ;;
		w) descargar360Remote ;;
		e) descargar720Remote ;;
		r) descargar1080Remote ;;
		6) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP

# -----------------------------------
# Step #4: Main logic - infinite loop
# ------------------------------------
while true
do

	show_menus
	read_options
done

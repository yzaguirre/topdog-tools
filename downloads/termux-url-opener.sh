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
MEDIA_REMOTE_LINK=https://www.website.com/qr/v/
VIDEO_LINK=$1
# ----------------------------------
# Step #2: User defined function
# ----------------------------------
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}
descargarm4a(){
	echo "Descargar m4a (44100Hz)"
	cd $MUSIC_DIR
	youtube-dl -4f 140 "$VIDEO_LINK"
        pause
}
descargar360(){
	echo "Descargar 360 (640x338)"
	cd $VIDEO_DIR
	youtube-dl -4f 18 "$VIDEO_LINK"
        pause
}
descargar720(){
	echo "Descargar 720 (1280x676)"
	cd $VIDEO_DIR
	youtube-dl -4f 136+140/247+251/22/18 "$VIDEO_LINK"
        pause
}
descargar1080(){
	echo "Descargar 1080 (1920x1012)"
	cd $VIDEO_DIR
	youtube-dl -4f 137+140/136+140/247+251/22/18 "$VIDEO_LINK"
        pause
}
descargar1440(){
	echo "Descargar 1440 (2560x1350)"
	cd $VIDEO_DIR
	youtube-dl -4f 271+251/137+140/136+140/247+251/22/18 "$VIDEO_LINK"
        pause
}
descargar2160(){
	echo "Descargar 2160 (3840x2026)"
	cd $VIDEO_DIR
	youtube-dl -4f 313+251/271+251/137+140/136+140/247+251/22/18 "$VIDEO_LINK"
        pause
}
descargarAutomatic(){
	echo "Automatic"
	cd $VIDEO_DIR
	youtube-dl -4 "$VIDEO_LINK"
        pause
}
descargarm4aRemote(){
	echo "Descargar m4a (44100Hz) Remote"
	ssh do "cd '$VIDEO_REMOTE_DIR' || exit; youtube-dl -4f 140 '$VIDEO_LINK'"
  DOWNLOAD_LINK=${MEDIA_REMOTE_LINK}$(youtube-dl --get-filename -4f 140)
  termux-clipboard-set ${DOWNLOAD_LINK}
  termux-toast "Copied to clipboard: ${DOWNLOAD_LINK}"
        pause
}
descargar360Remote(){
	echo "Descargar 360 (640x338) Remote"
	ssh do "cd '$VIDEO_REMOTE_DIR' || exit; youtube-dl -4f 18 '$VIDEO_LINK'"
  DOWNLOAD_LINK=${MEDIA_REMOTE_LINK}$(youtube-dl --get-filename -4f 18 "$VIDEO_LINK")
  termux-clipboard-set ${DOWNLOAD_LINK}
  termux-toast "Copied to clipboard: ${DOWNLOAD_LINK}"
        pause
}
descargar720Remote(){
	echo "Descargar 720 (1280x676) Remote"
	ssh do "cd '$VIDEO_REMOTE_DIR' || exit; youtube-dl -4f 136+140/247+251/22/18 '$VIDEO_LINK'"
  DOWNLOAD_LINK=${MEDIA_REMOTE_LINK}$(youtube-dl --get-filename -4f 137+140/136+140/247+251/22/18 "$VIDEO_LINK")
  termux-clipboard-set ${DOWNLOAD_LINK}
  termux-toast "Copied to clipboard: ${DOWNLOAD_LINK}"
        pause
}
descargar1080Remote(){
	echo "Descargar 1080  (1920x1012) Remote"
	ssh do "cd '$VIDEO_REMOTE_DIR' || exit; youtube-dl -4f 137+140/136+140/247+251/22/18 '$VIDEO_LINK'"
  DOWNLOAD_LINK=${MEDIA_REMOTE_LINK}$(youtube-dl --get-filename -4f 137+140/136+140/247+251/22/18 "$VIDEO_LINK")
  termux-clipboard-set ${DOWNLOAD_LINK}
  termux-toast "Copied to clipboard: ${DOWNLOAD_LINK}"
        pause
}
descargar1440Remote(){
	echo "Descargar 1440  (2560x1350) Remote"
	ssh do "cd '$VIDEO_REMOTE_DIR' || exit; youtube-dl -4f 271+251/137+140/136+140/247+251/22/18 '$VIDEO_LINK'"
  DOWNLOAD_LINK=${MEDIA_REMOTE_LINK}$(youtube-dl --get-filename -4f 271+251/137+140/136+140/247+251/22/18 "$VIDEO_LINK")
  termux-clipboard-set ${DOWNLOAD_LINK}
  termux-toast "Copied to clipboard: ${DOWNLOAD_LINK}"
        pause
}
descargar2160Remote(){
	echo "Descargar 2160 (3840x2026) Remote"
	ssh do "cd '$VIDEO_REMOTE_DIR' || exit; youtube-dl -4f 313+251/271+251/137+140/136+140/247+251/22/18 '$VIDEO_LINK'"
  DOWNLOAD_LINK=${MEDIA_REMOTE_LINK}$(youtube-dl --get-filename -4f 313+251/271+251/137+140/136+140/247+251/22/18 "$VIDEO_LINK")
  termux-clipboard-set ${DOWNLOAD_LINK}
  termux-toast "Copied to clipboard: ${DOWNLOAD_LINK}"
        pause
}
descargarAutomaticRemote(){
	echo "Automatic Remote"
	ssh do "cd '$VIDEO_REMOTE_DIR' || exit; youtube-dl -4 '$VIDEO_LINK'"
  DOWNLOAD_LINK=${MEDIA_REMOTE_LINK}$(youtube-dl --get-filename -4 "$VIDEO_LINK")
  termux-clipboard-set ${DOWNLOAD_LINK}
  termux-toast "Copied to clipboard: ${DOWNLOAD_LINK}"
        pause
}

# function to display menus
show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo " M A I N - M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Descargar m4a  (44100Hz)"
	echo "2. Descargar 360  (640x338)"
	echo "3. Descargar 720  (1280x676)"
	echo "4. Descargar 1080 (1920x1012)"
	echo "5. Descargar 1440 (2560x1350)"
	echo "6. Descargar 2160 (3840x2026)"
	echo "7. Automatic"
	echo "q. Descargar m4a  (44100Hz)   remote"
	echo "w. Descargar 360  (640x338)   remote"
	echo "e. Descargar 720  (1280x676)  remote"
	echo "r. Descargar 1080 (1920x1012) remote"
	echo "t. Descargar 1440 (2560x1350) remote"
	echo "y. Descargar 2160 (3840x2026) remote"
	echo "u. Automatic remote"
	echo "8. Exit"
}
# read input from the keyboard and take a action
# invoke the one() when the user select 1 from the menu option.
# invoke the two() when the user select 2 from the menu option.
# Exit when user the user select 3 form the menu option.
read_options(){
	local choice
	read -p "Enter choice [ 1 - 8 qwerty ] " choice
	case $choice in
		1) descargarm4a ;;
		2) descargar360 ;;
		3) descargar720 ;;
		4) descargar1080 ;;
		5) descargar1440 ;;
		6) descargar2160 ;;
		7) descargarAutomatic ;;
		q) descargarm4aRemote ;;
		w) descargar360Remote ;;
		e) descargar720Remote ;;
		r) descargar1080Remote ;;
		t) descargar1440Remote ;;
		y) descargar2160Remote ;;
		u) descargarAutomaticRemote ;;
		8) exit 0;;
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

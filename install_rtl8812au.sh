#!/bin/sh

##############################################
# Author: Marcos Gutiérrez Alonso			 #
# Creation date: January 2021				 #
##############################################

# Install the necessary packages (if not already installed)
sudo pacman -S --needed --noconfirm git dkms

# Check if the cache folder exists (otherwise create it)
# and change directory into it
[ -e $HOME/.cache ] || mkdir -p $HOME/.cache
cd $HOME/.cache/

# Check if the repository already exists in the cache folder
# (otherwise, clone it) and move into it
[ -e $HOME/.cache/rtl8812au ] || (git clone https://github.com/aircrack-ng/rtl8812au.git || exit 1)
cd rtl8812au || exit 1

# Try to install it. Different messages depending on if it succeeds or not
if sudo make dkms_install ; then
	echo DONE!
	echo
	ls
else
	echo "Ooops... sorry"
	exit 1
fi

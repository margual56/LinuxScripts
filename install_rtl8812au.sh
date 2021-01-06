#!/bin/sh

##############################################
# Author: Marcos Gutiérrez Alonso			 #
# Creation date: January 2021				 #
##############################################

# Install the necessary packages (if not already installed)
echo "Installing 'git' and 'dkms' if needed:"
sudo pacman -S --needed --noconfirm git dkms
echo

# Install the linux headers
echo "Installing the 'linux-headers', choose the version $(uname -r):"
sudo pacman -S --needed linux-headers || exit 1
echo

# Check if the cache folder exists (otherwise create it)
# and change directory into it
echo "Cloning the driver..."
[ -e $HOME/.cache ] || mkdir -p $HOME/.cache
cd $HOME/.cache/

# Check if the repository already exists in the cache folder
# (otherwise, clone it) and move into it
[ -e $HOME/.cache/rtl8812au ] || (git clone https://github.com/aircrack-ng/rtl8812au.git || exit 1)
cd rtl8812au || exit 1
echo "Done!"

# Try to install it. Different messages depending on if it succeeds or not
echo "Installing driver..."
if sudo make dkms_install ; then
	echo Finished! Please, reboot ^-^
	exit 0
else
	echo "Ooops... sorry, something went wrong"
	echo "Uninstalling driver..."
	sudo make dkms_remove
	exit 1
fi

#!/bin/sh

###################################################
# Author: Marcos Gutiérrez Alonso
# Creation date: January 2021
###################################################

# Download the DUC program to the cache folder
dwnfolder="${HOME}/.cache"
mkdir -p $dwnfolder && cd $dwnfolder || exit 1

if [ ! -f "noip-2.1.9-1" ] ; then
	no-wget -c https://www.noip.com/client/linux/noip-duc-linux.tar.gz
	tar -xzf noip-duc-linux.tar.gz && rm -f noip-duc-linux.tar.gz
fi

cd "noip-2.1.9-1"
sudo make
sudo make install

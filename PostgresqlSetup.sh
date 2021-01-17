#!/bin/sh

########################################
# Author: Marcos Gutiérrez Alonso
# Creation date: January 2021
########################################

# Reference: https://wiki.archlinux.org/index.php/PostgreSQL

# Install postgresql
echo Installing psql...
	sudo pacman -S --needed --noconfirm postgresql

# Set variables
	# Tip: If you change the root to something other than /var/lib/postgres, you will have to edit the service file. If the root is under home, make sure to set ProtectHome to false.
	dblocation=/var/lib/postgres/data
	locale_lang=$LANG		# Run `localectl lost-locales`
	locale_encoding="UTF-8"	# Recommended
	username=$USER

mkdir -p "$dblocation"

# Change postgres user's password
echo "User postgres' password:"
	sudo passwd postgres

# Initialize the database
echo "Initializing PSQL database. Please enter postgres' password:"
	su postgres -c "initdb --locale ${locale_lang} -E ${locale_encoding} -D ${dblocation}"

	
# Enable psql's service
echo "Enable PSQL's service. Please enter sudo password:"
	sudo systemctl enable --now postgresql.service

# Create the psql user with the same name
echo "Creating the user and database in postgres. Please enter postgres' password:"
	su postgres -c "createuser --interactive -s $username"
	su postgres -c "createdb $username"

# Done! Connect to psql and exit
	echo "Done!"
	psql &
	exit 0



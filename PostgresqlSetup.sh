#!/bin/sh

########################################
# Author: Marcos Gutiérrez Alonso
# Creation date: January 2021
########################################

# Reference: https://wiki.archlinux.org/index.php/PostgreSQL

# Install postgresql
	sudo pacman -S --needed --noconfirm postgresql

# Set variables
	# Tip: If you change the root to something other than /var/lib/postgres, you will have to edit the service file. If the root is under home, make sure to set ProtectHome to false.
	dblocation=/var/lib/postgres/data
	locale_lang=$LANG		# Run `localectl lost-locales`
	locale_encoding="UTF-8"	# Recommended
	username=$USER

# Change postgres user's password
	echo "User 'postgres'\'s password:"
	sudo passwd postgres

# Initialize the database
	su postgres -c "initdb --locale=${locale_lang} -E ${locale_encoding} -D ${dblocation}"

# Enable psql's service
	sudo systemctl enable --now postgresql.service

# Create the psql user with the same name
	su postgres -c "createuser --interactive -s -U ${username} ${username}"
	su postgres -c "createdb ${username}"

# Done! Connect to psql and exit
	echo "Done!"
	psql &
	exit 0



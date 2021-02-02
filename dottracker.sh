#!/bin/sh

sudo pacman -S --needed --noconfirm git

if [ -z "$XDG_CONFIG_HOME" ]
then
	cfolder="$HOME/.dotFiles"
else
	cfolder="$XDG_CONFIG_HOME/dotFiles"
fi

echo "Creating repository in the folder '$cfolder'..."
git init --bare $cfolder
git --git-dir=$cfolder --work-tree=$HOME config --local status.showUntrackedFiles no
echo "Done!"
echo "Don't forget to add the files you want to track"
echo "I recommend adding the following to the aliases:"
echo -e "\talias dotfiles='git --git-dir=$cfolder --work-tree=$HOME'"
exit 0

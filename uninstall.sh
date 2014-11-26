#!/bin/bash
#################################################
# uninstall.sh
#
# If you're fed up with all the dots in the files, 
# just run:		$ sh uninstall.sh
#################################################

########## Variables

dir=~/.dotfiles
files="vimrc fonts ideavimrc xvimrc tmux.conf zshrc gitconfig mjolnir ycm_extra_conf.py"
oldFiles=$dir/.dotfiles.old

########## Deletions

cd $HOME

echo "Removing all dotfiles within your home directory..."
rm -rf ~/.oh-my-zsh

for file in $files; do
	echo "Deleting $file ..."
	rm -rf .$file
	echo "done"
done
echo "done"
				
echo "Removing .dotfiles directory."

echo "Reverting back to your previous settings..."
cd $oldFiles
for file in $oldFiles; do
	mv $file .$file
	mv .$file $HOME
done

cd $HOME
rm -rf .dotfiles  
echo "Uninstall complete!"





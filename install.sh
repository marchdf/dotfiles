#!/bin/bash
#================================================================================
#
# Create symlinks of dotfiles
#
#================================================================================

#================================================================================
# Setup

# list of files/folders to symlink in homedir
folders="bash git R screen woof zsh"

# list of folders to symlink in homedir (with different src and tgt names)
declare -A move_folders
move_folders[bin]=bin
move_folders[mypython]=mypython
move_folders[oh-my-zsh/custom]=.oh-my-zsh/custom

#================================================================================
# Configure directories
DOTDIR=~/dotfiles       # dotfiles directory
OLDDIR=~/dotfiles_old   # old dotfiles backup directory

# create dotfiles_old in homedir
echo "Creating a clean $OLDDIR for backup of any existing dotfiles in ~"
mv $OLDDIR $OLDDIR.bkp
mkdir -p $OLDDIR
echo "...done"

# change to the dotfiles directory
echo "Changing to the $DOTDIR directory"
cd $DOTDIR
echo "...done"

#================================================================================
# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for folder in $folders; do

    # get all the files in the directory
    files=$DOTDIR/$folder/*

    # loop on the files
    for file in $files; do

	# remove leading path name up to the last /
	fname=${file##*/} 

	# backup old copy of the file
    	echo "Moving .$fname from ~ to $OLDDIR"
	mv ~/.$fname $OLDDIR/

	# create symlink
    	echo "Creating symlink to .$fname in home directory."
	ln -s $file ~/.$fname
    done
done

#================================================================================
# We have to be a bit careful with emacs
echo "Moving .emacs from ~ to $OLDDIR"
mv ~/.emacs $OLDDIR
echo "Creating symlink to .emacs in home directory."
ln -s $DOTDIR/emacs/emacs ~/.emacs
echo "Making sure .emacs.d exists"
mkdir -p .emacs.d
echo "Creating symlink to emacs23  in .emacs.d directory."
ln -s $DOTDIR/emacs/emacs.d/emacs23 ~/.emacs.d/
echo "Creating symlink to personal in .emacs.d directory."
ln -s $DOTDIR/emacs/emacs.d/personal ~/.emacs.d/


#================================================================================
# These aren't really dotfiles but I want them version
# controlled. Copy them straight to my home without the dot stuff
for folder in "${!move_folders[@]}"; do
    src=$folder
    tgt=${move_folders[$folder]}

    # backup old copy of the file
    echo "Moving $tgt from ~ to $OLDDIR"
    mv ~/$tgt $OLDDIR/

    # create symlink
    echo "Creating symlink from $DOTDIR/$src to ~/$tgt."
    ln -s $DOTDIR/$src ~/$tgt
    
done

#================================================================================
# Clean backup dotfiles directory
rm -rf $OLDDIR.bkp

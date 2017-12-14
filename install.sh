#!/usr/bin/env bash

#================================================================================
# Functions

# Create symlinks of dotfiles using stow
install_dotfiles() {
    stow amrvis
    stow aspell
    stow bash
    stow beets
    stow bin
    stow crontab_files
    stow emacs
    stow git
    stow karabiner
    stow mypython
    stow R
    stow rsync_excludes
    stow screen
    stow sleepwatcher
    stow woof
    stow zsh
}

# Remove symlinks of dotfiles using stow
uninstall_dotfiles() {
    stow -D amrvis
    stow -D aspell
    stow -D bash
    stow -D beets
    stow -D bin
    stow -D crontab_files
    stow -D emacs
    stow -D git
    stow -D karabiner
    stow -D mypython
    stow -D R
    stow -D rsync_excludes
    stow -D screen
    stow -D sleepwatcher
    stow -D woof
    stow -D zsh
}

# Install virtual environment for the dotfiles
install_dotfiles_venv(){
    venv_name="dotfiles"
    source /usr/local/bin/virtualenvwrapper.sh
    rmvirtualenv ${venv_name}
    mkvirtualenv ${venv_name}
    workon ${venv_name}
    pip install autopep8 flake8 importmagic jedi rope yapf
    deactivate
}


#================================================================================
# Main

# Make sure GNU stow is installed
if ! command -v stow >/dev/null 2>&1; then
    echo "Please install GNU stow"
    exit 1
fi    

# install (or uninstall)
install_dotfiles

# setup a dotfiles virtualenvwrapper
#install_dotfiles_venv

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
    stow flake8
    stow git
    stow karabiner
    stow mypython
    stow R
    stow rsync_excludes
    stow screen
    stow sleepwatcher
    stow tmux
    stow vscode
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
    stow -D flake8
    stow -D git
    stow -D karabiner
    stow -D mypython
    stow -D R
    stow -D rsync_excludes
    stow -D screen
    stow -D sleepwatcher
    stow -D tmux
    stow -D vscode
    stow -D woof
    stow -D zsh
}

# Install virtual environment for the dotfiles
install_dotfiles_venv(){
    # Make sure python3 is installed
    if ! command -v python3 >/dev/null 2>&1; then
        echo "Please install python3"
        exit 1
    fi

    local_name=".venv"
    python3 -m venv "${local_name}"
    source ${local_name}/bin/activate
    pip install -r requirements.txt

    export WORKON_HOME=${HOME}/.virtualenvs
    short_name="dotfiles"
    rm "${WORKON_HOME}/${short_name}"
    ln -s "$(pwd)/${local_name}" "${WORKON_HOME}/${short_name}"
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
install_dotfiles_venv

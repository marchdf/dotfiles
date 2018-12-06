Dotfiles
========

This repository includes all of my custom dotfiles. The setup scripts
symlinks the new dotfiles to those in the `~/dotfiles`.

Installation
------------

Prerequisites: `GNU stow`, `zsh`, [`oh-my-zsh`](https://github.com/robbyrussell/oh-my-zsh), and [`fzf`](https://github.com/junegunn/fzf)

Then you can do the following:
``` bash
git clone git@github.com:marchdf/dotfiles.git ${HOME}/dotfiles
cd ~/dotfiles
./install.sh
```

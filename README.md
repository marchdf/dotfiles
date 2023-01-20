Dotfiles
========

This repository includes all of my custom dotfiles.

Installation
------------

Prerequisites: `zsh`, [`oh-my-zsh`](https://github.com/robbyrussell/oh-my-zsh), [`fzf`](https://github.com/junegunn/fzf), and [`chezmoi`](https://www.chezmoi.io)

Then you can do the following:
``` bash
chezmoi init git@github.com:marchdf/dotfiles.git
chezmoi diff
chezmoi apply -v
```

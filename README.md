dotfiles
========
<div align="center">
  <p>&nbsp;</p>
  <img src="https://raw.githubusercontent.com/jglovier/dotfiles-logo/main/dotfiles-logo.png" height="100px" alt="dotfiles" />

  <img src="https://img.shields.io/badge/macOS-%23.svg?style=flat-square&logo=apple&color=000000&logoColor=white" alt="macOS-badge" />
  <img src="https://img.shields.io/badge/Linux%20-yellow.svg?style=flat-square&logo=linux&logoColor=black" alt="Linux-badge" />

  <p>multi-platform dotfiles powered by chezmoi</p>

  [![chezmoi][chezmoi-badge]][chezmoi-web]
  [![license][license-badge]][license-file]
  [![Build Status](https://github.com/marchdf/dotfiles/workflows/dotfiles-CI/badge.svg)](https://github.com/marchdf/dotfiles/actions/workflows/ci.yml)

  [chezmoi-web]:   https://github.com/twpayne/chezmoi
  [chezmoi-badge]: https://img.shields.io/badge/Powered%20by-chezmoi-blue.svg
  [license-badge]: https://img.shields.io/github/license/marchdf/dotfiles
  [license-file]:  https://github.com/marchdf/dotfiles/blob/main/LICENSE

</div>

This repository includes all of my custom dotfiles.

Installation
------------

Prerequisites for installation are [`chezmoi`](https://www.chezmoi.io).

Then you can do the following:
``` bash
chezmoi init git@github.com:marchdf/dotfiles.git
chezmoi diff
chezmoi apply -v
```

Improved experience
-------------------

The following will lead to an improved experience:
- `zsh`
- [`oh-my-zsh`](https://github.com/robbyrussell/oh-my-zsh)
- [`fzf`](https://github.com/junegunn/fzf)

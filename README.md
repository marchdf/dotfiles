dotfiles
========
<div align="center">
  <p>&nbsp;</p>
  <img src="https://raw.githubusercontent.com/jglovier/dotfiles-logo/main/dotfiles-logo.png" height="100px" alt="dotfiles" />

  <h2></h2>
  <img src="https://img.shields.io/badge/macOS-%23.svg?style=flat-square&logo=apple&color=000000&logoColor=white" alt="macOS-badge" />
  <img src="https://img.shields.io/badge/Linux-black?style=flat-square&logo=linux&logoColor=yellow&labelColor=000000" alt="Linux-badge" />

  [![chezmoi][chezmoi-badge]][chezmoi-web]
  [![license][license-badge]][license-file]
  [![Build Status](https://github.com/marchdf/dotfiles/workflows/dotfiles-CI/badge.svg)](https://github.com/marchdf/dotfiles/actions/workflows/ci.yml)

  [chezmoi-web]:   https://github.com/twpayne/chezmoi
  [chezmoi-badge]: https://img.shields.io/badge/Powered%20by-chezmoi-blue.svg
  [license-badge]: https://img.shields.io/github/license/marchdf/dotfiles
  [license-file]:  https://github.com/marchdf/dotfiles/blob/main/LICENSE

</div>

Installation
------------

### macOS

Install chezmoi via Homebrew, then apply dotfiles:

```bash
brew install chezmoi
chezmoi init git@github.com:marchdf/dotfiles.git
chezmoi diff
chezmoi apply -v
```

### Linux

Install chezmoi to arch-specific bin:

```bash
ARCH=$(uname -m)
mkdir -p ~/.local/${ARCH}/bin
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/${ARCH}/bin
export PATH="$HOME/.local/${ARCH}/bin:$PATH"
```

Then apply dotfiles:

```bash
chezmoi init git@github.com:marchdf/dotfiles.git
chezmoi diff
chezmoi apply -v
```

For a full environment with all dependencies, run the bootstrap script first:

```bash
curl -fsSL https://raw.githubusercontent.com/marchdf/dotfiles/main/bin/executable_install_bootstrap_dependencies.sh | bash
```

Improved experience
-------------------

The following will lead to an improved experience:
- `zsh`
- [`oh-my-zsh`](https://github.com/robbyrussell/oh-my-zsh)
- [`fzf`](https://github.com/junegunn/fzf)

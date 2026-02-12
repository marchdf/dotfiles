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

```bash
brew install chezmoi
chezmoi init git@github.com:marchdf/dotfiles.git
chezmoi diff
chezmoi apply -v
```

### Linux

For a full environment with all dependencies (recommended), run the bootstrap script:

```bash
curl -fsSL https://raw.githubusercontent.com/marchdf/dotfiles/main/bin/executable_install_bootstrap_dependencies.sh | bash
chezmoi init git@github.com:marchdf/dotfiles.git
chezmoi apply -v
```

Or install manually:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"
chezmoi init git@github.com:marchdf/dotfiles.git
chezmoi apply -v
```

Improved experience
-------------------

The following will lead to an improved experience:
- `zsh`

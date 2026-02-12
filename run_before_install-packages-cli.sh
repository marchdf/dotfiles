#!/usr/bin/env bash

if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

if [[ ! -x "$(command -v zoxide)" ]]; then
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi

if [[ ! -x "$(command -v agent)" ]]; then
    curl -fsS https://cursor.com/install | bash
fi

if [[ ! -x "$(command -v claude)" ]]; then
    curl -fsSL https://claude.ai/install.sh | bash
fi

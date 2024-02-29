#!/usr/bin/env bash

if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

if [[ ! -x "$(command -v poetry)" ]]; then
    curl -sSL https://install.python-poetry.org | POETRY_VERSION=1.7.0 POETRY_HOME=${HOME}/.poetry python3 -
fi

if [[ ! -x "$(command -v zoxide)" ]]; then
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi


#!/usr/bin/env bash

if [[ ! -x "$(command -v poetry)" ]]; then
    curl -sSL https://install.python-poetry.org | POETRY_VERSION=1.7.0 POETRY_HOME=${HOME}/.poetry python3 -
fi

if [[ ! -x "$(command -v zoxide)" ]]; then
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi


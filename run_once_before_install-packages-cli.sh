#!/usr/bin/env bash

ARCH=$(uname -m)
ARCH_BIN="${HOME}/.local/${ARCH}/bin"
mkdir -p "${ARCH_BIN}"

if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

if [[ ! -x "$(command -v zoxide)" ]]; then
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    if [[ -f "${HOME}/.local/bin/zoxide" ]]; then
        mv "${HOME}/.local/bin/zoxide" "${ARCH_BIN}/"
    fi
fi

if [[ ! -x "$(command -v agent)" ]]; then
    curl -fsS https://cursor.com/install | bash
    if [[ -f "${HOME}/.local/bin/agent" ]]; then
        mv "${HOME}/.local/bin/agent" "${ARCH_BIN}/"
    fi
fi

if [[ ! -x "$(command -v claude)" ]]; then
    curl -fsSL https://claude.ai/install.sh | bash
    if [[ -f "${HOME}/.local/bin/claude" ]]; then
        mv "${HOME}/.local/bin/claude" "${ARCH_BIN}/"
    fi
fi

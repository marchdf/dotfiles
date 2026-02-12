#!/bin/bash

export PATH="$HOME/.local/bin:$PATH"

# Link mounted source to where chezmoi expects it
if [[ -d "/dotfiles-source" ]]; then
    mkdir -p "$HOME/.local/share"
    rm -rf "$HOME/.local/share/chezmoi"
    ln -sf /dotfiles-source "$HOME/.local/share/chezmoi"
    echo "Linked /dotfiles-source -> ~/.local/share/chezmoi"
fi

# Execute the command passed to the container
exec "$@"

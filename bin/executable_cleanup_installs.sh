#!/usr/bin/env bash

# Cleanup script for manually installed tools
# Removes tools installed via curl/git/zinit, but NOT brew or apt packages

set -e

DRY_RUN=false

usage() {
    echo "Usage: cleanup_installs.sh [--dry-run]"
    echo "  --dry-run    Show what would be deleted without actually deleting"
    echo ""
    echo "This removes manually installed tools (pyenv, zinit, fzf, etc.)"
    exit 0
}

if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "=== DRY RUN MODE - No files will be deleted ==="
    echo ""
elif [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    usage
fi

remove_path() {
    local path="$1"
    local description="$2"

    if [[ -e "$path" ]]; then
        if [[ "$DRY_RUN" == true ]]; then
            echo "[DRY RUN] Would remove: $path ($description)"
        else
            echo "Removing: $path ($description)"
            rm -rf "$path"
        fi
    fi
}

remove_file() {
    local path="$1"
    local description="$2"

    if [[ -f "$path" ]]; then
        if [[ "$DRY_RUN" == true ]]; then
            echo "[DRY RUN] Would remove: $path ($description)"
        else
            echo "Removing: $path ($description)"
            rm -f "$path"
        fi
    fi
}

echo "=== Cleanup Script ==="
echo "This removes manually installed tools"
echo ""

# Architecture-specific paths
ARCH=$(uname -m)
ARCH_BIN="${HOME}/.local/${ARCH}/bin"

# --- Python environment ---
echo "--- Python environment ---"
remove_path "$HOME/.pyenv" "pyenv (legacy)"
remove_path "$HOME/.virtualenvs" "virtualenvs (legacy)"
remove_path "$HOME/.poetry" "poetry (old standalone install)"
remove_path "$HOME/.local/${ARCH}/pyenv" "pyenv (arch-specific)"
remove_path "$HOME/.local/${ARCH}/virtualenvs" "virtualenvs (arch-specific)"

# --- uv ---
echo ""
echo "--- uv ---"
remove_file "$HOME/.local/bin/uv" "uv binary (legacy)"
remove_file "$HOME/.local/bin/uvx" "uvx binary (legacy)"
remove_file "${ARCH_BIN}/uv" "uv binary (arch-specific)"
remove_file "${ARCH_BIN}/uvx" "uvx binary (arch-specific)"
remove_path "$HOME/.local/share/uv" "uv data and tools"
remove_path "$HOME/.cache/uv" "uv cache"

# --- Shell tools ---
echo ""
echo "--- Shell tools ---"
remove_path "$HOME/.fzf" "fzf installation (legacy)"
remove_path "$HOME/.oh-my-zsh" "oh-my-zsh"
remove_file "$HOME/.local/bin/zoxide" "zoxide binary (legacy)"
remove_file "${ARCH_BIN}/zoxide" "zoxide binary (arch-specific)"
remove_file "${ARCH_BIN}/fzf" "fzf binary (arch-specific)"
remove_file "${ARCH_BIN}/fzf-tmux" "fzf-tmux binary (arch-specific)"

# --- zinit and plugins ---
echo ""
echo "--- zinit ---"
remove_path "$HOME/.local/share/zinit" "zinit (legacy)"
remove_path "$HOME/.local/share/zinit-${ARCH}" "zinit (arch-specific)"

# --- CLI tools (binaries only, preserve data) ---
echo ""
echo "--- CLI tools (binaries only) ---"
remove_file "$HOME/.local/bin/agent" "cursor agent binary (legacy)"
remove_file "$HOME/.local/bin/claude" "claude CLI binary (legacy)"
remove_file "${ARCH_BIN}/agent" "cursor agent binary (arch-specific)"
remove_file "${ARCH_BIN}/claude" "claude CLI binary (arch-specific)"

if [[ "$DRY_RUN" == true ]]; then
    echo ""
    echo "=== DRY RUN COMPLETE - No files were deleted ==="
    echo "Run without --dry-run to actually delete files"
else
    echo ""
    # Ensure essential directory structure exists
    mkdir -p "$HOME/.local/bin"
    mkdir -p "$HOME/.local/share"
    mkdir -p "${ARCH_BIN}"
    echo "=== Cleanup complete ==="
fi

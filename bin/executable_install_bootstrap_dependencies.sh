#!/usr/bin/env bash

OS="$(uname -s)"

if [[ "$OS" == "Darwin" ]]; then
    brew install zsh chezmoi zoxide poetry
elif [[ "$OS" == "Linux" ]]; then
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        if [[ "$ID" == "ubuntu" ]]; then
	    sudo apt-get update
	    sudo apt install -y \
		 git \
		 zsh \
		 curl \
		 zoxide \
		 python3-poetry \
		 make \
		 wget \
		 llvm \
                 clang \
                 clangd \
                 clang-format \
                 clang-tidy \
                 cmake \
                 emacs \
		 build-essential \
		 libbz2-dev \
		 libreadline-dev \
		 liblzma-dev \
		 libsqlite3-dev \
		 libssl-dev \
		 zlib1g-dev \
		 libncurses5-dev \
		 libncursesw5-dev \
		 libgdbm-dev \
		 libnss3-dev \
                 libtag1-dev \
		 xz-utils \
		 tk-dev \
		 libffi-dev \
                 npm \
                 tmux \
                 ccls \
                 mp3info \
                 mpv \
                 pianobar \
                 shellcheck \
                 vlc \
                 vorbis-tools \
                 hunspell \
                 faac \
                 grep \
                 bc \
                 gawk \
                 coreutils \
		 uuid-dev
        else
            echo "Linux (Not Ubuntu: $NAME)"
        fi
    else
        echo "Linux (Unknown distro)"
    fi
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
    export PATH="${HOME}/.local/bin:$PATH"
else
    echo "Unknown OS: $OS"
fi

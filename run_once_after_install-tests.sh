#!/usr/bin/env bash

cmds=( "fzf" "poetry" "pyenv" "zoxide" )
for cmd in "${cmds[@]}"
do
    if [[ ! -x "$(command -v $cmd)" ]]; then
        echo "$cmd was not installed!"
        exit 1
    fi
done

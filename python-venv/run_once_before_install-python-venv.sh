#!/usr/bin/env bash

# Make sure python3 is installed
if ! command -v python3 >/dev/null 2>&1; then
    echo "Please install python3"
    exit 1
fi

export WORKON_HOME=${HOME}/.virtualenvs
venv_name="dotfiles"
venv_location="${WORKON_HOME}/${venv_name}"

python3 -m venv "${venv_location}"
source ${venv_location}/bin/activate
python3 -m pip install --upgrade pip
pip3 install -r requirements.txt

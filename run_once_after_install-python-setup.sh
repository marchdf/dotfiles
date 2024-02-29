#!/usr/bin/env bash

# start clean
# rm -rf $(pyenv root)
# curl -sSL https://install.python-poetry.org | POETRY_VERSION=1.7.0 POETRY_HOME=${HOME}/.poetry python3 - --uninstall


# Make sure python3 installation worked
if ! command -v python3 >/dev/null 2>&1; then
    echo "Please install python3"
    exit 1
fi

# Install pyenv and a sane python
if [[ ! -x "$(command -v pyenv)" ]]; then
   curl https://pyenv.run | bash
fi

export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

PYTHON_VERSION="3.11.1"
${HOME}/bin/pyenv_python_install ${PYTHON_VERSION}

# Install poetry with the pyenv python
if [[ ! -x "$(command -v poetry)" ]]; then
    curl -sSL https://install.python-poetry.org | PYENV_VERSION=${PYTHON_VERSION} POETRY_VERSION=1.7.0 POETRY_HOME=${HOME}/.poetry python3 -
fi

# Create a sane dotfiles venv
export PYENV_VERSION=${PYTHON_VERSION}
export WORKON_HOME=${HOME}/.virtualenvs
venv_name="dotfiles"
venv_location="${WORKON_HOME}/${venv_name}"

echo "Installing dotfiles venv at ${venv_location} with $(python --version)"

python -m venv "${venv_location}"
source ${venv_location}/bin/activate
python -m pip install --upgrade pip
pip install --requirement=/dev/stdin <<EOF
autopep8
black
flake8
jedi
matplotlib
numpy
pandas
pycodestyle
pydocstyle
pyflakes
python-lsp-black
python-lsp-server
pyls-flake8
pylint
scikit-learn
scipy
seaborn
rope
yapf
EOF

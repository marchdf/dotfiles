#!/usr/bin/env bash

CLEAN='false'

while getopts :c flag
do
    case "${flag}" in
        c)
            CLEAN='true'
            ;;
        '?')
            echo "INVALID OPTION -- ${OPTARG}" >&2
            exit 1
            ;;
        ':')
            echo "MISSING ARGUMENT for option -- ${OPTARG}" >&2
            exit 1
            ;;
        *)
            echo "UNIMPLEMENTED OPTION -- ${flag}" >&2
            exit 1
            ;;
    esac
done

# Make sure python3 installation worked
if ! command -v python3 >/dev/null 2>&1; then
    echo "Please install python3"
    exit 1
fi

# Install pyenv and a sane python
if [[ ${CLEAN} && -x "$(command -v pyenv)" ]]; then
    if [[ -n "$(pyenv root)" && -d "$(pyenv root)" ]]; then
        echo "Cleaning pyenv: removing $(pyenv root)"
        rm -r "$(pyenv root)"
    fi
fi

if [[ ! -x "$(command -v pyenv)" ]]; then
   curl https://pyenv.run | bash
fi

export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

PYTHON_VERSION="3.12.9"
${HOME}/bin/pyenv_python_install ${PYTHON_VERSION}
pyenv global ${PYTHON_VERSION}

# Install poetry with the pyenv python
if [[ ${CLEAN} && -x "$(command -v poetry)" ]]; then
    curl -sSL https://install.python-poetry.org | POETRY_HOME=${HOME}/.poetry python3 - --uninstall
fi
if [[ ! -x "$(command -v poetry)" ]]; then
    curl -sSL https://install.python-poetry.org | PYENV_VERSION=${PYTHON_VERSION} POETRY_HOME=${HOME}/.poetry python3 -
fi

# Create a sane dotfiles venv
export PYENV_VERSION=${PYTHON_VERSION}
export WORKON_HOME=${HOME}/.virtualenvs
VENV_NAME="dotfiles"
VENV_LOCATION="${WORKON_HOME}/${VENV_NAME}"

echo "Installing dotfiles venv at ${VENV_LOCATION} with $(python --version)"

if [[ ${CLEAN} && -n "${VENV_LOCATION}" && -d "${VENV_LOCATION}" ]]; then
    echo "Cleaning python venv by removing ${VENV_LOCATION}"
    rm -rf "${VENV_LOCATION}"
fi

python -m venv "${VENV_LOCATION}"
source ${VENV_LOCATION}/bin/activate
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

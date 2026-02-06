#!/usr/bin/env bash

set -e

PYTHON_VERSION="3.12.9"

ARCH=$(uname -m)
export PYENV_ROOT="${HOME}/.local/${ARCH}/pyenv"
export WORKON_HOME="${HOME}/.local/${ARCH}/virtualenvs"

# Install pyenv if not present
if [[ ! -x "$(command -v pyenv)" ]] && [[ ! -d "${PYENV_ROOT}" ]]; then
    export PYENV_ROOT="${PYENV_ROOT}"
    curl https://pyenv.run | bash
fi

# Initialize pyenv
if [ -d "${PYENV_ROOT}" ]; then
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# Install Python version and set as global
${HOME}/bin/pyenv_python_install ${PYTHON_VERSION}
pyenv global ${PYTHON_VERSION}

# Install uv if not present
if [[ ! -x "$(command -v uv)" ]]; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# Ensure uv is in PATH
export PATH="${HOME}/.local/${ARCH}/bin:${HOME}/.local/bin:${PATH}"

# Install poetry via uv tool
if [[ ! -x "$(command -v poetry)" ]]; then
    uv tool install poetry
fi

# Create a dotfiles venv with common tools using uv
VENV_NAME="dotfiles"
VENV_LOCATION="${WORKON_HOME}/${VENV_NAME}"

if [[ ! -d "${VENV_LOCATION}" ]]; then
    echo "Creating dotfiles venv at ${VENV_LOCATION}"
    mkdir -p "${WORKON_HOME}"
    uv venv "${VENV_LOCATION}" --python "${PYTHON_VERSION}"

    # Install common Python tools and data science packages in the dotfiles venv
    uv pip install --python "${VENV_LOCATION}/bin/python" \
        black \
        flake8 \
        jedi \
        matplotlib \
        numpy \
        pandas \
        pycodestyle \
        pydocstyle \
        pyflakes \
        pylint \
        python-lsp-black \
        python-lsp-server \
        pyls-flake8 \
        rope \
        scikit-learn \
        scipy \
        seaborn
fi

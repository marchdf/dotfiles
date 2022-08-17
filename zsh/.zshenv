# According to
# http://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout
# I should be putting all the paths and things like that in this file

# User specific environment and startup programs

# homebrew
if [ -d "/opt/homebrew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PATH="${HOME}/bin:${HOME}/mypython:${HOME}/.local/bin:${PATH}"
export PYTHONPATH="${HOME}/mypython:${PYTHONPATH}"

# miniconda
MINICONDA_DIR="${HOME}/miniconda3"
if [ -d "${MINICONDA_DIR}" ]; then
    # >>> conda initialize >>>
    __conda_setup="$('${MINICONDA_DIR}/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "${MINICONDA_DIR}/etc/profile.d/conda.sh" ]; then
            . "${MINICONDA_DIR}/etc/profile.d/conda.sh"
        else
            export PATH="${MINICONDA_DIR}/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
fi

# Datathief bin dir
DATATHIEF_DIR="${HOME}/datathief"
if [ -d "${DATATHIEF_DIR}" ]; then
    export PATH="${DATATHIEF_DIR}:${PATH}"
fi

# Spack home directory
if [ -d "${HOME}/spack" ]; then
    export SPACK_DIR="${HOME}/spack"
fi

# combustion directory
export COMBUSTION_DIR="${HOME}/combustion"
export MASA_HOME="${COMBUSTION_DIR}/install/MASA"

# CCLS server
if [ -d "${HOME}/ccls" ]; then
    export PATH="${HOME}/ccls/Release/:${PATH}"
fi

# Zplug
if [ -d "${HOME}/.zplug" ]; then
    export ZPLUG_HOME="${HOME}/.zplug"
fi

# spack-manager
if [ -d "${HOME}/exawind/spack-manager" ]; then
    export SPACK_MANAGER=${HOME}/exawind/spack-manager
    source ${SPACK_MANAGER}/start.sh
fi

#================================================================================
#
# paths for Mac OSX
#
#================================================================================
if [ "$(uname)" = "Darwin" ]; then

    # github tokens
    source "${HOME}/.github_tokens"

    # openmpi fails because tmp dir name is too long
    # see: https://www.open-mpi.org/faq/?category=osx
    export TMPDIR=/tmp

    # Set vlc for terminal
    alias vlc="{HOME}/Applications/VLC.app/Contents/MacOS/VLC"

fi


#================================================================================
#
# paths for NREL HPC
#
#================================================================================
if [ "${NREL_CLUSTER}" = "eagle" ] || [ "${NREL_CLUSTER}" = "rhodes" ]; then

    # Set scratch
    if [ -d "/scratch/${USER}" ]; then
        export SCRATCH="/scratch/${USER}"
    fi

    # Set the modules
    if [ "${NREL_CLUSTER}" = "eagle" ]; then
        source /nopt/nrel/utils/lmod/lmod/init/zsh
        source /nopt/nrel/ecom/hpacf/env.sh
    elif [ "${NREL_CLUSTER}" = "rhodes" ]; then
        source /opt/base/env.sh
    fi

    # Set the tmp dir to scratch. This is because /tmp was filling up
    # when compiling Nalu with intel compilers and the debug flag
    # export TMPDIR=${SCRATCH}/.tmp

    # Load some custom modules
    . ${HOME}/.oh-my-zsh/custom/functions_nrel_hpc.zsh
    load_custom_modules

    # Nek5000
    export PATH="${HOME}/Nek5000/bin:${PATH}"

    # fasd
    export PATH="${HOME}/builds/fasd:${PATH}"

    export TMPDIR=/scratch/mhenryde/.tmp

fi

# According to
# http://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout
# I should be putting all the paths and things like that in this file

# User specific environment and startup programs
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

#================================================================================
#
# paths for Mac OSX
#
#================================================================================
if [ "$(uname)" = "Darwin" ]; then

    # github tokens
    source "${HOME}/.github_tokens"

    # homebrew sbin path
    export PATH="/usr/local/sbin:${PATH}"

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
        module purge
        MODULES=modules-2020-07
        COMPILER=gcc-8.4.0 #MPT 2.22
        #COMPILER=clang-10.0.0 #OpenMPI 4.0.4 w/verbs
        #COMPILER=intel-18.0.4 #Intel-MPI 2018.4
        module unuse ${MODULEPATH}
        module use /nopt/nrel/ecom/hpacf/binaries/${MODULES}
        module use /nopt/nrel/ecom/hpacf/compilers/${MODULES}
        module use /nopt/nrel/ecom/hpacf/utilities/${MODULES}
        module use /nopt/nrel/ecom/hpacf/software/${MODULES}/${COMPILER}
    elif [ "${NREL_CLUSTER}" = "rhodes" ]; then
        export MODULE_PREFIX=/opt/utilities/modules_prefix
        export PATH="${MODULE_PREFIX}/bin:${PATH}"
        module() { eval $(${MODULE_PREFIX}/bin/modulecmd $(basename ${SHELL}) $*); }

        MODULES=modules
        COMPILER=gcc-7.4.0
        module purge
        module unuse ${MODULEPATH}
        module use /opt/compilers/${MODULES}
        module use /opt/utilities/${MODULES}
        module use /opt/software/${MODULES}/${COMPILER}
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

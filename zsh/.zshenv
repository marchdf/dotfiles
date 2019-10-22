# According to
# http://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout
# I should be putting all the paths and things like that in this file

# User specific environment and startup programs
PATH=$HOME/bin:$HOME/mypython:$HOME/.local/bin:$PATH
export PYTHONPATH=$PYTHONPATH:$HOME/mypython

# miniconda
MINICONDA_DIR=$HOME/miniconda3
if [ -d "$MINICONDA_DIR" ]; then
    . ${MINICONDA_DIR}/etc/profile.d/conda.sh
fi

# Datathief bin dir
DATATHIEF_DIR=$HOME/datathief
if [ -d "$DATATHIEF_DIR" ]; then
    PATH=$PATH:$DATATHIEF_DIR
fi

# Spack home directory
SPACK_DIR=$HOME/spack

# specify where all the CCSE codes live
export CCSE_DIR=$HOME/combustion
export MASA_HOME=$CCSE_DIR/install/MASA

# CCLS server
if [ -d "${HOME}/ccls" ]; then
    export PATH="${HOME}/ccls/Release/:$PATH"
fi

#================================================================================
#
# paths for Mac OSX
#
#================================================================================
if [ "$(uname)" = "Darwin" ]; then

    # github tokens
    source $HOME/.github_tokens

    # homebrew sbin path
    export PATH="/usr/local/sbin:$PATH"

    # openmpi fails because tmp dir name is too long
    # see: https://www.open-mpi.org/faq/?category=osx
    export TMPDIR=/tmp

    # Set vlc for terminal
    alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
fi


#================================================================================
#
# paths for NREL HPC
#
#================================================================================
if [ "${NREL_CLUSTER}" = "eagle" ] || [ "${NREL_CLUSTER}" = "rhodes" ]; then

    # Set scratch
    if [ -d "/scratch/${USER}" ]; then
        export SCRATCH=/scratch/${USER}
    fi

    # Set the modules
    if [ "${NREL_CLUSTER}" = "eagle" ]; then
        source /nopt/nrel/utils/lmod/lmod/init/zsh
        module purge
        MODULES=modules
        COMPILER=gcc-7.4.0
        module unuse ${MODULEPATH}
        module use /nopt/nrel/ecom/hpacf/binaries/${MODULES}
        module use /nopt/nrel/ecom/hpacf/compilers/${MODULES}
        module use /nopt/nrel/ecom/hpacf/utilities/${MODULES}
        module use /nopt/nrel/ecom/hpacf/software/${MODULES}/${COMPILER}
    elif [ "${NREL_CLUSTER}" = "rhodes" ]; then
        export MODULE_PREFIX=/opt/utilities/modules_prefix
        export PATH=${MODULE_PREFIX}/bin:${PATH}
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
    export PATH=$HOME/Nek5000/bin:$PATH

fi

#================================================================================
#
# paths for navier
#
#================================================================================
if [[ ${(%):-%M} = *navier* ]]; then
    PATH=$PATH:$HOME/dg/code/scripts
    export PYTHONPATH=$PYTHONPATH:$HOME/dg/code/scripts

    # Visit bin dir
    PATH=$PATH:$HOME/visit/bin

    # TAU stuff
    PATH=$PATH:$HOME/tau-2.23.1/x86_64/bin

    # SCALASCA/CUBE stuff
    PATH=$PATH:/opt/cube/bin

    # CUDA stuff
    export PATH=/usr/local/cuda/bin:/home/marchdf/MATLAB/R2011a/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
    export PATH

fi

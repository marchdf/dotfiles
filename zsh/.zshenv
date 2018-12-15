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
export AMREX_HOME=$CCSE_DIR/amrex
export PELE_HOME=$CCSE_DIR/Pele
export PELEC_HOME=$PELE_HOME/PeleC
export PELE_PHYSICS_HOME=$PELE_HOME/PelePhysics
export MASA_HOME=$CCSE_DIR/install/MASA

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
# paths for NREL HPC (Peregrine)
#
#================================================================================
if [ "${NREL_CLUSTER}" = "peregrine" ] || [ "${NREL_CLUSTER}" = "eagle" ]; then

    # Set scratch
    export SCRATCH=/scratch/${USER}

    # Set the tmp dir to scratch. This is because /tmp was filling up
    # when compiling Nalu with intel compilers and the debug flag
    export TMPDIR=${SCRATCH}/.tmp

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

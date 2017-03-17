# According to
# http://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout
# I should be putting all the paths and things like that in this file

# User specific environment and startup programs
PATH=$HOME/bin:$HOME/mypython:$HOME/.local/bin:$PATH
export PYTHONPATH=$PYTHONPATH:$HOME/mypython

# Datathief bin dir
DATATHIEF_DIR=$HOME/datathief
if [ -d "$DATATHIEF_DIR" ]; then
    PATH=$PATH:$DATATHIEF_DIR
fi
	
# specify where all the CCSE codes live
export CCSE_DIR=$HOME/combustion
export AMREX_HOME=$CCSE_DIR/amrex
export PELE_HOME=$CCSE_DIR/Pele
export PELEC_HOME=$PELE_HOME/PeleC
export PELE_PHYSICS_HOME=$PELE_HOME/PelePhysics


#================================================================================
#
# paths for Mac OSX
#
#================================================================================
if [ "$(uname)" = "Darwin" ]; then

    # homebrew compilers
    #export HOMEBREW_CC=gcc-6
    #export HOMEBREW_CXX=g++-6
    #export HOMEBREW_FC=gfortran-6

    # github tokens
    source $HOME/.github_tokens

    # homebrew sbin path
    export PATH="/usr/local/sbin:$PATH"

    # openmpi fails because tmp dir name is too long
    # see: https://www.open-mpi.org/faq/?category=osx
    export TMPDIR=/tmp
fi


#================================================================================
#
# paths for NREL HPC (Peregrine)
#
#================================================================================
if [[ `hostname -f` = *hpc.nrel.gov ]]; then

    # Set scratch
    export SCRATCH=/scratch/${USER}

    # Set the tmp dir to scratch. This is because /tmp was filling up
    # when compiling Nalu with intel compilers and the debug flag
    export TMPDIR=${SCRATCH}/.tmp

    # Load some custom modules
    . /etc/bashrc
    {
	module purge
	module use /nopt/nrel/apps/modules/candidate/modulefiles
	module load openmpi-gcc/1.10.0-5.2.0
	module load gcc/5.2.0
	module load python/2.7.8
	module load R
    } &> /dev/null

    {
	. ${HOME}/.oh-my-zsh/custom/functions.zsh
	load_spack
	spack load binutils
	spack load texlive
	spack load screen
	spack load git
	spack load emacs
	spack load global
    } &> /dev/null

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

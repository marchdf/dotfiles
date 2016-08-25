#================================================================================
#
# These are my custom aliases for my NREL laptop
#
#================================================================================
if [[ ${(%):-%M} = stc-*.nrel.gov ]]; then
    
    # Default to python3
    alias python='python3'
    
    # custom make command for BoxLib to set the compilers from homebrew
    alias makeBL='make CC=gcc-6 CXX=g++-6 F90=gfortran-6 FC=gfortran-6'

    # open visit from the CLI
    alias visit='open /Applications/VisIt.app'
    
fi

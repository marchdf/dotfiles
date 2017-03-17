#================================================================================
#
# These are my custom aliases for my NREL laptop
#
#================================================================================
if [[ ${(%):-%M} = *stc-29682s* ]]; then

    # Default to python3
    alias python='python3'
    
    # custom make command for BoxLib to set the compilers from homebrew
    alias makeBL='make CC=gcc-6 CXX=g++-6 F90=gfortran-6 FC=gfortran-6'

    # open visit from the CLI
    alias visit='/Applications/VisIt.app/Contents/Resources/bin/visit'

    alias hpc='cd /Volumes/backup/backups/navier_datadrive/marchdf/hpcdata/'

    # Make our custom vagrant ssh. This is so the color-ssh in
    # iterm2_ssh_switch_tab_color.zsh gets called and we can easily
    # detect that we are on the Vagrant VM.
    # adapted from : http://stackoverflow.com/questions/10864372/how-to-ssh-to-vagrant-without-actually-running-vagrant-ssh
    function ssh-vagrant () { color-ssh $(vagrant ssh-config | awk 'NR>1 {print " -o "$1"="$2}') localhost}
    alias sv=ssh-vagrant
fi

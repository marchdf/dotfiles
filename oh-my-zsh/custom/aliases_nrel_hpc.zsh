#================================================================================
#
# These are my custom aliases for my NREL HPC machines
#
#================================================================================
if [[ `hostname -f` = *hpc.nrel.gov ]]; then
    alias emacs='/home/mhenryde/builds/emacs-24.5/build/src/emacs'
    alias htop='/home/mhenryde/builds/htop-2.0.2/bin/htop'
    
    # Load some custom modules
    module load python/2.7.8
fi

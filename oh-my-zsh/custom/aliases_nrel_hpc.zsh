#================================================================================
#
# These are my custom aliases for my NREL HPC machines
#
#================================================================================
if [[ `hostname -f` = *hpc.nrel.gov ]]; then
    alias emacs='/home/mhenryde/builds/emacs-24.5/build/src/emacs'
    alias htop='/home/mhenryde/builds/htop-2.0.2/bin/htop'

    alias job_node_ids="qstat -u mhenryde -f | grep -e 'Job\ Id\|exec_host'"
    alias cds="cd /scratch/mhenryde"
    
    # Load some custom modules
    module load python/2.7.8
    module use /nopt/nrel/apps/modules/candidate/modulefiles
fi

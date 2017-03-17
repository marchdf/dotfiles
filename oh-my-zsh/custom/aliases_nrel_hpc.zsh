#================================================================================
#
# These are my custom aliases for my NREL HPC machines
#
#================================================================================
if [[ `hostname -f` = *hpc.nrel.gov ]]; then
    alias htop='/home/mhenryde/builds/htop-2.0.2/bin/htop'
    alias job_node_ids="qstat -u mhenryde -f | grep -e 'Job\ Id\|exec_host\|Job_Name'"
    alias cds="cd /scratch/mhenryde"

fi

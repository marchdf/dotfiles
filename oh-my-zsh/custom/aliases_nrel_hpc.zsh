#================================================================================
#
# These are my custom aliases for my NREL HPC machines
#
#================================================================================
if [[ `hostname -f` = *hpc.nrel.gov ]]; then
    alias htop='/home/mhenryde/builds/htop-2.0.2/bin/htop'
    alias job_node_ids="qstat -u mhenryde -f | grep -e 'Job\ Id\|exec_host\|Job_Name'"
    alias cds="cd /scratch/mhenryde"

    # Load some custom modules (they need to go here)
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
    } &> /dev/null

fi

#================================================================================
#
# These are my custom aliases for my NREL HPC machines
#
#================================================================================
if [[ `hostname -f` = *hpc.nrel.gov ]]; then
    alias emacs='/home/mhenryde/builds/emacs-24.5/build/src/emacs'
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
    } &> /dev/null

    # Spack (according to Jon Rood)
    export SPACK_ROOT=${HOME}/spack
    source $SPACK_ROOT/share/spack/setup-env.sh

    {
	spack load binutils
	spack load texlive
    } &> /dev/null

fi

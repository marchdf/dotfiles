#================================================================================
#
# These are my custom aliases for my NREL HPC machines
#
#================================================================================
if [[ `hostname -f` = *hpc.nrel.gov ]]; then

    function conda_workon {

	module unload python

	local CONDA_PATH=${HOME}/miniconda3/bin

	if test -z "$1" ; then
            ${CONDA_PATH}/conda info --envs
	else
	    source ${CONDA_PATH}/activate $1
	fi
    }

    function conda_stop {

	local CONDA_PATH=${HOME}/miniconda3/bin

	if test -z "$1" ; then
            ${CONDA_PATH}/conda info --envs
	else
	    source ${CONDA_PATH}/deactivate $1
	fi

	load_custom_modules
    }

    function load_custom_modules {

	{
	    . /etc/bashrc
	    module purge
	    module use /nopt/nrel/apps/modules/candidate/modulefiles
	    module load gcc/5.2.0
	    module load openmpi-gcc/1.10.0-5.2.0
	    module use /projects/windsim/exawind/BaseSoftware/spack/share/spack/modules/linux-centos6-x86_64
	    module load binutils
	    module load emacs
	    module load git
	    module load global
            module load htop
            module load libtool
	    module load llvm/5.0.0
	    module load python/2.7.14
	    module load swig
	    module load texlive
	} &> /dev/null
    }

fi

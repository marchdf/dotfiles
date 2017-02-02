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

fi

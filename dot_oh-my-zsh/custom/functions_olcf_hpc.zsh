# These are my custom aliases for my OLCF HPC machines
if [ "${LMOD_SYSTEM_NAME}" = "frontier" ]; then

    function load_custom_modules {

        {
	    module load DefApps-spi/default
	    module load cmake
	    module load emacs
	    module load go
	    module load htop
	    module load imagemagick
	    module load tmux

	    module load cray-python

        } &> /dev/null
    }

fi

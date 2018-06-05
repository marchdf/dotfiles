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
            module use /nopt/nrel/ecom/ecp/base/modules/gcc-6.2.0
            module load gcc/6.2.0
            module load openmpi/1.10.4
            module load git/2.17.0
	    module load binutils
            module load cmake
	    module load emacs
	    module load git
	    module load global
            module load htop
            module load libtool
	    module load llvm/6.0.0
            module load swig
	    module load texlive
	} &> /dev/null
    }

    function load_spack_python2 {

	{
	    . /etc/bashrc
            module use /nopt/nrel/ecom/ecp/base/modules/gcc-6.2.0
	    module load python/2.7.14
            module load py-alabaster/0.7.10-py2
            module load py-autopep8/1.3.3-py2
            module load py-babel/2.4.0-py2
            module load py-backports-functools-lru-cache/1.5-py2
            module load py-bottleneck/1.0.0-py2
            module load py-configparser/3.5.0-py2
            module load py-cycler/0.10.0-py2
            module load py-cython/0.25.2-py2
            module load py-dateutil/2.5.2-py2
            module load py-docutils/0.13.1-py2
            module load py-enum34/1.1.6-py2
            module load py-flake8/3.5.0-py2
            module load py-functools32/3.2.3-2-py2
            module load py-imagesize/0.7.1-py2
            module load py-jedi/0.10.0-py2
            module load py-jinja2/2.9.6-py2
            module load py-lit/0.5.0-py2
            module load py-mako/1.0.4-py2
            module load py-markupsafe/1.0-py2
            module load py-matplotlib/2.2.2-py2
            module load py-mccabe/0.6.1-py2
            module load py-nose/1.3.7-py2
            module load py-numexpr/2.6.1-py2
            module load py-numpy/1.13.3-py2
            module load py-pandas/0.21.1-py2
            module load py-pillow/3.2.0-py2
            module load py-pip/9.0.1-py2
            module load py-pycodestyle/2.3.1-py2
            module load py-pyflakes/1.6.0-py2
            module load py-pygments/2.2.0-py2
            module load py-pyparsing/2.2.0-py2
            module load py-pytz/2017.2-py2
            module load py-pyyaml/3.11-py2
            module load py-requests/2.14.2-py2
            module load py-rope/0.10.5-py2
            module load py-scipy/1.0.0-py2
            module load py-seaborn/0.7.1-py2
            module load py-setuptools/39.0.1-py2
            module load py-six/1.11.0-py2
            module load py-snowballstemmer/1.2.1-py2
            module load py-sphinx/1.6.3-py2
            module load py-sphinx-rtd-theme/0.2.5b1-py2
            module load py-sphinxcontrib-websupport/1.0.1-py2
            module load py-subprocess32/3.2.7-py2
            module load py-typing/3.6.1-py2
            module load py-yapf/0.2.1-py2
	} &> /dev/null
    }

fi

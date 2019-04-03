#================================================================================
#
# These are my custom aliases for my NREL HPC machines
#
#================================================================================
if [ "${NREL_CLUSTER}" = "peregrine" ] || [ "${NREL_CLUSTER}" = "eagle" ]; then

    function load_custom_modules {

	{
	    . /etc/bashrc
	    module purge
            module unuse ${MODULEPATH}
            module use /nopt/nrel/ecom/hpacf/compilers/modules
            module use /nopt/nrel/ecom/hpacf/utilities/modules
            module use /nopt/nrel/ecom/hpacf/software/modules/gcc-7.3.0
            module load gcc
            module load mpich
	    module load binutils
            module load cmake
	    module load emacs
            module load git
	    module load global
            module load gnutls
            module load htop
            module load image-magick
            module load libtool
	    module load llvm
            module load python/3.6.5
            module load py-setuptools/40.4.3-py3
            module load swig
	    module load texlive
            module load tmux
            module load zsh
	} &> /dev/null
    }

    function load_spack_python2 {

        {
	    . /etc/bashrc
            module use /nopt/nrel/ecom/hpacf/compilers/modules
            module use /nopt/nrel/ecom/hpacf/utilities/modules
            module use /nopt/nrel/ecom/hpacf/software/modules/gcc-7.3.0
	    module load python/2.7.15
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
            module load py-numpy/1.15.2-py2
            module load py-pandas/0.23.4-py2
            module load py-pillow/3.2.0-py2
            module load py-pip/9.0.1-py2
            module load py-pycodestyle/2.3.1-py2
            module load py-pyflakes/1.6.0-py2
            module load py-pygments/2.2.0-py2
            module load py-pyparsing/2.2.0-py2
            module load py-pytz/2017.2-py2
            module load py-pyyaml/3.13-py2
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

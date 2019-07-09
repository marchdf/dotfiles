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
            MODULES=modules-2019-05-08
            COMPILER=gcc-7.4.0
            module unuse ${MODULEPATH}
            module use /nopt/nrel/ecom/hpacf/binaries/${MODULES}
            module use /nopt/nrel/ecom/hpacf/compilers/${MODULES}
            module use /nopt/nrel/ecom/hpacf/utilities/${MODULES}
            module use /nopt/nrel/ecom/hpacf/software/${MODULES}/${COMPILER}
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
            module load python/3.7.3
            module load py-setuptools/40.8.0-py3
            module load swig
            module load texlive
            module load tmux
            module load zsh
        } &> /dev/null
    }

    function load_spack_python2 {

        {
            . /etc/bashrc
            MODULES=modules-2019-05-08
            COMPILER=gcc-7.4.0
            module use /nopt/nrel/ecom/hpacf/binaries/${MODULES}
            module use /nopt/nrel/ecom/hpacf/compilers/${MODULES}
            module use /nopt/nrel/ecom/hpacf/utilities/${MODULES}
            module use /nopt/nrel/ecom/hpacf/software/${MODULES}/${COMPILER}
            module load python/2.7.16
            #pymodules="$(module --raw --redirect avail | grep -o 'py-[^ ]*py2' | tr '\n' ' ')"
            # echo $pymodules
            while read -r line ; do
                module load $line
            done < <(module --raw --redirect avail | grep -o 'py-[^ ]*py2')
        } &> /dev/null
    }

fi

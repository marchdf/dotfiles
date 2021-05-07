#================================================================================
#
# These are my custom aliases for my NREL HPC machines
#
#================================================================================
if [ "${NREL_CLUSTER}" = "eagle" ] || [ "${NREL_CLUSTER}" = "rhodes" ]; then

    function load_custom_modules {

        {
            module purge
            module load gcc
            module load mpt
            module load binutils
            module load cmake
            module load emacs
            module load git
            module load gnutls
            module load htop
            module load image-magick
            module load libtool
            module load python/3.7.7
            module load py-setuptools-scm
            module load texlive
            module load tmux
        } &> /dev/null
    }

    function load_spack_python3 {

        {
            module load python/3.7.7
            #pymodules="$(module --raw --redirect avail | grep -o 'py-[^ ]*py2' | tr '\n' ' ')"
            # echo $pymodules
            while read -r line ; do
                module load $line
            done < <(module --raw --redirect avail | grep -o 'py-[^ ]*py3')
        } &> /dev/null
    }

    function pv58server() {
        source /nopt/nrel/ecom/exawind/exawind/scripts/exawind-env-gcc.sh
        module load paraview/5.8.1-server
        case $# in
            "0" )
                srun -n 1 -c 1 --cpu_bind=cores pvserver
                ;;
            "1" )
                srun -n $1 -c 1 --cpu_bind=cores pvserver
                ;;
        esac
    }

    function pv58gui() {
        source /nopt/nrel/ecom/exawind/exawind/scripts/exawind-env-gcc.sh
        module load paraview/5.8.1-gui
        vglrun paraview
    }

    function pvtunnel() {
        ssh -L 11111:$1:11111 mhenryde@$1
    }

fi

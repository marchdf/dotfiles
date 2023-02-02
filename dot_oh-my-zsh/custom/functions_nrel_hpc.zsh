# These are my custom aliases for my NREL HPC machines
if [ "${NREL_CLUSTER}" = "eagle" ] || [ "${NREL_CLUSTER}" = "rhodes" ]; then

    function load_custom_modules {

        {
            module purge
            module load gcc
            module load mpt
            module load binutils
            module load bzip2
            module load cmake
            module load ffmpeg/4.2.2
            module load git
            module load gnutls
            module load htop
            module load image-magick
            module load libffi
            module load libtool
            module load openssl
            module load python/3.7.7
            module load py-setuptools-scm
            module load sqlite
            module load texlive
            module load tmux

            module load emacs/28.2
        } &> /dev/null
    }

    function load_spack_python3 {

        {
            module load python/3.7.7
            while read -r line ; do
                module load $line
            done < <(module --raw --redirect avail | grep -o 'py-\S*')
        } &> /dev/null
    }

    function pv59server() {
        source /nopt/nrel/ecom/exawind/exawind/scripts/exawind-env-gcc.sh
        case $# in
            "0" )
                srun -n 1 -c 1 --cpu_bind=cores /nopt/nrel/ecom/exawind/exawind/install/paraview/5.9.0/bin/pvserver
                ;;
            "1" )
                srun -n $1 -c 1 --cpu_bind=cores /nopt/nrel/ecom/exawind/exawind/install/paraview/5.9.0/bin/pvserver
                ;;
        esac
    }

    function pv59gui() {
        source /nopt/nrel/ecom/exawind/exawind/scripts/exawind-env-gcc.sh
        vglrun /nopt/nrel/ecom/exawind/exawind/install/paraview/5.9.0/bin/paraview
    }

    function pv510gui() {
        module load paraview/5.10.1-gui
        vglrun paraview
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

    function pyenv_python_install(){
        module load gcc
        module load mpt
        module load binutils
        module load git
        module load gnutls
        module load libtool
        module load texlive
        module load bzip2
        module load libffi
        module load openssl
        module load sqlite
        export LDFLAGS="-L${OPENSSL_ROOT_DIR}/lib -L${LIBFFI_ROOT_DIR}/lib64 -L${BZIP2_ROOT_DIR}/lib -L${SQLITE_ROOT_DIR}/lib"
        export CPPFLAGS="-I${OPENSSL_ROOT_DIR}/include -I${LIBFFI_ROOT_DIR}/include -I${BZIP2_ROOT_DIR}/include -I${SQLITE_ROOT_DIR}/include"
        export PYTHON_CONFIGURE_OPTS="--enable-optimizations --with-lto"
        export PYTHON_CFLAGS="-mtune=native"
        pyenv install
    }

fi

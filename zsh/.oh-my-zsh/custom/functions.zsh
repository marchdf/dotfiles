#================================================================================
#
# These are my custom functions
#
#================================================================================
# print each directory of argument $PATH on its own line
function prettypath() { echo ${1-$PATH} | sed 's/:/\n/g'; }

# Calls the teatimer script
function tt() { ~/bin/teatimer.sh "$@" &}

# Calls the pdf2eps script
function pdf2eps() { ~/bin/pdf2eps.sh "$@" &}

# refresh directory (if the directory was deleted from underneath us
# and we are still in it, try to re-cd to the directory)
function recd() { cd `pwd`; }

# Diff two files using emacs ediff
# From: https://defunitive.wordpress.com/2011/07/23/invoking-emacs-ediff-from-the-command-line/
function ediff() {
    if [ "X${2}" = "X" ]; then
	echo "USAGE: ediff <FILE 1> <FILE 2>"
    else
	# The --eval flag takes lisp code and evaluates it with emacs
	e --eval "(ediff-files \"$1\" \"$2\")"
    fi
}

# Load spack environment if you want it. I do this instead of loading
# it by default because it would slow down terminal startup time
function load_spack(){
    if [ -d "$SPACK_DIR" ]; then
	export SPACK_ROOT=${SPACK_DIR}
	. ${SPACK_ROOT}/share/spack/setup-env.sh
    fi
}

# Grep through all python scrips in home directory
function grep_python() {
    grep -r --include=\*.py --exclude-dir=.virtualenvs --exclude-dir=.emacs.d --exclude-dir=spack --exclude-dir=.oh-my-zsh "${1}" ${HOME}
}

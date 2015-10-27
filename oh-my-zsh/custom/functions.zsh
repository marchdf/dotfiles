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

# refresh directory (if the directory was deleted from underneat us
# and we are still in it, try to re-cd to the directory)
function recd() { cd `pwd`; }

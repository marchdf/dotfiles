# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

# Set the default editor to emacs if emacs is installed
if [ -f /usr/bin/emacs ] || [ -f /usr/local/bin/emacs ] ; then
    export EDITOR='emacs -nw'
    export VISUAL=${EDITOR}
fi

#================================================================================
#
# These are my general aliases
#
#================================================================================

alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias engin='ssh marchdf@login.engin.umich.edu'
alias itd='ssh marchdf@login.itd.umich.edu'
alias rl='ssh marchdf@rayleigh.engin.umich.edu'
alias nv='ssh -X marchdf@navier.engin.umich.edu'
alias e='emacs -nw'
alias rmeps='rm *.eps'
alias rmpng='rm *.png'
alias rmpdf='rm -i *.pdf'
alias rmself='self=`pwd`; cd ..; rm -rf $self'
alias sx='source ~/.xinitrc'
alias fls="fast_ls"  # fast ls from TACC
alias c21='vlc http://www.static.rtbf.be/radio/classic21/m3u/classic21_128k.m3u'
if [[ -x `which htop` ]]; then alias top="htop"; fi
alias sshot='import ~/Desktop/screenshot.jpg' # screenshot (pick area to grab)
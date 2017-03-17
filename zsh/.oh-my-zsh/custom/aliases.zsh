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
alias e='$ZSH/plugins/emacs/emacsclient.sh -nw'
alias rmeps='rm *.eps'
alias rmpng='rm *.png'
alias rmpdf='rm -i *.pdf'
alias rmself='self=`pwd`; cd ..; rm -rf $self'
alias sx='source ~/.xinitrc'
alias fls="fast_ls"  # fast ls from TACC
alias c21='vlc http://www.static.rtbf.be/radio/classic21/m3u/classic21_128k.m3u'
if [[ -x `which htop` ]]; then alias top="htop"; fi
alias sshot='import ~/Desktop/screenshot.jpg' # screenshot (pick area to grab)
alias empty_space='printf ''\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n'''
alias qs='qstat -u $USER'

# upgrade all python packages with pip.
# from http://mikegrouchy.com/blog/2014/06/pro-tip-pip-upgrade-all-python-packages.html
# periodically check this to make sure that pip didn't add this new feature
alias pip2_upgrade_all='pip2 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip2 install -U'
alias pip3_upgrade_all='pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip3 install -U' 

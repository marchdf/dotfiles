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
alias ek='emacsclient -e "(kill-emacs)"'
alias rmeps='rm *.eps'
alias rmpng='rm *.png'
alias rmpdf='rm -i *.pdf'
alias rmself='self=`pwd`; rm -r *; cd `dirname $self`; rm -r $self;'
alias sx='source ~/.xinitrc'
alias fls="fast_ls"  # fast ls from TACC
alias sshot='import ~/Desktop/screenshot.jpg' # screenshot (pick area to grab)
alias empty_space='printf ''\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n'''
alias qs='qstat -u $USER'

# Improving CLI
if [[ -x "$(command -v htop)" ]]; then alias top="htop"; fi
if [[ -x "$(command -v bat)" ]]; then alias cat="bat"; fi
if [[ -x "$(command -v prettyping)" ]]; then alias ping="prettyping"; fi
if [[ -x "$(command -v tldr)" ]]; then alias help="tldr"; fi

# Classic 21 radio, if not working check something like https://fluxradios.blogspot.com/2014/07/flux-url-classic-21.html
alias c21='vlc https://www.static.rtbf.be/radio/classic21/m3u/classic21-mp3.m3u'

# Weather using https://github.com/chubin/wttr.in
alias weather='curl wttr.in/\?m'

# upgrade all python packages with pip.
# from http://mikegrouchy.com/blog/2014/06/pro-tip-pip-upgrade-all-python-packages.html
# periodically check this to make sure that pip didn't add this new feature
alias pip2_upgrade_all='pip2 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip2 install -U'
alias pip3_upgrade_all='pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip3 install -U' 

# Mass renaming of files
# e.g. mmv *.dat *.dat_old
autoload -U zmv
alias mmv='noglob zmv -W'

#================================================================================
#
# These are my general aliases
#
#================================================================================

alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias e="$ZSH/plugins/emacs/emacsclient.sh -nw"
alias ek='emacsclient -e "(kill-emacs)"'
alias rmeps="rm *.eps"
alias rmpng="rm *.png"
alias rmpdf="rm -i *.pdf"
alias sshot="import ~/Desktop/screenshot.jpg" # screenshot (pick area to grab)
alias empty_space="printf ''\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n''"
alias lt="ls -lt"

# Improving CLI
if [[ -x "$(command -v htop)" ]]; then alias top="htop"; fi
if [[ -x "$(command -v bat)" ]]; then alias cat="bat"; fi
if [[ -x "$(command -v prettyping)" ]]; then alias ping="prettyping"; fi
if [[ -x "$(command -v tldr)" ]]; then alias help="tldr"; fi

# Weather using https://github.com/chubin/wttr.in
alias weather="curl wttr.in/\?m"

# upgrade all python packages with pip.
# from http://mikegrouchy.com/blog/2014/06/pro-tip-pip-upgrade-all-python-packages.html
# periodically check this to make sure that pip didn't add this new feature
alias pip2_upgrade_all="pip2 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip2 install -U"
alias pip3_upgrade_all="pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip3 install -U"

# Mass renaming of files
# e.g. mmv *.dat *.dat_old
autoload -U zmv
alias mmv="noglob zmv -W"

# Cluster aliases
if [[ -x "$(command -v qstat)" ]]; then
    alias qs="qstat -u $USER";
    alias job_node_ids="qstat -u $USER -f | grep -e 'Job\ Id\|exec_host\|Job_Name'"
fi

if [[ -x "$(command -v squeue)" ]]; then
    alias qs="squeue -u $USER -o '%12i %.9P %20j %.2t %.10M %.6D %r %N'"
    alias qnodes="sinfo -o '%24P %.5a  %.12l  %.16F'"
fi

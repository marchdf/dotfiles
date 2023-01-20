#Usage:
# source iterm2.zsh
#
# Forked from: https://gist.github.com/wadey/1140259
#


# iTerm2 window/tab color commands
#   Requires iTerm2 >= Build 1.0.0.20110804
#   http://code.google.com/p/iterm2/wiki/ProprietaryEscapeCodes
tab-color() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}
tab-reset() {
    echo -ne "\033]6;1;bg;*;default\a"
}

# Change the color of the tab when using SSH
# reset the color after the connection closes
color-ssh() {
    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "tab-reset" INT EXIT
        if [[ "$*" =~ "navier|other_*_machine" ]]; then
            tab-color 24 90 169
        elif [[ "$*" =~ "cori|edison" ]]; then
            tab-color 244 125 35
        elif [[ "$*" =~ "machine1a|machine1b" ]]; then
            tab-color 102 44 155
        elif [[ "$*" =~ "machine2a|machine2b" ]]; then
            tab-color 162 29 33
        elif [[ "$*" =~ "machine3a|machine3b" ]]; then
            tab-color 180 56 148
        else
            tab-color 0 140 72
        fi
    fi
    ssh $*
}
compdef _ssh color-ssh=ssh

alias ssh=color-ssh

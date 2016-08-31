#!/bin/bash    
#
# This script displays a notification to prompt the user to update
# their system. We don't want to automatically update the system (that
# is evil) so we kindly remind the user to do so.
#
# The one caveat (for Arch) is that we need that have the user get the
# dbus address on login (so you need to run get_dbus_address.sh on
# login)
#
# Put this in the crontab and run it once a week.
#


#================================================================================
#
# Notification for Mac platform
#
#================================================================================
if [ "$(uname)" == "Darwin" ]; then

    # Make sure you installed terminal-notifier with homebrew
    /usr/local/bin/terminal-notifier -title "You should upgrade your system." -message $'brew update; brew outdated; brew upgrade; pip_upgrade_all' -contentImage $HOME/bin/shadow.png;

#================================================================================
#
# Notification for GNU/Linux platform
#
#================================================================================
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then

    # since we are using notify-send, for it to work with crontab, you
    # need to set the DBUS_SESSION_BUS_ADDRESS.
    # see: http://unix.stackexchange.com/questions/111188/using-notify-send-with-cron
    # Source the script which sets the DBUS session address
    if [ -r "$HOME/.dbus/Xdbus" ]; then
	. "$HOME/.dbus/Xdbus"
    fi

    # Send the notification
    notify-send -i $HOME/bin/shadow.png -u critical "You should upgrade your system." "<b>- remove unused programs:</b> pacman -Rns \$(pacman -Qtdq)\\n<b>- upgrade:</b> pacman -Syu\\n<b>- upgrade AUR:</b> cd builds; cower -vduf\\n<b>- merge pac files:</b> sudo DIFFPROG=meld pacdiff" ;
fi

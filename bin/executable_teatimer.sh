#!/usr/bin/env bash
#
# Make a tea timer display a notification
# Input the time, defaults to 3 minutes

if [ -z "$1" ];
then
    TIME="3m";
else
    TIME=$1;
fi

# Notification for Mac platform
if [ "$(uname)" == "Darwin" ]; then

    # Wait the specified time (need to brew install coreutils)
    gsleep "$TIME";

    # Make sure sound is enabled
    osascript -e "set Volume 2"

    # Doesn't work with ventura
    # Make sure you installed terminal-notifier with homebrew
    # Also increase the notification banner time by doing:
    # defaults write com.apple.notificationcenterui bannerTime 15
    # taken from: https://9to5mac.com/2014/01/30/how-to-change-os-x-banner-notification-duration-using-terminal/
    # terminal-notifier -title "Your tea is ready!" -message "" -sound default -contentImage "$HOME/bin/tea.jpg";

    # Display notification
    osascript -e 'display notification "--" with title "Your tea is ready"'

    # Make my own sound aiff with the old system beep? and play it like this
    afplay /System/Library/Sounds/Funk.aiff
    
    # Make sure sound is disabled (but wait for previous command to end)
    gsleep 1s;
    osascript -e "set Volume 0"

    
# Notification for GNU/Linux platform
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then

    # Wait the specified time
    sleep "$TIME";

    # Send the notification
    notify-send -t 10000 -i "$HOME/bin/tea.jpg" "Your tea is ready!";

    # Run the system beep thing. 
    #
    # In RHEL6, you first need to modprobe pcspkr you can add it to boot
    # by adding /etc/sysconfig/mymodules.modules and following a
    # combination of
    # https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/sec-Persistent_Module_Loading.html
    # and http://www.ndchost.com/wiki/load-modules-on-boot-centos6
    #
    # Also there is something weird in the beep settings so you need to do
    # sudo chmod 4755 /usr/bin/beep (see
    # https://bbs.archlinux.org/viewtopic.php?id=117309 and
    # http://linux.die.net/man/1/beep)
    beep -f 1000 -r 2 -n -r 5 -l 10 --new
fi

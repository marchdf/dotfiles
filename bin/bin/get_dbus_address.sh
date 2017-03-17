#!/bin/sh
#
# This is required by prompt_upgrades to run a notify-send in the
# crontab. It basically just creates a file containing the required
# Dbus environment variable and the ability to export it. The
# notify-send function sources the script created by this function.
#
# Should be run once on user log in. Add it to 
#
#
mkdir -p $HOME/.dbus
touch $HOME/.dbus/Xdbus
chmod 600 $HOME/.dbus/Xdbus
env | grep DBUS_SESSION_BUS_ADDRESS > $HOME/.dbus/Xdbus
echo 'export DBUS_SESSION_BUS_ADDRESS' >> $HOME/.dbus/Xdbus

exit 0

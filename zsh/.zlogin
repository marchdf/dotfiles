#================================================================================
#
# Run these functions on login
#
#================================================================================

#================================================================================
#
# Python virtual environment
#
#================================================================================
export WORKON_HOME=${HOME}/.virtualenvs

#================================================================================
#
# These are my custom login stuff for my laptop
#
#================================================================================
if [[ ${(%):-%M} = *laptop* ]]; then

   $HOME/bin/get_dbus_address.sh
   
   # Autostart X at login. Taken from the Arch wiki
   # the -z $DISPLAY returns true if $DISPLAY has zero length
   # $XDG_VTNR returns the tty number (so this will only work on tty1)
   [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

fi

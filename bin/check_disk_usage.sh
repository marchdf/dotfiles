#!/bin/bash
# Inspired from http://www.linuxjournal.com/content/tech-tip-send-email-alert-when-your-disk-space-gets-low
# added to /etc/crontab file: @daily ~/check_disk_usage.sh
# not applicable if using something other than postfix to send mail: see /etc/postfix/main.cf and /etc/postfix/sasl_passwd

# Get current percent usage
HOSTNAME=$(hostname)
CURRENT=$(df /home | tail -1 | awk '{ print $5}' | sed 's/%//g')
THRESHOLD=95
if [ "$CURRENT" -gt "$THRESHOLD" ] ; then
    mail -s 'Disk Space Alert' marchdf@umich.edu <<EOF
Your home partition on $HOSTNAME remaining free space is critically low. Used: $CURRENT%
EOF
fi

#!/bin/bash
confdir=/etc/nginx
currentfiledate="$(date -r $confdir/tb-lbs.conf "+%m%d%Y%H%M%S")"
(cd $confdir ; wget -N https://tanglebay.com/assets/tb-lbs.conf)
newfiledate="$(date -r $confdir/tb-lbs.conf "+%m%d%Y%H%M%S")"
if [ "$currentfiledate" != "$newfiledate" ]; then
    echo "New Config found"
    chmod 644 $confdir/tb-lbs.conf
    sudo systemctl reload nginx
fi
exit 0
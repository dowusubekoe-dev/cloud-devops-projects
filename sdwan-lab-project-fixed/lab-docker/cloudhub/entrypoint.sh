#!/bin/bash
while read line; do
    ip route add $line
done < /root/cloudhub.routes
tail -f /dev/null

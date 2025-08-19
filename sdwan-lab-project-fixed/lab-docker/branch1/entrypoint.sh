#!/bin/bash
while read line; do
    ip route add $line
done < /root/branch1.routes
tail -f /dev/null

#!/bin/bash
while read line; do
    ip route add $line
done < /root/branch2.routes
tail -f /dev/null

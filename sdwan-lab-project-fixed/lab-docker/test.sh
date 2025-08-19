#!/bin/bash
set -e

echo "== Branch1 -> Branch2 ping =="
docker exec branch1 ping -c 3 10.10.0.6

echo "== Branch2 -> Branch1 ping =="
docker exec branch2 ping -c 3 10.10.0.5

echo "== Branch1 -> CloudHub ping =="
docker exec branch1 ping -c 3 10.10.0.4

echo "== Branch2 -> CloudHub ping =="
docker exec branch2 ping -c 3 10.10.0.4


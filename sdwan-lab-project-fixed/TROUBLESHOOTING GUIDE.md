# Troubleshooting Guide

## 1. Container Won’t Start

**Error:** failed to set up container networking: Address already in use

**Solution:**

```bash
docker rm -f branch1 branch2 cloudhub
docker network rm lab-docker_branch_net
docker system prune -f
docker network prune -f
```

## 2. Ping Fails Between Branches

**Cause:** Routes may be misconfigured, or IPs don’t match Docker network.

**Solution:**

```bash
docker exec branch1 ip route
docker exec branch1 ping 10.10.0.6
```
Verify docker-compose.yml IPs and *.routes files match.


## 3. WireGuard Not Running

**Cause:** Missing kernel modules or wrong Dockerfile installation.

**Solution:**

Ensure Dockerfile installs wireguard package and dependencies (iproute2, iputils-ping, net-tools).

Verify inside container:

`docker exec -it branch1 wg`

## 4. Lab Works Intermittently

**Cause:** Docker daemon may have leftover networks or IP conflicts.

**Solution:**

```bash
docker compose down
docker network prune -f
docker system prune -f
./setup.sh
```

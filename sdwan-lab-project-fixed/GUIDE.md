# SD-WAN Multi-Branch Lab - Step-by-Step Guide

## Prerequisites
- Docker 20+ installed
- Docker Compose installed
- Linux, macOS, or Windows with WSL2

## Setup Project
1. Clone or unzip the project
```bash
unzip sdwan-lab-project.zip
cd sdwan-lab-project/lab-docker
```
2. Make scripts executable
```bash
chmod +x setup.sh test.sh branch1/entrypoint.sh branch2/entrypoint.sh cloudhub/entrypoint.sh
```

## Build and Start Containers
```bash
./setup.sh
```

## Verify Containers
```bash
docker ps
```

## Test Connectivity
```bash
./test.sh
```

## Simulate Failover
Stop a container:
```bash
docker stop cloudhub
```
Restore:
```bash
docker start cloudhub
```

## Cleanup
```bash
docker compose down
```

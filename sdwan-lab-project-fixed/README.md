# SD-WAN Multi-Branch Lab (Docker Simulation)

**Secure Multi-Branch Connectivity Simulation Using Docker and WireGuard**

This project simulates a multi-branch network environment with SD-WAN-like overlay connectivity using Docker containers and WireGuard for secure traffic.

---

## Architecture Diagram

    +-----------------+
    |    CloudHub     |
    |    10.10.0.4    |
    +--------+--------+
             |
      +--------------+
      |              |
      |              |
+-----------+ +-----------+
| Branch1 | | |  Branch2  |
| 10.10.0.5 | | 10.10.0.6 |
+-----------+ +-----------+


- **CloudHub** acts as the central hub.
- **Branch1** and **Branch2** connect via CloudHub.
- WireGuard provides encrypted tunnels between nodes.

---

## Why?

This lab demonstrates **how SD-WAN technologies can optimize multi-branch connectivity** while maintaining secure and efficient communication. It is ideal for learning enterprise network engineering, overlay network design, and containerized network simulations.

---

## Deployment Instructions

### Prerequisites

- Docker & Docker Compose installed
- Linux host recommended
- Basic knowledge of networking (IP, routing)

### Steps

1. Clone the repository:

```bash
git clone <your-repo-url>
cd sdwan-lab-project
```

2. Build and start the lab:

```bash
./setup.sh
```

3. Test connectivity:

```bash
./test.sh
```

*You should see successful ping results between branch1, branch2, and cloudhub.*

### Folder Structure



sdwan-lab-project/
+- branch1/
¦  +- Dockerfile
+- branch2/
¦  +- Dockerfile
+- cloudhub/
¦  +- Dockerfile
+- configs/
¦  +- branch1.routes
¦  +- branch2.routes
¦  +- cloudhub.routes
+- docker-compose.yml
+- setup.sh
+- test.sh
+- README.md
+- SCENARIOS.md


### Notes

- IP addresses and routes are configurable in docker-compose.yml and configs/*.routes.

- WireGuard is used inside each container to simulate secure SD-WAN tunnels.

- This lab is fully self-contained in Docker, so it does not require real physical hardware.

---

## Basic Scenarios

For full scenarios and troubleshooting steps, see [SCENARIOS.md](.



# SD-WAN Lab Project – Scenarios & Troubleshooting

## Basic Scenarios

### 1. Test Branch-to-Branch Connectivity

**Goal:** Verify that Branch1 and Branch2 can communicate through CloudHub.

**Steps:**

1. Start the lab:

```bash
./setup.sh
```

2. Run the test script:

```bash
./test.sh
```

3. Expected Result:

Branch1 -> Branch2 ping: 3 packets transmitted, 3 received
Branch2 -> Branch1 ping: 3 packets transmitted, 3 received

4. Modify `branch1.routes` or `branch2.routes` to simulate route changes and test connectivity again.

---

### 2. Simulate Hub Failure

**Goal:** Check the effect of CloudHub failure on branch communication.

**Steps:**

1. Stop the hub container:

```bash
docker stop cloudhub
```

2. Try pinging between branches:

```bash
docker exec branch1 ping -c 3 10.10.0.6
```

3. Expected Result: Pings fail because the hub is the central route for all traffic.

4. Restart hub

```bash
docker start cloudhub
./test.sh
```
5. Verify connectivity is restored.

---

### 3. Change Branch IPs

**Goal:** Verify that static IP changes propagate correctly.

**Steps:**

1. Update docker-compose.yml with new branch IPs (still inside 10.10.0.0/24).

2. Update corresponding *.routes files.

3. Rebuild and restart containers:

```bash
docker compose down
docker compose build --no-cache
./setup.sh
```

4. Test connectivity with `./test.sh`.
---

### 4. Test Routing Changes

**Goal:** Simulate a network change or failover scenario.

**Steps:**

1. Modify a branch’s route file to route traffic via a different IP.

2. Restart the branch container or reload WireGuard inside the container.

3. Test connectivity and observe changes in packet delivery.


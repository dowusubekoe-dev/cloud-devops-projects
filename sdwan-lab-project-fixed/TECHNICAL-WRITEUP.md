# **2?? Technical Writeup / Blog Post**

**Title:** Simulating Enterprise SD-WAN Connectivity with Docker  

---

### **Situation**

Enterprise networks often span multiple branches, each needing secure, reliable connectivity to cloud regions and other branches. Traditional WANs can be expensive and rigid, so SD-WAN solutions like VeloCloud or Cisco SD-WAN are increasingly used.  

Goal: Build a **hands-on lab** to simulate multi-branch SD-WAN connectivity without expensive hardware.

---

### **Task**

- Create multiple “branch” nodes and a central “cloud hub” in a lab environment.  
- Ensure each branch can communicate securely with the hub and other branches.  
- Use **Docker containers** for portability and reproducibility.  
- Implement routing overlays to simulate SD-WAN behavior.  
- Provide a test script to verify connectivity.

---

### **Action**

1. **Environment Setup**  
   - Created Dockerfiles for each branch and cloud hub container.
   - Installed **WireGuard** in each container for encrypted tunnels.
   - Configured routing files (`*.routes`) to simulate SD-WAN overlay connections.

2. **Network Design**  
   - Assigned static IPs within a dedicated Docker subnet (`10.10.0.0/24`).  
   - CloudHub acts as the central hub for all branches.  
   - Each branch uses routes via CloudHub to reach other branches.

3. **Automation**  
   - Wrote `setup.sh` to build images, start containers, and configure networking.  
   - Created `test.sh` to validate ping connectivity between branches and hub.

4. **Troubleshooting & Solutions**  
   - **Issue:** Containers failed with “Address already in use”.  
     **Solution:** Removed stale containers and networks, verified IPs were inside subnet.  
   - **Issue:** Ping test failed after updating IPs.  
     **Solution:** Updated test script and route files to match new IPs.  
   - **Issue:** WireGuard installation failed in container.  
     **Solution:** Updated Dockerfiles to install dependencies and kernel modules correctly.

---

### **Result**

- Successfully launched a **self-contained SD-WAN lab** using Docker.  
- Branch1 ? CloudHub ? Branch2 connectivity verified via ping tests.  
- Routing and overlay simulation allows testing of SD-WAN scenarios without real hardware.  
- Provides a reusable lab for teaching, testing, or portfolio demonstration.

---

### **Key Learnings**

- Docker networks can simulate complex topologies effectively.  
- Static IPs in Docker must match subnet configurations.  
- WireGuard tunnels can emulate secure SD-WAN overlays in a lab environment.  
- Automation scripts (setup & test) reduce manual steps and improve reproducibility.

---
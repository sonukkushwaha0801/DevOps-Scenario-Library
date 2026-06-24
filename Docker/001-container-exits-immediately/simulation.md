# DOCKER-001 Lab Simulation — Container Exits Immediately

This lab simulates a real Docker incident where a container starts and exits immediately after launch.

You will learn:

* How to reproduce the issue
* How to investigate manually
* How to investigate using scripts
* How to identify root cause
* How to recover service
* How to verify incident resolution

---

# Lab Files

Scenario Path:

```bash
docker/001-container-exits-immediately/
```

Lab Path:

```bash
docker/001-container-exits-immediately/lab/
```

Scripts Path:

```bash
docker/001-container-exits-immediately/scripts/
```

---

# Step 1 — Move to Lab Directory

```bash
cd docker/001-container-exits-immediately/lab
```

Verify files:

```bash
ls -l
```

Expected files:

```bash
Dockerfile
broken-start.sh
fixed-start.sh
README.md
simulation.md
```

---

# Step 2 — Review Dockerfile

```bash
cat Dockerfile
```

---

# Step 3 — Review Broken Startup Script

```bash
cat broken-start.sh
```

Expected:

```bash
#!/bin/bash

echo "Starting application..."
nonexistent-command
```

Problem:

`nonexistent-command` does not exist.

---

# Step 4 — Build Broken Image

```bash
docker build -t broken-image .
```

Expected:

```bash
Successfully tagged broken-image:latest
```

---

# Step 5 — Run Broken Container

```bash
docker run --name broken-container broken-image
```

Expected:

```bash
Starting application...
/app/start.sh: line 4: nonexistent-command: command not found
```

Incident successfully simulated.

---

# Step 6 — Confirm Failure

Check running containers:

```bash
docker ps
```

Expected:

No running container.

Check all containers:

```bash
docker ps -a
```

Expected:

```bash
CONTAINER ID   IMAGE          STATUS
abc123         broken-image   Exited (127)
```

---

# Step 7 — Manual Investigation

Check logs:

```bash
docker logs broken-container
```

Expected:

```bash
Starting application...
/app/start.sh: line 4: nonexistent-command: command not found
```

Observation:

* Container exited immediately
* Exit code = 127
* Logs indicate startup failure

---

# Step 8 — Script-Based Diagnostics

Move to scripts directory:

```bash
cd ../scripts
```

Make scripts executable:

```bash
chmod +x *.sh
```

---

# Step 9 — Run Diagnostics Collector

```bash
./collect-container-diagnostics.sh
```

Input:

```bash
broken-container
```

Expected:

```bash
[SUCCESS] Diagnostics collected successfully.
```

This collects:

* Container status
* Logs
* Inspect output
* Exit code
* Resource stats
* Host health

---

# Step 10 — Analyze Exit Code

```bash
./analyze-exit-code.sh
```

Input:

```bash
broken-container
```

Expected:

```bash
Exit Code: 127
```

Analysis:

```bash
Command Not Found
```

---

# Step 11 — Run Root Cause Hint Engine

```bash
./auto-root-cause-hint.sh
```

Input:

```bash
broken-container
```

Expected:

```bash
LIKELY ROOT CAUSE:
Missing Command / Dependency
```

Recommended next action:

```bash
Validate binary paths and dependencies
```

---

# Step 12 — Root Cause Analysis

Root Cause:

* Invalid startup command
* Missing binary

Scenario matched:

```bash
DOCKER-001
```

---

# Step 13 — Fix the Issue

Move back to lab:

```bash
cd ../lab
```

Check fixed script:

```bash
cat fixed-start.sh
```

Replace broken script:

```bash
cp fixed-start.sh broken-start.sh
```

---

# Step 14 — Rebuild Fixed Image

```bash
docker build -t fixed-image .
```

Expected:

Build successful.

---

# Step 15 — Run Fixed Container

```bash
docker run --name fixed-container fixed-image
```

Expected:

```bash
Application started successfully
```

Container should remain running.

---

# Step 16 — Verify Recovery

Check container status:

```bash
docker ps
```

Expected:

```bash
CONTAINER ID   IMAGE        STATUS
xyz456         fixed-image  Up 2 minutes
```

Success indicators:

* Container running
* No restart loop
* Service stable

---

# Final Incident Summary

Issue:

Container exited immediately after startup.

Root Cause:

Invalid command inside startup script.

Error:

```bash
command not found
```

Exit Code:

```bash
127
```

Recovery:

* Fixed startup script
* Rebuilt image
* Redeployed container

Verification:

✅ Container running

✅ No startup failure

✅ Incident resolved

# Lab — DOCKER-001

## Objective

Reproduce a container that exits immediately after startup.

Learn how to:

* Diagnose startup failure
* Identify root cause
* Recover container
* Verify fix

---

# Step 1 — Build Broken Image

```bash id="s2m7v9"
docker build -t docker-lab-broken .
```

---

# Step 2 — Run Container

```bash id="n4x8p1"
docker run --name broken-container docker-lab-broken
```

Expected result:

* Container starts
* Container exits immediately

---

# Step 3 — Diagnose

Check status:

```bash id="p9k3r6"
docker ps -a
```

Check logs:

```bash id="w6m1q7"
docker logs broken-container
```

Expected failure:

```bash id="x2v5n8"
command not found
```

Exit code:

```bash id="z7p4m2"
127
```

---

# Step 4 — Recovery

Replace broken script:

```bash id="r3n8k5"
cp fixed-start.sh broken-start.sh
```

Rebuild:

```bash id="v1q6m9"
docker build -t docker-lab-fixed .
```

Run:

```bash id="m8p2x4"
docker run --name fixed-container docker-lab-fixed
```

---

# Step 5 — Verification

Verify container remains running.

```bash id="q5m9r1"
docker ps
```

Expected:

Container status = Up

# Verification Procedure — DOCKER-001

Incident is resolved only after all verification checks pass.

Recovery without verification is incomplete.

---

# Verification Objective

Confirm:

* Container is running
* Application is healthy
* Service is accessible
* No restart loops exist
* System is stable

---

# Verification Step 1 — Confirm Container Status

## Category

SAFE

## Purpose

Validate container is running.

## Command

```bash id="m7v2p8"
docker ps -a
```

## Success Criteria

Container status should show:

```bash id="t9q3k1"
Up
```

## Failure Indicators

* Exited
* Restarting
* Missing container

---

# Verification Step 2 — Validate Container Stability

## Category

SAFE

## Purpose

Ensure container remains stable over time.

## Command

```bash id="r2k6w5"
watch docker ps -a
```

## Success Criteria

* Container remains running
* No restart loop

## Failure Indicators

* Frequent restarts
* Unexpected exit

---

# Verification Step 3 — Inspect Logs

## Category

SAFE

## Purpose

Ensure application startup completed successfully.

## Command

```bash id="f8m1x3"
docker logs <container_id>
```

## Success Criteria

Logs indicate:

* Successful startup
* No active errors
* No crash traces

## Failure Indicators

* Exceptions
* Fatal errors
* Stack traces

---

# Verification Step 4 — Validate Application Response

## Category

SAFE

## Purpose

Confirm service is reachable.

## Example Commands

HTTP-based service:

```bash id="k3p9v7"
curl localhost:<port>
```

Container shell validation:

```bash id="w1n4r6"
docker exec -it <container_id> /bin/sh
```

## Success Criteria

* Application responds successfully
* Service accessible

## Failure Indicators

* Timeout
* Connection refused
* Service unavailable

---

# Verification Step 5 — Validate Resource Health

## Category

SAFE

## Purpose

Check CPU and memory usage.

## Command

```bash id="p6x2m9"
docker stats
```

## Success Criteria

* Stable CPU usage
* Stable memory usage
* No resource spikes

## Failure Indicators

* High CPU
* Memory exhaustion
* Resource instability

---

# Verification Step 6 — Validate Dependency Connectivity

## Category

SAFE

## Purpose

Ensure external dependencies are reachable.

Examples:

* Database
* Cache
* APIs
* Message broker

## Success Criteria

Dependencies reachable.

## Failure Indicators

* Connection refused
* DNS failure
* Authentication failure

---

# Incident Exit Criteria

Incident is resolved only when all conditions are true:

* Container is running
* No restart loops
* Logs are clean
* Service is reachable
* Dependencies reachable
* Resource usage stable
* No active alerts

---

# Final Incident Status

## RESOLVED

Mark incident resolved only if all verification checks pass.

Otherwise:

## ACTIVE

Continue investigation or rollback.

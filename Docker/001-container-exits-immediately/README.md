# DOCKER-001 — Container Exits Immediately

## Scenario Overview

This scenario covers incidents where a container starts successfully but exits immediately after launch.

This commonly indicates startup failure inside the container due to:

* Application errors
* Invalid startup commands
* Missing dependencies
* Missing environment variables
* Permission issues
* Runtime failures

This scenario applies to:

* Docker Engine
* Docker Compose
* CI/CD container workloads
* Local development environments
* Production container runtimes

---

# Scenario Structure

```bash id="b8q2n5"
docker/
└── 001-container-exits-immediately/
    ├── README.md
    ├── metadata.yml
    ├── references.md
    ├── rollback.md
    ├── verification.md
    │
    ├── commands/
    │   ├── diagnose.md
    │   └── recover.md
    │
    ├── scripts/
    │   ├── collect-container-diagnostics.sh
    │   ├── analyze-exit-code.sh
    │   └── auto-root-cause-hint.sh
    │
    └── lab/
        ├── Dockerfile
        ├── broken-start.sh
        ├── fixed-start.sh
        ├── README.md
        └── simulation.md
```

---

# Severity

Default Severity: Medium
Priority: P2

Escalate to P1 if:

* Production service unavailable
* Critical workloads affected
* Multiple containers failing

---

# Problem Statement

Container lifecycle:

```bash id="r4m7p1"
Container Created
→ Container Started
→ Process Fails
→ Container Exits
```

The Docker runtime is functioning.

Failure occurs inside container process.

---

# Common Symptoms

* Container starts and exits immediately
* Service unavailable
* Container status shows Exited
* Application never reaches healthy state
* Frequent restart attempts

---

# Common Error Messages

```bash id="w2n8k5"
Exited (1)
Exited (127)
Exited (137)
exec format error
permission denied
command not found
no such file or directory
OCI runtime create failed
```

---

# Scenario Match Criteria

## Exact Match (95–100%)

Use directly if:

* Container exits immediately after startup
* Status shows Exited
* Logs indicate startup failure

---

## Similar Match (70–95%)

Use as investigation guide if:

* Container runs briefly before exiting
* Restart loops occur
* Failure intermittent

---

## Related Match (40–70%)

Use for investigation hints if:

* Container remains running but unhealthy
* Service inaccessible despite running container

Related scenarios:

* DOCKER-002 Container Unhealthy
* DOCKER-005 Container Restart Loop
* DOCKER-011 Permission Denied
* DOCKER-012 Build Failure

---

# Investigation Workflow

Investigation should follow two phases.

---

## Phase 1 — Manual Investigation

Use core Docker commands.

Check:

* Container status
* Logs
* Configuration
* Exit code
* Resource usage

Reference:

```bash id="c5m1r9"
commands/diagnose.md
```

---

## Phase 2 — Script-Assisted Investigation

Use automation for faster triage.

Available scripts:

### Diagnostics Collector

```bash id="m8n3p4"
scripts/collect-container-diagnostics.sh
```

Collects:

* Logs
* Inspect output
* Exit code
* Resource stats
* Host health

---

### Exit Code Analyzer

```bash id="k2r7m5"
scripts/analyze-exit-code.sh
```

Maps exit code to likely failure pattern.

Examples:

* 127 → Command not found
* 137 → OOM kill

---

### Root Cause Hint Engine

```bash id="p7v2n8"
scripts/auto-root-cause-hint.sh
```

Provides likely root cause and next actions.

---

# Common Root Causes

## Invalid CMD or ENTRYPOINT

* Wrong executable
* Wrong path
* Typo in startup command

---

## Application Crash During Startup

* Python exception
* Java crash
* Node.js startup failure

---

## Missing Environment Variables

* Database credentials missing
* Secret missing
* API key missing

---

## Permission Issues

* Script not executable
* Binary permission denied

---

## Missing Dependency

* Binary missing
* Runtime missing

---

## Architecture Mismatch

* ARM image on x86 host

---

## Volume Mount Issues

* Required files missing
* Wrong mount path

---

# Recovery Strategy

Recovery depends on root cause.

Typical recovery:

* Fix startup command
* Fix environment variables
* Fix permissions
* Install missing dependencies
* Rebuild image
* Redeploy container

Reference:

```bash id="q3m9r1"
commands/recover.md
```

---

# Rollback Strategy

If recovery fails:

* Revert image version
* Restore previous configuration
* Redeploy stable release

Reference:

```bash id="n6p2k4"
rollback.md
```

---

# Verification Procedure

Incident is resolved only after successful verification.

Validate:

* Container remains running
* Application responds correctly
* No restart loops
* Health checks pass
* Logs clean

Reference:

```bash id="r8m5q2"
verification.md
```

---

# Lab Simulation

A full reproducible lab exists for this scenario.

Path:

```bash id="x1n7p6"
lab/
```

Simulation guide:

```bash id="j4m8r3"
lab/simulation.md
```

This includes:

* Failure simulation
* Manual investigation
* Script-assisted diagnosis
* Root cause identification
* Recovery
* Verification

---

# Exit Criteria

Incident resolved only when:

* Container running
* Service restored
* No active startup failures
* Validation checks successful
* Production stable

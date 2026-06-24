# Diagnose Commands — DOCKER-001

This document contains commands used to diagnose containers that exit immediately after startup.

---

# Command 1 — List Container Status

## Category

SAFE

## Purpose

Identify container state.

## Risk Level

None

## Command

```bash id="smib3x"
docker ps -a
```

## Expected Output

Container status should show one of:

* Up
* Exited
* Restarting

Example:

```bash id="jlwm8m"
CONTAINER ID   IMAGE      STATUS
abc123         nginx      Exited (1) 2 minutes ago
```

## Failure Indicators

* Container status = Exited
* Exit code present
* Frequent restarts

## Verification

Confirm affected container name or container ID.

---

# Command 2 — Check Container Logs

## Category

INVESTIGATIVE

## Purpose

Find startup failure reason.

## Risk Level

None

## Command

```bash id="x1g0jw"
docker logs <container_id>
```

## Expected Output

Application startup logs.

Examples:

* Service started successfully
* Application initialization logs

## Failure Indicators

Look for:

* Stack traces
* Exceptions
* Missing file errors
* Permission errors
* Dependency failures

Examples:

```bash id="xt5w8f"
permission denied
command not found
no such file or directory
```

## Verification

Root cause should become visible in logs.

---

# Command 3 — Inspect Container Details

## Category

SAFE

## Purpose

Inspect container configuration.

## Risk Level

None

## Command

```bash id="wgmyl6"
docker inspect <container_id>
```

## Expected Output

JSON output containing:

* Environment variables
* CMD
* ENTRYPOINT
* Volumes
* Network config

## Failure Indicators

Look for:

* Missing env vars
* Invalid command
* Incorrect volume mounts

## Verification

Configuration should match deployment expectations.

---

# Command 4 — Check Exit Code

## Category

INVESTIGATIVE

## Purpose

Understand why process exited.

## Risk Level

None

## Command

```bash id="f4m2ls"
docker inspect <container_id> --format='{{.State.ExitCode}}'
```

## Expected Output

Numeric exit code.

Common meanings:

* 0 → Clean exit
* 1 → General error
* 126 → Permission denied
* 127 → Command not found
* 137 → Killed (OOM/SIGKILL)

## Failure Indicators

Non-zero exit code.

## Verification

Exit code aligns with failure pattern.

---

# Command 5 — Run Container Interactively

## Category

INVESTIGATIVE

## Purpose

Debug container manually.

## Risk Level

Low

## Command

```bash id="pkl0oq"
docker run -it --entrypoint /bin/sh <image_name>
```

## Expected Output

Interactive shell inside container.

## Failure Indicators

* Shell unavailable
* Startup files missing
* Runtime binaries missing

## Verification

Validate file system and startup scripts.

---

# Command 6 — Validate Image Architecture

## Category

SAFE

## Purpose

Check architecture compatibility.

## Risk Level

None

## Command

```bash id="68yigv"
docker image inspect <image_name>
```

## Expected Output

Image metadata.

## Failure Indicators

* ARM image on x86 host
* Unsupported architecture

## Verification

Image architecture matches host architecture.

---

# Command 7 — Check Host Resource Usage

## Category

INVESTIGATIVE

## Purpose

Detect resource exhaustion.

## Risk Level

None

## Command

```bash id="u2j5rm"
docker stats
```

## Expected Output

Container CPU and memory usage.

## Failure Indicators

* Memory exhaustion
* High CPU
* OOM condition

## Verification

No abnormal resource consumption.

---

# Diagnosis Decision Tree

### Logs show application error

→ Investigate application startup issue

### Logs show permission denied

→ Investigate permissions

### Exit code = 127

→ Investigate CMD/ENTRYPOINT

### Exit code = 137

→ Investigate memory exhaustion

### Logs empty

→ Investigate image and runtime config

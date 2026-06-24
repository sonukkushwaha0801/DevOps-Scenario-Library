# Recovery Commands — DOCKER-001

This document contains recovery actions for containers that exit immediately after startup.

Execute recovery only after root cause is identified.

---

# Recovery Path 1 — Fix Invalid CMD or ENTRYPOINT

## Category

RECOVERY

## Purpose

Correct invalid startup command.

## Risk Level

Medium

---

## Example Issue

* Wrong binary path
* Typo in startup command
* Invalid ENTRYPOINT

Example:

```bash id="1a7pqo"
CMD ["python", "main.py"]
```

But `main.py` does not exist.

---

## Recovery Action

Update Dockerfile or deployment configuration.

Example:

```dockerfile
CMD ["python", "app.py"]
```

Rebuild image:

```bash id="4h6mvo"
docker build -t app:fixed .
```

Run container:

```bash id="xqfuhz"
docker run app:fixed
```

## Verification

* Container starts successfully
* No immediate exit

---

# Recovery Path 2 — Fix Missing Environment Variables

## Category

RECOVERY

## Purpose

Provide required configuration.

## Risk Level

Low

---

## Example Issue

Required environment variables missing.

Examples:

* DB_HOST
* API_KEY
* SECRET_KEY

---

## Recovery Action

Run container with required variables:

```bash id="6v7e1t"
docker run -e DB_HOST=db.example.com app:latest
```

Or use env file:

```bash id="y3r7kd"
docker run --env-file .env app:latest
```

## Verification

Application initializes successfully.

---

# Recovery Path 3 — Fix Permission Issues

## Category

RECOVERY

## Purpose

Resolve permission failures.

## Risk Level

Medium

---

## Example Issue

```bash id="tt44dr"
permission denied
```

---

## Recovery Action

Fix file permissions:

```bash id="mgo5k4"
chmod +x start.sh
```

Update Dockerfile:

```dockerfile
RUN chmod +x /app/start.sh
```

Rebuild image:

```bash id="0h9qj3"
docker build -t app:fixed .
```

## Verification

Startup script executes successfully.

---

# Recovery Path 4 — Fix Missing Dependencies

## Category

RECOVERY

## Purpose

Install missing packages or binaries.

## Risk Level

Medium

---

## Example Issue

```bash id="97lw6f"
command not found
```

---

## Recovery Action

Install required dependency.

Example:

```dockerfile
RUN apt-get update && apt-get install -y curl
```

Rebuild image:

```bash id="3l8mny"
docker build -t app:fixed .
```

## Verification

Missing dependency error resolved.

---

# Recovery Path 5 — Fix Architecture Mismatch

## Category

RECOVERY

## Purpose

Build image for correct architecture.

## Risk Level

High

---

## Example Issue

```bash id="kvot9r"
exec format error
```

---

## Recovery Action

Build correct architecture image.

Example:

```bash id="33ly7y"
docker buildx build --platform linux/amd64 -t app:fixed .
```

## Verification

Container starts on target host.

---

# Recovery Path 6 — Fix Resource Exhaustion

## Category

RECOVERY

## Purpose

Resolve OOM or CPU exhaustion.

## Risk Level

High

---

## Example Issue

Exit code:

```bash id="49it0e"
137
```

---

## Recovery Action

Increase memory limits or optimize application.

Example:

```bash id="pjlwm1"
docker run --memory=2g app:latest
```

## Verification

Container remains stable under load.

---

# Recovery Path 7 — Fix Volume Mount Issues

## Category

RECOVERY

## Purpose

Correct volume configuration.

## Risk Level

Medium

---

## Example Issue

Required files unavailable inside container.

---

## Recovery Action

Validate mount path.

Example:

```bash id="b15sc1"
docker run -v /host/config:/app/config app:latest
```

Verify mounted files.

## Verification

Application reads required files successfully.

---

# Recovery Decision Tree

### Invalid command

→ Fix CMD / ENTRYPOINT

### Missing config

→ Fix environment variables

### Permission denied

→ Fix permissions

### Command not found

→ Fix dependencies

### Exec format error

→ Fix architecture

### Exit code 137

→ Fix memory limits

### Missing files

→ Fix volume mounts

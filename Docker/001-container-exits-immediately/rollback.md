# Rollback Procedure — DOCKER-001

Rollback is required if recovery actions fail or introduce additional instability.

Goal:
Restore service using previously known stable configuration.

---

# Rollback Triggers

Initiate rollback if:

* Recovery attempt fails
* Container still exits immediately
* New deployment worsens system state
* Production instability increases

---

# Rollback Strategy 1 — Revert to Previous Image

## Risk Level

Low

Use previously stable image version.

Example:

```bash id="t2y6m8"
docker run app:v1.0.3
```

Verification:

* Container starts successfully
* Service restored

---

# Rollback Strategy 2 — Restore Previous Environment Configuration

## Risk Level

Low

Restore previous environment variables or configuration files.

Examples:

* .env
* config.yaml
* secret values

Verification:

* Application initializes successfully

---

# Rollback Strategy 3 — Restore Previous Volume Mount Configuration

## Risk Level

Medium

Restore known stable mount paths.

Example:

```bash id="m7p1c4"
-v /old-config:/app/config
```

Verification:

* Required files accessible inside container

---

# Rollback Strategy 4 — Redeploy Last Stable Release

## Risk Level

Medium

Rollback entire deployment to last known stable version.

Examples:

* Previous image tag
* Previous release artifact
* Previous compose configuration

Verification:

* Service fully restored

---

# Rollback Exit Criteria

Rollback is successful when:

* Stable container restored
* No immediate container exits
* Service availability restored
* No active production incident

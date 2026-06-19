# references.md

# TF-003 — References

---

# Purpose

This document contains official documentation, state architecture concepts, corruption causes, recovery strategies, and best practices related to Terraform state corruption.

Use this for:

* deeper technical understanding
* root cause analysis
* recovery planning
* prevention improvements

This file is not part of active incident execution.

---

# 1. Terraform State Fundamentals

Terraform state stores the mapping between:

* Terraform configuration
* Managed resources
* Real infrastructure

Terraform uses state to determine:

* what exists
* what changed
* what actions are required

Critical rule:

Without healthy state, Terraform cannot safely manage infrastructure.

---

# 2. Terraform State Components

Terraform state typically contains:

* resource mappings
* metadata
* dependency graph
* provider information
* state lineage
* serial version

Example high-level structure:

```json
{
  "version": 4,
  "terraform_version": "x.x.x",
  "serial": 1,
  "lineage": "xxxx",
  "resources": []
}
```

Important components:

* version
* serial
* lineage
* resources

Corruption in any critical section can break Terraform operations.

---

# 3. Common Corruption Causes

Most state corruption originates from:

* interrupted state writes
* backend storage corruption
* manual state file edits
* partial state migration
* failed recovery attempts
* backend synchronization failures

Common examples:

* broken JSON
* invalid metadata
* missing resources
* version mismatch

---

# 4. Common Corruption Symptoms

Typical indicators:

* terraform state commands fail
* terraform plan behaves unpredictably
* state file unreadable
* resources missing from state
* unexpected resource recreation

Common error examples:

* Failed to load state
* Unsupported state format
* JSON parse error
* Invalid state file

---

# 5. Recovery Strategies

There are three recovery strategies.

---

## Strategy 1 — Restore Backup

Preferred recovery path.

Use when:

* healthy backup exists

Flow:

```text
Restore backup
→ Validate state
→ Validate plan
```

Best option.
Lowest risk.

---

## Strategy 2 — Repair State

Use when:

* backup unavailable
* corruption limited

Flow:

```text
Repair state
→ Validate structure
→ Validate mappings
```

Higher risk.

---

## Strategy 3 — Rebuild State

Use when:

* backup unavailable
* repair failed
* state unusable

Flow:

```text
Rebuild state
→ Import resources
→ Validate everything
```

Highest complexity.

---

# 6. Recovery Priority Order

Always follow this order:

```text
Restore Backup
→ Repair State
→ Rebuild State
```

Never start with rebuild unless necessary.

---

# 7. State Validation Commands

Useful commands:

Check state:

```bash
terraform state list
```

Inspect state:

```bash
terraform show
```

Validate plan:

```bash
terraform plan
```

Import resources:

```bash
terraform import <resource> <id>
```

Remove bad mapping:

```bash
terraform state rm <resource>
```

---

# 8. Prevention Best Practices

---

## Use Remote Backends

Avoid local state in production.

Recommended:

* versioned storage
* durable backend
* backup-enabled backend

---

## Enable State Versioning

Critical for fast recovery.

Benefits:

* backup recovery
* point-in-time restore
* incident rollback

---

## Avoid Manual State Edits

Never edit state manually unless absolutely necessary.

Manual edits are high-risk.

---

## Automate State Backups

Recommended:

* scheduled backups
* backend snapshots
* version retention

---

## Restrict State Access

Use:

* RBAC
* access controls
* audit logs

Limit direct state modifications.

---

# Key Lessons

Terraform state is the source of infrastructure truth.

If state is corrupted:
Terraform loses infrastructure awareness.

Critical recovery priority:

Restore trust in state before resuming infrastructure changes.

# TF-004 — References

---

# Purpose

This document contains official documentation, state management concepts, missing state causes, recovery strategies, and best practices related to Terraform missing state incidents.

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

Without state, Terraform cannot safely manage infrastructure.

---

# 2. Why Missing State Is Dangerous

Missing state does NOT mean infrastructure is gone.

Important distinction:

```text id="tf004-ref2"
Missing state ≠ Missing infrastructure
```

Example:

* EC2 instance exists
* database exists
* network exists

But Terraform state is missing.

Terraform assumes nothing exists.

Result:
Terraform may attempt to create everything again.

This creates serious risk.

---

# 3. Common Causes of Missing State

Most missing state incidents originate from:

* accidental deletion
* backend object deletion
* failed backend migration
* storage cleanup
* wrong backend configuration
* human error

Common examples:

* deleted terraform.tfstate
* deleted backend object
* wrong backend key
* bucket/container cleanup

---

# 4. Common Symptoms

Typical indicators:

* state file missing
* backend object missing
* terraform state commands fail
* terraform plan wants to recreate infrastructure

Common error examples:

* No state file found
* Failed to load state
* State snapshot not found
* Backend object missing

---

# 5. Recovery Strategies

There are two recovery strategies.

---

## Strategy 1 — Restore Backup

Preferred recovery path.

Use when:

* healthy backup exists

Flow:

```text id="tf004-ref3"
Restore backup
→ Validate state
→ Validate plan
```

Best option.
Lowest risk.

---

## Strategy 2 — Rebuild State

Use when:

* no backup exists
* restore fails

Flow:

```text id="tf004-ref4"
Inventory infrastructure
→ Import resources
→ Validate state
```

Highest complexity.

---

# 6. Recovery Priority Order

Always follow this order:

```text id="tf004-ref5"
Restore Backup
→ Rebuild State
```

Never rebuild if valid backup exists.

---

# 7. Useful Commands

Check state:

```bash id="tf004-ref-cmd1"
terraform state list
```

Inspect state:

```bash id="tf004-ref-cmd2"
terraform show
```

Validate plan:

```bash id="tf004-ref-cmd3"
terraform plan
```

Import resources:

```bash id="tf004-ref-cmd4"
terraform import <resource> <resource_id>
```

---

# 8. Rebuild Best Practices

Important rebuild rules:

---

## Inventory First

Never start importing blindly.

Create complete infrastructure inventory first.

---

## Import in Dependency Order

Recommended order:

1. networking
2. security
3. compute
4. storage
5. managed services

---

## Validate Frequently

Validate after major imports.

Use:

* terraform state list
* terraform plan

---

# 9. Prevention Best Practices

---

## Use Remote Backends

Avoid local state in production.

Recommended:

* durable storage
* reliable backend
* versioned backend

---

## Enable State Versioning

Critical for recovery.

Benefits:

* backup recovery
* fast restoration
* rollback support

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

Limit state deletion risk.

---

# Key Lessons

Terraform state is Terraform’s source of infrastructure truth.

If state is missing:
Terraform loses infrastructure awareness.

Critical recovery priority:

Restore Terraform awareness before infrastructure changes.

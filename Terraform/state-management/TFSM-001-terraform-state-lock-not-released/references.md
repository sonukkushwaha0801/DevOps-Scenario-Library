# TFSM-001 — References

---

# Purpose

This document contains official documentation, backend-specific locking references, and best practices related to Terraform state lock management.

Use this for:

* Deeper technical understanding
* Root cause validation
* Backend-specific behavior
* Prevention strategies

This file is not part of active incident execution.

---

# 1. Terraform Official Documentation

## Terraform State

* Terraform State Overview
  https://developer.hashicorp.com/terraform/language/state

Purpose:
Understand Terraform state architecture and state management fundamentals.

---

## State Locking

* State Locking
  https://developer.hashicorp.com/terraform/language/state/locking

Purpose:
Understand how Terraform prevents concurrent state modifications.

Important Concepts:

* Lock acquisition
* Lock release
* Concurrent execution prevention

---

## Force Unlock

* terraform force-unlock
  https://developer.hashicorp.com/terraform/cli/commands/force-unlock

Purpose:
Official unlock command documentation.

Important:
Use only after confirming no active Terraform process.

---

# 2. Backend-Specific Locking Behavior

State locking implementation depends on backend.

---

## Local Backend

Behavior:

* Locking handled locally
* Limited protection for team collaboration

Common Issues:

* Stale local lock files
* Abrupt process termination

---

## Object Storage + Lock Database

Examples:

* Object storage for state
* Database lock table for locking

Behavior:

* Strong lock enforcement
* Common in production

Common Issues:

* Stale lock entries
* Failed lock cleanup

---

## Managed Terraform Platforms

Examples:

* Managed Terraform runners
* Remote execution platforms

Behavior:

* Locking handled by platform

Common Issues:

* Interrupted runs
* Failed remote apply

---

# 3. CI/CD Related References

Common pipeline causes of stale locks:

* Pipeline timeout
* Abrupt runner shutdown
* Failed cleanup stage
* Concurrent pipeline execution

Best practices:

* Single apply pipeline
* Lock-aware workflows
* Cleanup hooks
* Failure handling

---

# 4. Best Practices

Recommended safeguards:

---

## Prevent Concurrent Execution

Never allow:

* Multiple engineers running apply simultaneously
* Parallel apply jobs

Use:

* Deployment serialization
* Pipeline locking

---

## Backup State Regularly

Always maintain:

* State snapshots
* Version history
* Recovery backups

Critical for:

* Corruption recovery
* Incident rollback

---

## Add Timeout Strategy

Use:

* Lock timeout handling
* Retry strategy

Helps reduce:

* Manual unlock incidents

Example:

```bash id="w4wovj"
terraform apply -lock-timeout=300s
```

---

## Improve Incident Visibility

Monitor:

* Failed apply runs
* Lock acquisition failures
* Stale lock duration

Recommended alerts:

* Lock older than threshold
* Failed unlock attempts

---

# 5. Related Scenarios

Related incident scenarios:

* TF-002 Terraform State Drift Detected
* TF-003 Terraform State Corruption
* TF-010 Backend Initialization Failure
* TF-011 Backend Authentication Failure
* TF-034 Partial Apply Failure

---

# Key Lessons

Terraform state lock issues usually occur because of:

* Interrupted execution
* Poor CI/CD cleanup
* Concurrent operations
* Backend inconsistency

The safest recovery path is:

Verify
→ Confirm no active operations
→ Unlock safely
→ Validate state consistency

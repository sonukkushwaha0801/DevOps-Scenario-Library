# TF-001 — Terraform State Lock Not Released

## Scenario Overview

Terraform failed because the state lock was not released.

This prevents concurrent state modifications and blocks all future Terraform operations until the lock is cleared.

This scenario commonly occurs after:

* Interrupted terraform apply
* Failed CI/CD pipeline execution
* Network interruption
* Backend lock persistence failure
* Abrupt terminal closure

---

## Severity

* Priority: P1
* Category: State Management
* Recovery Complexity: Medium
* Estimated Recovery Time: 15–30 minutes

---

## Scenario Summary

Terraform uses state locking to prevent concurrent infrastructure modifications.

When a lock is acquired:

* No other Terraform operation can modify state

When lock cleanup fails:

* State remains locked
* All future operations fail

---

## Common Symptoms

* terraform apply fails
* terraform plan blocked
* terraform destroy blocked
* CI/CD pipeline stuck
* Infrastructure changes blocked

---

## Common Error Messages

```text id="lxyqxs"
Error acquiring the state lock
Failed to lock state
Lock Info
ConditionalCheckFailedException
state blob is already locked
```

---

## Scenario Matching

Use this scenario if:

✓ Error contains state lock failures
✓ Terraform operations blocked
✓ No active Terraform process exists
✓ Symptoms match stale lock behavior

### Confidence Classification

### Exact Match (95–100%)

* Error matches exactly
* Symptoms match completely

### Similar Match (70–95%)

* Error slightly different
* Same behavior pattern

### Related Match (40–70%)

* Partial symptom overlap

---

## Common Root Causes

* Interrupted terraform apply
* CI/CD pipeline crash
* Concurrent Terraform execution
* Backend locking failure
* Network failure during state update

---

## Recovery Flow

```text id="n77d8q"
Problem Detected
      ↓
Identify Lock Issue
      ↓
Check Active Operations
      ↓
Investigate Lock Owner
      ↓
Force Unlock (If Safe)
      ↓
Validate State
      ↓
Verify Recovery
      ↓
Close Incident
```

---

## Important Safety Rules

Never force unlock if:

* Terraform apply is actively running
* CI/CD pipeline is still executing
* Another engineer is modifying infrastructure

Unsafe unlock may cause:

* State corruption
* Concurrent modification
* Infrastructure inconsistency

---

# Investigation Workflow

Step 1:
Check active Terraform processes

```bash id="evwqgz"
ps aux | grep terraform
```

Step 2:
Validate lock issue

```bash id="24b6l2"
terraform plan
```

Step 3:
Recover safely if stale lock confirmed

```bash id="2ax9k7"
terraform force-unlock LOCK_ID
```

---

# Scenario Files

| File            | Purpose                             |
| --------------- | ----------------------------------- |
| metadata.yaml   | Scenario discovery engine           |
| commands.md     | Investigation and recovery commands |
| rollback.md     | Recovery rollback procedure         |
| verification.md | Final recovery validation           |
| references.md   | Official docs and best practices    |

---

# Scripts

| Script               | Purpose                    |
| -------------------- | -------------------------- |
| investigate-lock.sh  | Initial lock investigation |
| lock-diagnostics.sh  | Environment diagnostics    |
| force-unlock-safe.sh | Safe unlock helper         |

---

# Labs

Provider-specific labs for reproducing and recovering this issue.

## Generic Lab

Cloud-neutral simulation.

## AWS Lab

* Remote state in S3
* Lock storage in DynamoDB

## Azure Lab

* Remote state in Blob Storage
* Lock via Blob Lease

## GCP Lab

* Remote state in GCS
* Backend lock mechanisms

---

# Exit Criteria

Incident is resolved only when:

✓ Lock removed
✓ State accessible
✓ Backend healthy
✓ Terraform operational
✓ Infrastructure consistent

---

# Related Scenarios

* TF-002 Terraform State Drift Detected
* TF-003 Terraform State Corruption
* TF-010 Backend Initialization Failure

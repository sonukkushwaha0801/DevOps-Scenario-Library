# TF-001 — Rollback Procedure

## Overview

This document describes rollback actions when recovery procedures for a Terraform state lock were performed incorrectly.

Typical examples:

* Lock removed while active Terraform execution still existed
* Wrong lock record deleted
* CI/CD pipeline was still running during unlock
* Multiple operators executed recovery simultaneously
* Backend lock record removed accidentally

---

# Rollback Decision Matrix

| Situation                                                | Rollback Required |
| -------------------------------------------------------- | ----------------- |
| Active Terraform process discovered after unlock         | Yes               |
| Active CI/CD pipeline discovered after unlock            | Yes               |
| Wrong lock record deleted                                | Yes               |
| Lock removed successfully and no active operations exist | No                |
| Lock removal completed and validation succeeded          | No                |

---

# Scenario 1 — Active Terraform Process Still Running

## Description

State lock was removed but Terraform apply/plan is still running somewhere.

This creates risk of:

* Concurrent state modification
* State corruption
* Resource duplication
* Unexpected infrastructure changes

---

## Investigation

### Command

```bash id="c5d31x"
ps -ef | grep terraform
```

### Purpose

Identify active Terraform processes.

---

### Command

```bash id="pppw6v"
terraform plan
```

### Purpose

Detect unexpected concurrent modifications.

---

# Recovery Actions

## Immediate Actions

### Stop Additional Operations

Suspend:

* New terraform apply executions
* CI/CD deployments
* Automated infrastructure jobs

---

### Identify Lock Owner

Determine:

* User
* Host
* Pipeline
* Workspace

associated with active Terraform execution.

---

### Allow Original Execution to Complete

If operation is healthy:

```text id="l3y86m"
Do NOT terminate immediately.
Allow operation to finish safely.
```

---

### Recreate Lock Protection

If required:

Re-run Terraform operation to allow backend locking to occur normally.

---

# Scenario 2 — Wrong DynamoDB Lock Entry Deleted

## Description

Manual deletion removed incorrect lock record.

---

## Impact

Possible consequences:

* Active deployment loses protection
* Multiple applies execute simultaneously
* State consistency risk

---

# Investigation

### Command

```bash id="6rhl7z"
aws dynamodb scan \
  --table-name terraform-state-locks
```

### Purpose

Review remaining lock records.

---

### Command

```bash id="3z3c1z"
aws cloudtrail lookup-events
```

### Purpose

Determine who deleted the lock entry.

---

# Recovery Actions

## Option A — Active Operation Exists

Allow operation to complete.

Do not perform additional state modifications.

---

## Option B — Deployment Restart Required

Restart deployment using:

```bash id="okv8z9"
terraform plan
terraform apply
```

This recreates backend lock protection.

---

# Scenario 3 — Active CI/CD Pipeline Discovered After Unlock

## Description

State lock was forcefully removed while deployment pipeline was still running.

---

# Investigation

Verify:

* GitHub Actions
* GitLab CI
* Jenkins
* Azure DevOps
* Terraform Cloud

for active runs.

---

# Recovery Actions

## Suspend New Deployments

Prevent additional Terraform executions.

---

## Allow Active Deployment To Complete

If deployment is healthy:

```text id="qlw3pf"
Allow pipeline completion.
Avoid introducing additional state changes.
```

---

## Revalidate State Consistency

Run:

```bash id="c2zz4y"
terraform plan
```

Expected:

```text id="cjlwmz"
No changes.
Infrastructure is up-to-date.
```

---

# State Consistency Validation

Perform after every rollback operation.

---

## Command

```bash id="gc91z5"
terraform state list
```

### Expected Result

Resources visible.

---

## Command

```bash id="h4n28f"
terraform plan
```

### Expected Result

```text id="ie4nka"
No changes.
```

---

## Command

```bash id="64z4w4"
terraform refresh
```

### Purpose

Validate resource-state alignment.

---

# Rollback Success Criteria

Rollback is successful when all conditions are true:

```text id="6fx5j6"
✓ No active conflicting Terraform executions

✓ No active conflicting CI/CD pipelines

✓ Backend lock protection functioning

✓ State accessible

✓ terraform state list succeeds

✓ terraform plan succeeds

✓ No unexpected infrastructure changes detected

✓ No orphaned lock records remain
```

---

# Escalation Criteria

Escalate immediately if:

```text id="ic0xk5"
- Multiple concurrent applies detected

- State corruption suspected

- Resources unexpectedly recreated

- Terraform plan shows destructive actions

- Backend consistency cannot be verified

- Production infrastructure impacted
```

---

# Incident Severity Guidance

| Condition                                       | Severity |
| ----------------------------------------------- | -------- |
| Stale lock removed safely                       | Low      |
| Incorrect unlock performed                      | Medium   |
| Concurrent Terraform execution detected         | High     |
| State corruption suspected                      | Critical |
| Production outage caused by state inconsistency | Critical |

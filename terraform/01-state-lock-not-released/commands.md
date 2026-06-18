# TF-001 — Commands Reference

## Command Categories

| Category      | Description                                                   |
| ------------- | ------------------------------------------------------------- |
| SAFE          | Read-only commands. No infrastructure changes.                |
| INVESTIGATIVE | Diagnostic and metadata collection commands.                  |
| RECOVERY      | Commands that restore service or remove stale locks.          |
| DESTRUCTIVE   | Commands that modify backend data. Use only after validation. |
| EMERGENCY     | High-risk commands. Last resort actions.                      |

---

# SAFE COMMANDS

## Command

```bash
terraform version
```

### Purpose

Verify Terraform version and ensure expected binary is being used.

### Risk Level

LOW

### Expected Output

```text
Terraform v1.x.x
```

### Failure Indicators

```text
terraform: command not found
```

### Verification

Terraform CLI responds successfully.

---

## Command

```bash
terraform workspace show
```

### Purpose

Verify active workspace.

### Risk Level

LOW

### Expected Output

```text
default
```

or

```text
prod
```

### Failure Indicators

Workspace cannot be loaded.

### Verification

Current workspace matches deployment target.

---

## Command

```bash
terraform state list
```

### Purpose

Verify state accessibility.

### Risk Level

LOW

### Expected Output

List of managed resources.

### Failure Indicators

```text
Error acquiring the state lock
```

### Verification

State resources are displayed.

---

# INVESTIGATIVE COMMANDS

## Command

```bash
ps -ef | grep terraform
```

### Purpose

Determine whether a Terraform operation is currently running.

### Risk Level

LOW

### Expected Output

Running terraform process information.

### Failure Indicators

Unexpected active apply process.

### Verification

Confirm whether lock is legitimate.

---

## Command

```bash
terraform plan
```

### Purpose

Attempt lock acquisition and collect detailed error information.

### Risk Level

LOW

### Expected Output

Execution plan generated.

### Failure Indicators

```text
Error acquiring the state lock
```

### Verification

Capture exact lock error.

---

## Command

```bash
aws dynamodb scan \
  --table-name terraform-state-locks
```

### Purpose

Inspect active lock records.

### Risk Level

LOW

### Expected Output

Lock entry information.

### Failure Indicators

Unexpected lock records remain.

### Verification

Lock record owner identified.

---

## Command

```bash
aws dynamodb get-item \
  --table-name terraform-state-locks \
  --key '{"LockID":{"S":"<LOCK_ID>"}}'
```

### Purpose

Retrieve specific lock metadata.

### Risk Level

LOW

### Expected Output

Lock owner, operation, timestamp.

### Failure Indicators

Unable to retrieve lock details.

### Verification

Lock ownership confirmed.

---

# RECOVERY COMMANDS

## Command

```bash
terraform force-unlock <LOCK_ID>
```

### Purpose

Remove a stale Terraform lock.

### Risk Level

MEDIUM

### Preconditions

* Verify no active terraform process exists.
* Verify no CI/CD deployment is running.

### Expected Output

```text
Terraform state has been successfully unlocked.
```

### Failure Indicators

```text
Failed to unlock state
```

### Verification

```bash
terraform plan
```

Runs successfully.

---

## Command

```bash
terraform force-unlock -force <LOCK_ID>
```

### Purpose

Non-interactive unlock for automation.

### Risk Level

MEDIUM

### Preconditions

Active operation verified absent.

### Expected Output

Successful unlock.

### Failure Indicators

Unlock operation rejected.

### Verification

Terraform can acquire lock normally.

---

# DESTRUCTIVE COMMANDS

## Command

```bash
aws dynamodb delete-item \
  --table-name terraform-state-locks \
  --key '{"LockID":{"S":"<LOCK_ID>"}}'
```

### Purpose

Manually remove lock record from DynamoDB backend.

### Risk Level

HIGH

### Preconditions

* No active terraform process.
* No active CI/CD execution.
* Lock ownership validated.

### Expected Output

Lock record removed.

### Failure Indicators

Deletion succeeds while active apply still exists.

### Verification

```bash
aws dynamodb scan \
  --table-name terraform-state-locks
```

Lock entry absent.

---

# EMERGENCY COMMANDS

## Command

```bash
terraform force-unlock -force <LOCK_ID>
```

combined with

```bash
aws dynamodb delete-item ...
```

### Purpose

Recover from backend lock corruption.

### Risk Level

CRITICAL

### Preconditions

Incident commander approval recommended.

### Failure Impact

Concurrent state modification may corrupt infrastructure state.

### Verification Checklist

* No active Terraform process
* No active pipeline
* Lock removed
* terraform plan succeeds
* terraform apply succeeds
* State remains consistent

---

# Post-Recovery Validation

Run:

```bash
terraform plan
```

Expected:

```text
No changes.
Infrastructure is up-to-date.
```

Run:

```bash
terraform apply
```

Expected:

```text
Apply complete!
```

Run:

```bash
aws dynamodb scan \
  --table-name terraform-state-locks
```

Expected:

```text
No stale lock entries.
```

---

# Stop Conditions

DO NOT proceed with unlock operations if:

* Active terraform apply is running
* Active CI/CD deployment is running
* Lock ownership is unknown
* Multiple operators are investigating simultaneously
* Backend health is degraded

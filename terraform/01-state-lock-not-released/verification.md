# TF-001 — Verification Procedure

## Purpose

Verify that:

* Terraform state locking is functioning correctly
* No stale lock records remain
* No active conflicting Terraform operations exist
* State integrity is maintained
* Infrastructure remains consistent
* Future Terraform operations can proceed safely

---

# Verification Requirements

Recovery is considered successful only when ALL checks pass.

```text id="jg6xk5"
✓ State lock removed

✓ No active Terraform processes

✓ No active deployment pipelines

✓ Backend accessible

✓ State accessible

✓ Terraform plan succeeds

✓ Terraform apply succeeds

✓ State integrity maintained

✓ No stale lock records remain
```

---

# Verification Level 1 — Process Validation

## Check Active Terraform Processes

### Command

```bash id="t1zmdv"
ps -ef | grep terraform
```

### Purpose

Ensure no conflicting Terraform executions exist.

### Expected Output

```text id="j2byd5"
No active terraform apply process.
```

### Failure Indicators

```text id="r9nswk"
terraform apply
terraform plan
terraform destroy
```

still running unexpectedly.

### Status

```text id="l9kzsp"
PASS → No active processes

FAIL → Investigate ownership
```

---

# Verification Level 2 — CI/CD Validation

## Check Deployment Pipelines

Verify:

* GitHub Actions
* GitLab CI
* Jenkins
* Azure DevOps
* Terraform Cloud

### Expected Result

```text id="rzbt2d"
No conflicting active deployment.
```

### Failure Indicators

```text id="4qf5j3"
Terraform execution still running.
```

### Status

```text id="4n98yk"
PASS → No active pipelines

FAIL → Wait for completion
```

---

# Verification Level 3 — Backend Accessibility

## Command

```bash id="mqvwxy"
terraform state list
```

### Purpose

Validate state file access.

### Expected Output

Managed resources displayed.

Example:

```text id="iwt1r4"
aws_instance.web
aws_security_group.web
aws_s3_bucket.logs
```

### Failure Indicators

```text id="mx77e5"
Error acquiring the state lock
```

or

```text id="nhc5ci"
Failed to load backend
```

### Status

```text id="pr0v6l"
PASS → State accessible

FAIL → Backend investigation required
```

---

# Verification Level 4 — Lock Acquisition Test

## Command

```bash id="jz36m3"
terraform plan
```

### Purpose

Verify Terraform can successfully acquire a lock.

### Expected Output

```text id="jlwm04"
Terraform used the selected providers...
```

Plan completes successfully.

### Failure Indicators

```text id="ls2g78"
Error acquiring the state lock
```

### Status

```text id="qyvzfw"
PASS → Lock mechanism operational

FAIL → Recovery incomplete
```

---

# Verification Level 5 — DynamoDB Lock Validation

Applicable only for S3 + DynamoDB backend.

## Command

```bash id="l8q7s2"
aws dynamodb scan \
  --table-name terraform-state-locks
```

### Purpose

Verify stale lock removal.

### Expected Output

No stale lock entries.

Example:

```json id="jlwm0a"
{
  "Items": []
}
```

### Failure Indicators

Unexpected lock records remain.

### Status

```text id="i8b3ul"
PASS → No stale locks

FAIL → Investigate remaining records
```

---

# Verification Level 6 — State Integrity Validation

## Command

```bash id="yn8m8i"
terraform state list
```

### Purpose

Confirm state remains readable.

### Expected Output

Complete resource inventory.

### Failure Indicators

Missing resources.

Corrupted state.

Backend read failures.

### Status

```text id="4yvh6v"
PASS → State intact

FAIL → Escalate immediately
```

---

# Verification Level 7 — Infrastructure Consistency Check

## Command

```bash id="c0jlwm"
terraform plan
```

### Purpose

Verify infrastructure matches state.

### Expected Output

```text id="7yjlwm"
No changes.
Infrastructure is up-to-date.
```

### Failure Indicators

Unexpected create operations.

Unexpected destroy operations.

Unexpected replacement operations.

### Status

```text id="e3x8jl"
PASS → Infrastructure consistent

FAIL → Investigate drift
```

---

# Verification Level 8 — Apply Validation

## Command

```bash id="6y1nqt"
terraform apply
```

### Purpose

Validate end-to-end Terraform functionality.

### Expected Output

```text id="v93q1x"
Apply complete!
```

or

```text id="ozjwhk"
No changes.
```

### Failure Indicators

Lock acquisition errors.

Backend failures.

State write failures.

### Status

```text id="8y9hyk"
PASS → Full recovery confirmed

FAIL → Recovery incomplete
```

---

# Recovery Success Checklist

Complete every item.

| Check                               | Status |
| ----------------------------------- | ------ |
| No active Terraform processes       | ☐      |
| No active deployment pipelines      | ☐      |
| Backend accessible                  | ☐      |
| State accessible                    | ☐      |
| Lock acquisition successful         | ☐      |
| No stale lock records remain        | ☐      |
| State integrity verified            | ☐      |
| Infrastructure consistency verified | ☐      |
| Terraform apply successful          | ☐      |

---

# Exit Criteria

The incident may be closed only when:

```text id="v0jlwm"
✓ Terraform can acquire locks normally

✓ Terraform can release locks normally

✓ State is accessible

✓ Infrastructure matches state

✓ No stale lock records exist

✓ No concurrent Terraform operations exist

✓ Verification checklist completed
```

---

# Escalation Criteria

Escalate immediately if:

```text id="8rjlwm"
- Lock reappears unexpectedly

- State corruption suspected

- Resources missing from state

- Unexpected resource recreation detected

- Backend consistency cannot be verified

- Production services impacted

- Multiple concurrent Terraform executions detected
```

---

# Verification Outcome

| Result                       | Action                                |
| ---------------------------- | ------------------------------------- |
| All checks pass              | Incident resolved                     |
| Any check fails              | Recovery incomplete                   |
| State inconsistency detected | Escalate immediately                  |
| State corruption suspected   | Open TF-015 State Corruption Recovery |

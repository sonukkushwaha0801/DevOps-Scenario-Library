# TFSM-001 — Commands Reference

---

# Phase 1 — Initial Investigation

## Command 1: Check Running Terraform Processes

### Command

```bash
ps aux | grep terraform | grep -v grep
```

### Category

INVESTIGATIVE

### Purpose

Check whether an active Terraform operation is still running.

### Risk Level

SAFE

### Expected Output

* No active terraform process
  OR
* Running terraform apply/plan/destroy process

### Failure Indicators

* Long-running terraform apply
* Multiple terraform processes
* Zombie terraform process

### Verification

Confirm whether Terraform is actively modifying infrastructure.

---

## Command 2: Check Current CI/CD Pipeline Status

### Command

Example (Generic CI/CD)

```bash
Check pipeline dashboard for active Terraform jobs
```

### Category

INVESTIGATIVE

### Purpose

Determine whether lock is held by CI/CD pipeline.

### Risk Level

SAFE

### Expected Output

No active pipeline using Terraform.

### Failure Indicators

* Pipeline stuck
* Pipeline running apply
* Failed job without cleanup

### Verification

Ensure no remote pipeline owns lock.

---

# Phase 2 — Lock Diagnostics

## Command 3: Show Terraform Version

### Command

```bash
terraform version
```

### Category

SAFE

### Purpose

Validate Terraform CLI and provider environment.

### Risk Level

SAFE

### Expected Output

Terraform version details.

### Failure Indicators

* Version mismatch
* Binary missing

### Verification

CLI working normally.

---

## Command 4: Check Current Workspace

### Command

```bash
terraform workspace show
```

### Category

SAFE

### Purpose

Ensure correct workspace is targeted.

### Risk Level

SAFE

### Expected Output

Current workspace name.

### Failure Indicators

* Wrong workspace
* Workspace inaccessible

### Verification

Workspace matches incident environment.

---

## Command 5: Reproduce Lock Error

### Command

```bash
terraform plan
```

### Category

INVESTIGATIVE

### Purpose

Verify lock issue still exists.

### Risk Level

SAFE

### Expected Output

Plan execution or lock error.

### Failure Indicators

* Error acquiring state lock
* Failed to lock state
* Lock Info displayed

### Verification

Lock issue confirmed.

---

# Phase 3 — Recovery

## Command 6: Force Unlock State

⚠ Execute ONLY after confirming:

* No active Terraform process
* No CI/CD job running
* No engineer currently applying changes

### Command

```bash
terraform force-unlock LOCK_ID
```

### Category

RECOVERY

### Purpose

Remove stale Terraform lock.

### Risk Level

HIGH

### Expected Output

State lock removed successfully.

### Failure Indicators

* Unlock failed
* Backend unavailable
* Lock still present

### Verification

Lock removed.

---

# Phase 4 — Verification

## Command 7: Validate Terraform State Access

### Command

```bash
terraform state list
```

### Category

SAFE

### Purpose

Confirm state accessibility.

### Risk Level

SAFE

### Expected Output

List of tracked resources.

### Failure Indicators

* Backend access failure
* State corruption
* Empty state unexpectedly

### Verification

State accessible.

---

## Command 8: Validate Full Recovery

### Command

```bash
terraform plan
```

### Category

SAFE

### Purpose

Confirm Terraform operations restored.

### Risk Level

SAFE

### Expected Output

Successful plan.

### Failure Indicators

* Lock persists
* Backend issue remains
* State inconsistent

### Verification

Terraform operational again.

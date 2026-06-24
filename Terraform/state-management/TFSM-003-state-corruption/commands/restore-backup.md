# Restore Backup — Commands Reference

## Scenario

Terraform state is corrupted, but a healthy backup is available.

Goal:
Restore the last known healthy Terraform state.

---

# Recovery Priority

Preferred recovery path for state corruption incidents.

Risk Level: Medium
Recovery Complexity: Medium

---

# Phase 1 — Emergency Containment

## Step 1 — Stop All Terraform Operations

Immediately stop:

* active terraform processes
* CI/CD pipelines
* scheduled infra jobs

Linux:

```bash id="tf003-cmd-1"
ps aux | grep terraform
```

If needed:

```bash id="tf003-cmd-2"
kill -9 <PID>
```

Category: EMERGENCY
Risk: SAFE

Purpose:
Prevent additional state writes.

---

# Phase 2 — Backup Corrupted State

## Step 2 — Create Emergency Backup

Before recovery, backup corrupted state.

Example:

```bash id="tf003-cmd-3"
cp terraform.tfstate terraform.tfstate.corrupted.backup
```

Category: SAFE
Risk: SAFE

Purpose:
Preserve corrupted state for analysis and rollback.

Important:
Never skip this step.

---

# Phase 3 — Validate Backup Availability

## Step 3 — Identify Healthy Backup

Check:

* remote backend snapshots
* versioned object storage
* manual backups
* state backup automation

Required:
Backup must be known-good.

Category: INVESTIGATIVE
Risk: SAFE

---

# Phase 4 — Restore Backup

## Step 4 — Restore Healthy State

Example:

```bash id="tf003-cmd-4"
cp terraform.tfstate.backup terraform.tfstate
```

Remote backends:
Restore backend snapshot or previous version.

Category: RECOVERY
Risk: HIGH

Purpose:
Replace corrupted state with healthy backup.

Failure Indicators:

* backup also corrupted
* incomplete backup
* backend restore failure

---

# Phase 5 — Validate State

## Step 5 — Check State Readability

```bash id="tf003-cmd-5"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable.

Failure Indicators:

* state still corrupted
* backend inaccessible

---

# Phase 6 — Validate Plan Safety

## Step 6 — Run Terraform Plan

```bash id="tf003-cmd-6"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
Predictable plan output.

Failure Indicators:

* massive drift
* unexpected resource recreation
* unexpected destroy operations

---

# Recovery Success Criteria

✓ State restored
✓ State readable
✓ Terraform operational
✓ Infrastructure consistent

---

# Escalation Conditions

Escalate immediately if:

* no healthy backup exists
* restored backup invalid
* plan unsafe after restore
* resource mapping inconsistent

Next recovery path:

* repair_state
* rebuild_state

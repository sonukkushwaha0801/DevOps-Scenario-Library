# Restore Backup — Commands Reference

## Scenario

Terraform state file is missing, but a healthy backup exists.

Goal:
Restore missing state and recover Terraform resource awareness.

---

# Recovery Priority

Preferred recovery path.

Risk Level: Medium
Recovery Complexity: Medium

---

# Phase 1 — Emergency Containment

## Step 1 — Stop All Terraform Operations

Immediately stop:

* active terraform processes
* CI/CD pipelines
* infrastructure automation

```bash id="tf004-cmd-1"
ps aux | grep terraform
```

If needed:

```bash id="tf004-cmd-2"
kill -9 <PID>
```

Category: EMERGENCY
Risk: SAFE

Purpose:
Prevent accidental infrastructure changes.

---

# Phase 2 — Validate State Absence

## Step 2 — Confirm Missing State

Check:

```bash id="tf004-cmd-3"
terraform state list
```

Category: INVESTIGATIVE
Risk: SAFE

Expected:
State unavailable.

Failure Indicators:

* state file missing
* backend object missing
* state load failure

---

# Phase 3 — Locate Backup

## Step 3 — Find Healthy Backup

Check:

* backend snapshots
* versioned object storage
* manual backups
* automated backup systems

Required:
Backup must be verified healthy.

Category: INVESTIGATIVE
Risk: SAFE

---

# Phase 4 — Restore Backup

## Step 4 — Restore State

Example:

```bash id="tf004-cmd-4"
cp terraform.tfstate.backup terraform.tfstate
```

Remote backend:
Restore missing backend object from backup.

Category: RECOVERY
Risk: HIGH

Purpose:
Restore missing Terraform state.

Failure Indicators:

* backup missing
* backup invalid
* restore unsuccessful

---

# Phase 5 — Validate State

## Step 5 — Check State Readability

```bash id="tf004-cmd-5"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable.

PASS:
Resources listed.

FAIL:
State unavailable or invalid.

---

# Phase 6 — Validate Plan Safety

## Step 6 — Run Terraform Plan

```bash id="tf004-cmd-6"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
Predictable plan output.

PASS:
No dangerous changes.

FAIL:

* massive drift
* unexpected resource recreation
* destroy operations

---

# Recovery Success Criteria

✓ State restored
✓ State readable
✓ Terraform operational
✓ Infrastructure consistent

---

# Escalation Conditions

Escalate immediately if:

* no backup exists
* backup invalid
* restore fails
* plan unsafe

Next recovery path:

* rebuild_state

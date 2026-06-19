# Restore Backup — Rollback Procedure

## Purpose

Rollback recovery actions if backup restoration causes new issues.

Examples:

* wrong backup restored
* backup outdated
* state inconsistent after restore
* Terraform plan unsafe

---

# Rollback Severity

P0 / P1

Immediate escalation recommended.

---

# Rollback Triggers

Start rollback immediately if:

* restored state unreadable
* backup invalid
* massive drift detected
* unexpected destroy operations appear

---

# Phase 1 — Emergency Containment

## Step 1 — Stop All Terraform Operations

Immediately stop:

* terraform processes
* CI/CD pipelines
* infra automation

```bash id="tf003-rb-1"
ps aux | grep terraform
```

If needed:

```bash id="tf003-rb-2"
kill -9 <PID>
```

Category: EMERGENCY
Risk: SAFE

Purpose:
Prevent additional state changes.

---

# Phase 2 — Preserve Failed Recovery State

## Step 2 — Backup Restored State

Example:

```bash id="tf003-rb-3"
cp terraform.tfstate terraform.tfstate.failed-restore
```

Category: SAFE
Risk: SAFE

Purpose:
Preserve failed recovery state for analysis.

---

# Phase 3 — Assess Failure

## Step 3 — Identify Root Cause

Check:

* wrong backup selected
* outdated backup
* corrupted backup
* backend restore issue

Category: INVESTIGATIVE
Risk: SAFE

---

# Phase 4 — Reassess Recovery Options

Decision:

```text id="tf003-rb-4"
Use another backup?
     OR
Repair state?
     OR
Rebuild state?
```

Preferred order:

1. Try another healthy backup
2. Repair state
3. Rebuild state

---

# Phase 5 — Validate State Health

## Step 4 — Check State

```bash id="tf003-rb-5"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable.

Failure:
State inaccessible.

---

# Phase 6 — Validate Plan Safety

## Step 5 — Run Plan

```bash id="tf003-rb-6"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
Safe and predictable plan.

Failure Indicators:

* massive drift
* unexpected destroys
* unsafe replacements

---

# Rollback Success Criteria

✓ Operations stopped
✓ Failed restore contained
✓ Root cause identified
✓ New recovery path selected

---

# Escalation Conditions

Escalate immediately if:

* no healthy backup available
* state unreadable
* restore repeatedly fails
* infrastructure risk high

Escalate to:

* Senior DevOps Engineer
* Platform Engineer
* Incident Commander

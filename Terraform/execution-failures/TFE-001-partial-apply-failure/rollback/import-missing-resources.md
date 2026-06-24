# Import Missing Resources — Rollback Procedure

## Purpose

Rollback recovery actions when resource import fails or introduces incorrect Terraform state mappings.

Goal:
Prevent incorrect state mappings and contain infrastructure risk.

---

# Rollback Severity

P0

Critical incident state.

Immediate reassessment required.

---

# Rollback Triggers

Start rollback immediately if:

* import command fails repeatedly
* incorrect resource mappings detected
* resource IDs mismatch
* terraform plan becomes unsafe

---

# Phase 1 — Emergency Containment

## Step 1 — Stop Further Imports

Immediately stop:

* terraform import
* CI/CD automation
* infrastructure changes

Category: EMERGENCY
Risk: SAFE

Purpose:
Prevent additional state corruption.

---

# Phase 2 — Preserve Current State

## Step 2 — Backup Current State

```bash id="imrb-1"
cp terraform.tfstate terraform.tfstate.import-failed
```

Category: SAFE
Risk: SAFE

Purpose:
Preserve current state for investigation.

---

# Phase 3 — Assess Mapping Integrity

## Step 3 — Audit Imported Resources

Check:

* imported resources
* mapping accuracy
* resource IDs
* configuration alignment

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Identify incorrect mappings.

---

# Phase 4 — Validate Terraform State

## Step 4 — Check State

```bash id="imrb-2"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable.

Failure Indicators:

* incorrect resources
* inconsistent mappings
* state issues

---

# Phase 5 — Reassess Recovery Path

Choose next recovery path:

* retry import with correct mappings
* manual_recovery

Decision based on:

* state integrity
* mapping correctness
* infrastructure condition

---

# Rollback Success Criteria

✓ Further imports stopped
✓ Current state preserved
✓ Mapping issues identified
✓ New recovery path selected

---

# Escalation Conditions

Escalate immediately if:

* mappings incorrect
* state corrupted
* infrastructure unstable
* plan unsafe

Escalate to:

* Senior DevOps Engineer
* Platform Engineering Lead
* Incident Commander

# Import Missing Resources — Rollback Procedure

## Purpose

Rollback recovery actions when resource import fails or creates incorrect state mappings.

Goal:
Prevent incorrect Terraform state mappings and infrastructure risk.

---

# Rollback Severity

P0

Critical state-risk incident.

Immediate reassessment required.

---

# Rollback Triggers

Start rollback immediately if:

* import command fails
* mapping uncertainty detected
* resource IDs mismatch
* terraform plan becomes unsafe

---

# Phase 1 — Emergency Containment

## Step 1 — Stop Further Imports

Immediately stop:

* terraform import
* terraform apply
* CI/CD automation

Category: EMERGENCY
Risk: SAFE

Purpose:
Prevent further state inconsistency.

---

# Phase 2 — Preserve Current State

## Step 2 — Backup Current State

```bash id="irtb-1"
cp terraform.tfstate terraform.tfstate.import-timeout-failed
```

Category: SAFE
Risk: SAFE

Purpose:
Preserve Terraform state for investigation.

---

# Phase 3 — Assess Mapping Integrity

## Step 3 — Audit Imported Resources

Check:

* imported resources
* mapping correctness
* resource IDs
* configuration alignment

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Identify incorrect mappings.

---

# Phase 4 — Validate Terraform State

## Step 4 — Check State

```bash id="irtb-2"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable.

Failure Indicators:

* wrong resources
* invalid mappings
* state inconsistencies

---

# Phase 5 — Reassess Recovery Path

Choose next recovery path:

* retry import with correct mapping
* manual_recovery

Decision based on:

* state integrity
* resource certainty
* infrastructure condition

---

# Rollback Success Criteria

✓ Further imports stopped
✓ Current state preserved
✓ Mapping issues identified
✓ Safe next path selected

---

# Escalation Conditions

Escalate immediately if:

* mappings incorrect
* state inconsistent
* plan unsafe
* infrastructure unstable

Escalate to:

* Senior DevOps Engineer
* Platform Engineering Lead
* Incident Commander

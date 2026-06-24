# Check Resource Status — Rollback Procedure

## Purpose

Rollback recovery actions when resource status investigation fails or returns conflicting results.

Goal:
Prevent unsafe recovery actions until infrastructure state is clearly understood.

---

# Rollback Severity

P0

High uncertainty incident.

Immediate caution required.

---

# Rollback Triggers

Start rollback immediately if:

* resource state unknown
* provider responses inconsistent
* infrastructure status unclear
* state and provider mismatch

---

# Phase 1 — Emergency Containment

## Step 1 — Stop Recovery Actions

Immediately stop:

* terraform apply retries
* terraform imports
* infrastructure automation
* CI/CD pipelines

Category: EMERGENCY
Risk: SAFE

Purpose:
Prevent unsafe infrastructure changes.

---

# Phase 2 — Preserve Current State

## Step 2 — Backup Current State

```bash id="csrb-1"
cp terraform.tfstate terraform.tfstate.status-check-failed
```

Category: SAFE
Risk: SAFE

Purpose:
Preserve current Terraform state for investigation.

---

# Phase 3 — Investigate Uncertainty

## Step 3 — Audit Status Sources

Review:

* Terraform state
* provider APIs
* cloud console
* infrastructure telemetry

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Identify source of inconsistency.

---

# Phase 4 — Validate Terraform State

## Step 4 — Check State

```bash id="csrb-2"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable.

Failure Indicators:

* state inaccessible
* state inconsistent
* missing resources

---

# Phase 5 — Escalate Recovery Path

Choose next recovery path:

* extended investigation
* manual_recovery

Decision based on:

* provider stability
* resource criticality
* business impact

---

# Rollback Success Criteria

✓ Recovery actions stopped
✓ Current state preserved
✓ Status uncertainty identified
✓ Safe next path selected

---

# Escalation Conditions

Escalate immediately if:

* provider state unknown
* infrastructure unstable
* resource status unresolved
* business impact increasing

Escalate to:

* Senior DevOps Engineer
* Platform Engineering Lead
* Incident Commander

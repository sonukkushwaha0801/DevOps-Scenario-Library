# Retry Apply — Rollback Procedure

## Purpose

Rollback recovery actions when retry apply fails again or triggers repeated timeout conditions.

Goal:
Prevent repeated retry loops and contain infrastructure risk.

---

# Rollback Severity

P0

Repeated failure incident.

Immediate reassessment required.

---

# Rollback Triggers

Start rollback immediately if:

* retry apply times out again
* repeated failures occur
* provider conflicts detected
* infrastructure becomes inconsistent

---

# Phase 1 — Emergency Containment

## Step 1 — Stop Further Retries

Immediately stop:

* terraform apply retries
* CI/CD retry loops
* infrastructure automation

Category: EMERGENCY
Risk: SAFE

Purpose:
Prevent repeated failures.

---

# Phase 2 — Preserve Current State

## Step 2 — Backup Current State

```bash id="rrtb-1"
cp terraform.tfstate terraform.tfstate.retry-timeout-failed
```

Category: SAFE
Risk: SAFE

Purpose:
Preserve Terraform state for investigation.

---

# Phase 3 — Investigate Failure

## Step 3 — Review Retry Failure

Check:

* timeout patterns
* provider conflicts
* infrastructure changes
* repeated failure points

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Determine why retry failed.

---

# Phase 4 — Validate Terraform State

## Step 4 — Check State

```bash id="rrtb-2"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable.

Failure Indicators:

* missing resources
* state inconsistencies
* state corruption

---

# Phase 5 — Reassess Recovery Path

Choose next recovery path:

* import_missing_resources
* manual_recovery

Decision based on:

* infrastructure condition
* provider state
* timeout cause

---

# Rollback Success Criteria

✓ Retry loop stopped
✓ Current state preserved
✓ Failure root cause identified
✓ Safe next path selected

---

# Escalation Conditions

Escalate immediately if:

* repeated timeout continues
* provider unstable
* infrastructure inconsistent
* resource status unclear

Escalate to:

* Senior DevOps Engineer
* Platform Engineering Lead
* Incident Commander

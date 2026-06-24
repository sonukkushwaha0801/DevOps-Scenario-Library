# Retry Apply — Rollback Procedure

## Purpose

Rollback recovery actions when retry apply fails again or introduces additional infrastructure inconsistency.

Goal:
Contain incident and prevent repeated failed apply attempts.

---

# Rollback Severity

P0 / P1

Immediate reassessment required.

---

# Rollback Triggers

Start rollback immediately if:

* retry apply fails again
* repeated errors occur
* infrastructure becomes more inconsistent
* state drift increases

---

# Phase 1 — Emergency Containment

## Step 1 — Stop Further Apply Attempts

Immediately stop:

* terraform apply
* CI/CD deployment pipelines
* infrastructure automation

Category: EMERGENCY
Risk: SAFE

Purpose:
Prevent worsening infrastructure inconsistency.

---

# Phase 2 — Preserve Current State

## Step 2 — Backup Current State

```bash id="rrb-1"
cp terraform.tfstate terraform.tfstate.retry-failed
```

Category: SAFE
Risk: SAFE

Purpose:
Preserve current Terraform state for investigation.

---

# Phase 3 — Investigate Failure

## Step 3 — Review Retry Failure

Check:

* repeated error messages
* new failures
* infrastructure changes
* dependency failures

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Determine why retry failed.

---

# Phase 4 — Validate Terraform State

## Step 4 — Check State

```bash id="rrb-2"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable.

Failure:
State inconsistent or corrupted.

---

# Phase 5 — Reassess Recovery Path

Choose next recovery path:

* rollback_partial
* import_missing_resources
* manual_recovery

Decision based on:

* infrastructure state
* state consistency
* failure cause

---

# Rollback Success Criteria

✓ Repeated applies stopped
✓ Current state preserved
✓ Failure root cause identified
✓ New recovery path selected

---

# Escalation Conditions

Escalate immediately if:

* repeated failures continue
* infrastructure unstable
* state inconsistent
* plan unsafe

Escalate to:

* Senior DevOps Engineer
* Platform Engineering Lead
* Incident Commander

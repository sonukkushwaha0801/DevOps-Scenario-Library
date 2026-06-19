# Rebuild State — Rollback Procedure

## Purpose

Rollback recovery actions if state rebuild fails or creates unsafe infrastructure conditions.

Examples:

* resource imports fail repeatedly
* partial rebuild completed
* resource mapping incorrect
* terraform plan unsafe

---

# Rollback Severity

P0

Critical incident state.

Immediate escalation required.

---

# Rollback Triggers

Start rollback immediately if:

* imports fail repeatedly
* resource inventory incomplete
* state partially rebuilt incorrectly
* terraform plan unsafe

---

# Phase 1 — Emergency Containment

## Step 1 — Stop All Terraform Operations

Immediately stop:

* terraform processes
* CI/CD pipelines
* infrastructure automation

```bash
ps aux | grep terraform
```

If needed:

```bash
kill -9 <PID>
```

Category: EMERGENCY
Risk: SAFE

Purpose:
Prevent additional infrastructure impact.

---

# Phase 2 — Preserve Partial Rebuild State

## Step 2 — Backup Partial State

```bash
cp terraform.tfstate terraform.tfstate.failed-rebuild
```

Category: SAFE
Risk: SAFE

Purpose:
Preserve partial rebuild state for analysis.

---

# Phase 3 — Assess Infrastructure Risk

## Step 3 — Evaluate Blast Radius

Check:

* imported resources
* missing resources
* incorrect mappings
* dependency failures

Classify risk:

* Low
* Medium
* High
* Critical

Category: INVESTIGATIVE
Risk: SAFE

---

# Phase 4 — Freeze Infrastructure Changes

Immediately enforce:

* no manual infra changes
* no automation changes
* no deployments

Purpose:
Maintain stable infrastructure during incident.

---

# Phase 5 — Validate State Accessibility

## Step 4 — Check State

```bash
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State accessible.

Failure:
State unusable.

---

# Phase 6 — Validate Plan Safety

## Step 5 — Run Plan

```bash
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
Predictable plan.

Failure Indicators:

* massive drift
* destructive actions
* invalid mappings

---

# Rollback Success Criteria

✓ Rebuild halted safely
✓ Partial state preserved
✓ Infrastructure protected
✓ Incident contained

---

# Mandatory Escalation

Escalate immediately to:

* Senior DevOps Engineer
* Platform Engineering Lead
* Incident Commander

Possible next actions:

* manual recovery
* provider support engagement
* infrastructure audit
* full disaster recovery plan

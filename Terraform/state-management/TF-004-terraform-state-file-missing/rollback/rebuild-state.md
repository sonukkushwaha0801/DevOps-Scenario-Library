# Rebuild State — Rollback Procedure

## Purpose

Rollback recovery actions if state rebuild fails or introduces unsafe infrastructure conditions.

Examples:

* resource imports fail repeatedly
* partial rebuild incomplete
* incorrect resource mappings
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
* inventory incomplete
* partial state incorrect
* terraform plan unsafe

---

# Phase 1 — Emergency Containment

## Step 1 — Stop All Terraform Operations

Immediately stop:

* terraform processes
* CI/CD pipelines
* infrastructure automation

```bash id="tf004-rb2-1"
ps aux | grep terraform
```

If needed:

```bash id="tf004-rb2-2"
kill -9 <PID>
```

Category: EMERGENCY
Risk: SAFE

Purpose:
Prevent infrastructure changes.

---

# Phase 2 — Preserve Partial State

## Step 2 — Backup Partial State

```bash id="tf004-rb2-3"
cp terraform.tfstate terraform.tfstate.failed-rebuild
```

Category: SAFE
Risk: SAFE

Purpose:
Preserve partial rebuild state.

---

# Phase 3 — Assess Infrastructure Risk

## Step 3 — Evaluate Risk

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

* no manual changes
* no deployments
* no automation changes

Purpose:
Maintain infrastructure stability.

---

# Phase 5 — Validate State Accessibility

## Step 4 — Check State

```bash id="tf004-rb2-4"
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

```bash id="tf004-rb2-5"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
Predictable plan.

Failure Indicators:

* massive drift
* destroy operations
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
* disaster recovery plan

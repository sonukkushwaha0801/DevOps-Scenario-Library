# Repair State — Rollback Procedure

## Purpose

Rollback recovery actions if state repair introduces additional issues.

Examples:

* repair worsened corruption
* state unreadable after repair
* resource mappings broken
* terraform plan unsafe

---

# Rollback Severity

P0 / P1

High-risk rollback path.

Immediate escalation recommended.

---

# Rollback Triggers

Start rollback immediately if:

* state corruption worsens
* repair introduces invalid state structure
* imports fail repeatedly
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
Prevent further state corruption.

---

# Phase 2 — Preserve Failed Repair State

## Step 2 — Backup Failed Repair State

```bash
cp terraform.tfstate terraform.tfstate.failed-repair
```

Category: SAFE
Risk: SAFE

Purpose:
Preserve failed repair state for analysis.

---

# Phase 3 — Assess Repair Damage

## Step 3 — Identify Failure Type

Check for:

* broken JSON structure
* invalid metadata
* missing resources
* incorrect imports

Category: INVESTIGATIVE
Risk: SAFE

---

# Phase 4 — Reassess Recovery Path

Decision:

```text
Try Restore Backup?
      OR
Rebuild State?
```

Preferred order:

1. Restore backup if available
2. Rebuild state

Important:
Avoid repeated manual repair attempts.

---

# Phase 5 — Validate State Accessibility

## Step 4 — Check State

```bash
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

```bash
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
Safe and predictable plan.

Failure Indicators:

* massive drift
* resource destruction
* unsafe replacements

---

# Rollback Success Criteria

✓ Unsafe repair stopped
✓ Failed repair state preserved
✓ Damage assessed
✓ New recovery path selected

---

# Escalation Conditions

Escalate immediately if:

* state unreadable
* corruption severe
* imports repeatedly fail
* infrastructure mapping uncertain

Escalate to:

* Senior DevOps Engineer
* Platform Engineer
* Incident Commander

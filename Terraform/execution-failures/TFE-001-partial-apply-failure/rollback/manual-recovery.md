# Manual Recovery — Rollback Procedure

## Purpose

Rollback recovery actions when manual recovery fails or worsens infrastructure consistency.

Goal:
Contain blast radius, stabilize infrastructure, and prevent critical service impact.

---

# Rollback Severity

P0

Maximum severity incident.

Emergency escalation required.

---

# Rollback Triggers

Start rollback immediately if:

* manual recovery fails
* infrastructure instability increases
* state becomes inconsistent
* production services degrade

---

# Phase 1 — Emergency Containment

## Step 1 — Freeze All Changes

Immediately stop:

* terraform operations
* CI/CD pipelines
* infrastructure automation
* manual infrastructure changes

Category: EMERGENCY
Risk: SAFE

Purpose:
Prevent additional damage.

---

# Phase 2 — Preserve Current State

## Step 2 — Backup Current State

```bash id="mrrb-1"
cp terraform.tfstate terraform.tfstate.manual-recovery-failed
```

Category: SAFE
Risk: SAFE

Purpose:
Preserve Terraform state for forensic investigation.

---

# Phase 3 — Assess Blast Radius

## Step 3 — Perform Emergency Audit

Identify:

* broken infrastructure
* impacted services
* dependency failures
* production impact

Classify severity:

* High
* Critical
* Catastrophic

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Understand incident impact.

---

# Phase 4 — Validate Terraform State

## Step 4 — Check State

```bash id="mrrb-2"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable.

Failure Indicators:

* missing resources
* corrupted state
* invalid mappings

---

# Phase 5 — Incident Stabilization

Immediate priorities:

* restore service stability
* protect production workloads
* reduce customer impact

Possible actions:

* service failover
* emergency rollback
* provider support escalation

---

# Rollback Success Criteria

✓ All changes frozen
✓ Current state preserved
✓ Blast radius assessed
✓ Incident stabilized

---

# Mandatory Escalation

Escalate immediately to:

* Senior DevOps Engineer
* Platform Engineering Lead
* Incident Commander
* Cloud Provider Support

Possible escalation:

* Disaster Recovery Team
* Leadership
* Business Continuity Team

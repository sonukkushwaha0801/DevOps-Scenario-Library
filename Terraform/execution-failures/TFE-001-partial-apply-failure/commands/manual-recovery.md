# Manual Recovery — Commands Reference

## Scenario

Terraform apply partially failed and automated recovery paths are unsafe or unsuccessful.

Infrastructure and Terraform state may be severely inconsistent.

Goal:
Manually recover infrastructure and restore Terraform consistency.

---

# Recovery Priority

Last-resort recovery path.

Risk Level: CRITICAL
Recovery Complexity: VERY HIGH

Estimated Recovery Time:
2–24 hours+

---

# Manual Recovery Conditions

Use manual recovery when:

* retry apply unsafe
* rollback unsafe
* import unsafe
* infrastructure heavily inconsistent

Examples:

* shared infrastructure affected
* production outage risk high
* dependency graph broken

---

# Phase 1 — Emergency Containment

## Step 1 — Freeze All Changes

Immediately stop:

* terraform operations
* CI/CD pipelines
* infrastructure automation
* manual deployments

Category: EMERGENCY
Risk: SAFE

Purpose:
Prevent further infrastructure drift.

---

# Phase 2 — Assess Infrastructure

## Step 2 — Perform Infrastructure Audit

Identify:

* resources created
* resources failed
* broken dependencies
* shared infrastructure impact

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Understand current infrastructure state.

---

## Step 3 — Validate Terraform State

Run:

```bash id="mr-1"
terraform state list
```

Category: INVESTIGATIVE
Risk: SAFE

Expected:
State readable.

Failure Indicators:

* inconsistent state
* missing resources
* corrupted state

---

# Phase 3 — Select Manual Recovery Strategy

Choose one:

* manual rollback
* manual completion
* partial rebuild
* resource import

Decision depends on:

* infra criticality
* dependency graph
* business impact

---

# Phase 4 — Execute Recovery

## Step 4 — Perform Manual Recovery

Possible actions:

* manually remove resources
* manually complete deployment
* import resources into state
* rebuild broken dependencies

Category: RECOVERY
Risk: CRITICAL

Purpose:
Restore infrastructure consistency.

---

# Phase 5 — Validate Infrastructure

## Step 5 — Audit Infrastructure Again

Confirm:

* dependencies restored
* resources healthy
* services operational

Category: VERIFICATION
Risk: SAFE

---

# Phase 6 — Validate Terraform

## Step 6 — Validate Plan

```bash id="mr-2"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
Predictable plan.

PASS:
Terraform operational.

FAIL:

* major drift
* replacements
* unsafe changes

---

# Recovery Success Criteria

✓ Infrastructure stable
✓ Dependencies healthy
✓ Terraform state valid
✓ Terraform operational

---

# Mandatory Escalation

Escalate immediately to:

* Senior DevOps Engineer
* Platform Engineering Lead
* Incident Commander

Possible additional escalation:

* Cloud provider support
* Internal platform team

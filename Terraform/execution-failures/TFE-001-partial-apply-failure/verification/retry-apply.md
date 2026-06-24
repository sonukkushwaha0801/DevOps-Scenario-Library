# Retry Apply — Verification Procedure

## Purpose

Verify retry apply successfully completed infrastructure provisioning and restored system consistency.

Goal:
Ensure infrastructure, dependencies, and Terraform state are healthy.

---

# Verification Checklist

| Check                  | Status |
| ---------------------- | ------ |
| Apply successful       | ⬜      |
| State consistent       | ⬜      |
| Infrastructure healthy | ⬜      |
| Dependencies healthy   | ⬜      |
| Terraform plan safe    | ⬜      |

---

# Phase 1 — Validate Terraform State

## Check 1 — Verify State

```bash id="vr-1"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable and complete.

PASS:
All expected resources visible.

FAIL:
Missing resources or inconsistent state.

---

# Phase 2 — Validate Infrastructure

## Check 2 — Audit Resources

Verify:

* compute resources
* networking
* storage
* security resources

PASS:
All expected resources created.

FAIL:
Missing or unhealthy resources.

---

# Phase 3 — Validate Dependencies

## Check 3 — Verify Dependencies

Confirm:

* networking dependencies
* security dependencies
* service connectivity

Examples:

* VM in correct subnet
* load balancer attached
* IAM permissions valid

PASS:
Dependencies healthy.

FAIL:
Dependency issues detected.

---

# Phase 4 — Validate Terraform Plan

## Check 4 — Run Plan

```bash id="vr-2"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
Predictable plan.

PASS:
No unexpected changes.

FAIL:

* replacements
* drift
* destroy operations

---

# Phase 5 — Validate Services

## Check 5 — Service Health Validation

Confirm:

* applications reachable
* services healthy
* no production impact

PASS:
Infrastructure stable.

FAIL:
Operational issues detected.

---

# Exit Criteria

Incident resolved only if:

✓ Retry apply successful
✓ Infrastructure healthy
✓ Dependencies healthy
✓ Terraform state valid
✓ Terraform operational

---


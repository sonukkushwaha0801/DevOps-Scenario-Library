# Reject Drift — Verification Procedure

## Purpose

Verify infrastructure successfully reverted to Terraform desired state.

Goal:
Infrastructure must match IaC.

---

# Verification Checklist

| Check                   | Status |
| ----------------------- | ------ |
| Infrastructure restored | ⬜      |
| Service stable          | ⬜      |
| State consistent        | ⬜      |
| Plan clean              | ⬜      |

---

# Phase 1 — Validate State

## Check 1

```bash id="jlwm55"
terraform state list
```

Expected:
State accessible.

PASS:
State healthy.

FAIL:
State inconsistency.

---

# Phase 2 — Verify Infrastructure

Confirm:

* drifted resources restored
* unauthorized changes removed
* service healthy

---

# Phase 3 — Verify Plan

## Check 2

```bash id="jlwm56"
terraform plan
```

Expected:
No changes.

PASS:
Infra matches IaC.

FAIL:
Drift remains.

---

# Exit Criteria

✓ Drift resolved
✓ Infrastructure restored
✓ State healthy
✓ Terraform plan clean
✓ No active incident

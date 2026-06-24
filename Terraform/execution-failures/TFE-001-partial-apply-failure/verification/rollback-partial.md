# Rollback Partial Infrastructure — Verification Procedure

## Purpose

Verify partial infrastructure rollback successfully removed created resources and restored a clean infrastructure baseline.

Goal:
Ensure partial resources are removed, Terraform state is consistent, and infrastructure is safe.

---

# Verification Checklist

| Check                      | Status |
| -------------------------- | ------ |
| Partial resources removed  | ⬜      |
| No orphan resources        | ⬜      |
| Terraform state consistent | ⬜      |
| Baseline restored          | ⬜      |
| Terraform plan safe        | ⬜      |

---

# Phase 1 — Validate Infrastructure Cleanup

## Check 1 — Verify Partial Resources Removed

Confirm removed resources:

* compute resources
* networking resources
* storage resources
* temporary resources

PASS:
Partial resources removed.

FAIL:
Orphan resources remain.

---

# Phase 2 — Check Orphan Resources

## Check 2 — Audit Infrastructure

Verify:

* no hidden resources
* no orphan dependencies
* no dangling configurations

Examples:

* orphan subnet
* orphan security group
* orphan storage

PASS:
Infrastructure clean.

FAIL:
Cleanup incomplete.

---

# Phase 3 — Validate Terraform State

## Check 3 — Verify State

```bash id="vrbp-1"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State reflects clean baseline.

PASS:
No stale entries.

FAIL:
State inconsistencies detected.

---

# Phase 4 — Validate Terraform Plan

## Check 4 — Run Plan

```bash id="vrbp-2"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
Predictable plan.

PASS:
Safe future deployment possible.

FAIL:

* drift detected
* stale resources
* unexpected changes

---

# Phase 5 — Validate Environment Stability

## Check 5 — Baseline Validation

Confirm:

* environment stable
* dependencies healthy
* no service impact

PASS:
Baseline restored.

FAIL:
Residual issues remain.

---

# Exit Criteria

Incident resolved only if:

✓ Partial resources removed
✓ No orphan resources
✓ State consistent
✓ Baseline restored
✓ Terraform operational

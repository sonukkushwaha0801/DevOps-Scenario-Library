# Import Missing Resources — Verification Procedure

## Purpose

Verify imported resources are correctly mapped in Terraform state and infrastructure consistency is restored.

Goal:
Ensure imported resources match Terraform configuration and Terraform can safely manage infrastructure.

---

# Verification Checklist

| Check                      | Status |
| -------------------------- | ------ |
| Resources imported         | ⬜      |
| Resource mappings correct  | ⬜      |
| Terraform state consistent | ⬜      |
| Dependencies healthy       | ⬜      |
| Terraform plan safe        | ⬜      |

---

# Phase 1 — Validate Imported Resources

## Check 1 — Verify Resources in State

```bash id="vimr-1"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
Imported resources visible.

PASS:
All expected resources tracked.

FAIL:
Missing resources.

---

# Phase 2 — Validate Resource Mapping

## Check 2 — Audit Mapping Accuracy

Confirm:

* resource IDs correct
* configuration matches
* no duplicate mappings

Examples:

* correct VM mapped
* correct subnet mapped
* correct storage mapped

PASS:
Mappings accurate.

FAIL:
Incorrect mappings detected.

---

# Phase 3 — Validate Terraform State

## Check 3 — Inspect State

```bash id="vimr-2"
terraform show
```

Category: VERIFICATION
Risk: SAFE

Expected:
State consistent and readable.

PASS:
State healthy.

FAIL:
State inconsistencies detected.

---

# Phase 4 — Validate Dependencies

## Check 4 — Verify Dependencies

Confirm:

* networking healthy
* security healthy
* service dependencies valid

Examples:

* VM attached correctly
* IAM bindings correct
* LB targets valid

PASS:
Dependencies healthy.

FAIL:
Dependency issues detected.

---

# Phase 5 — Validate Terraform Plan

## Check 5 — Run Plan

```bash id="vimr-3"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
Predictable plan.

PASS:
No unexpected creation, replacement, or destroy.

FAIL:

* duplicate creation attempts
* replacements
* drift
* destroy operations

---

# Exit Criteria

Incident resolved only if:

✓ Resources imported
✓ Mappings correct
✓ State consistent
✓ Dependencies healthy
✓ Terraform operational


# Retry Apply — Verification Procedure

## Purpose

Verify retry apply successfully completed infrastructure provisioning after apply timeout.

Goal:
Ensure infrastructure is stable and Terraform state is consistent.

---

# Verification Checklist

| Check                  | Status |
| ---------------------- | ------ |
| Retry apply completed  | ⬜      |
| No duplicate resources | ⬜      |
| Terraform state valid  | ⬜      |
| Infrastructure stable  | ⬜      |
| Terraform plan safe    | ⬜      |

---

# Phase 1 — Validate Apply Completion

## Check 1 — Confirm Retry Completion

Verify:

* apply completed successfully
* no timeout occurred
* no provider conflict occurred

PASS:
Retry completed.

FAIL:
Retry failed or timed out.

---

# Phase 2 — Validate Infrastructure

## Check 2 — Audit Resources

Verify:

* expected resources created
* no duplicate resources
* no orphan resources

PASS:
Infrastructure correct.

FAIL:
Resource duplication or drift detected.

---

# Phase 3 — Validate Terraform State

## Check 3 — Check State

```bash id="vrta-1"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State complete and readable.

PASS:
State valid.

FAIL:
State inconsistent.

---

# Phase 4 — Validate Terraform Plan

## Check 4 — Run Plan

```bash id="vrta-2"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
Predictable plan.

PASS:
No unexpected changes.

FAIL:

* duplicate creation
* replacements
* drift
* destroy operations

---

# Phase 5 — Validate Stability

## Check 5 — Infrastructure Stability

Confirm:

* resources healthy
* services operational
* no provisioning issues

PASS:
Infrastructure stable.

FAIL:
Operational issues remain.

---

# Exit Criteria

Incident resolved only if:

✓ Retry completed
✓ Infrastructure correct
✓ State valid
✓ Infrastructure stable
✓ Terraform operational


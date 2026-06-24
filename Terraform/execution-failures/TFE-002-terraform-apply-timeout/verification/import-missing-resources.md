# Import Missing Resources — Verification Procedure

## Purpose

Verify imported resources are correctly mapped and infrastructure consistency is restored after apply timeout.

Goal:
Ensure Terraform state accurately reflects real infrastructure.

---

# Verification Checklist

| Check                 | Status |
| --------------------- | ------ |
| Resource imported     | ⬜      |
| Mapping accurate      | ⬜      |
| Configuration matches | ⬜      |
| Terraform state valid | ⬜      |
| Terraform plan safe   | ⬜      |

---

# Phase 1 — Validate Imported Resource

## Check 1 — Confirm Resource Imported

Verify:

* resource exists in state
* expected resource tracked

PASS:
Resource imported.

FAIL:
Resource missing in state.

---

# Phase 2 — Validate Mapping Accuracy

## Check 2 — Audit Resource Mapping

Confirm:

* resource ID correct
* imported resource correct
* provider resource matches Terraform config

PASS:
Mapping accurate.

FAIL:
Wrong mapping detected.

---

# Phase 3 — Validate Terraform State

## Check 3 — Check State

```bash id="vimrt-1"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable and complete.

PASS:
State valid.

FAIL:
State inconsistencies detected.

---

# Phase 4 — Validate Imported State

## Check 4 — Inspect State

```bash id="vimrt-2"
terraform show
```

Category: VERIFICATION
Risk: SAFE

Expected:
Imported resource correct.

PASS:
State accurate.

FAIL:
State mismatch detected.

---

# Phase 5 — Validate Terraform Plan

## Check 5 — Run Plan

```bash id="vimrt-3"
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

# Exit Criteria

Incident resolved only if:

✓ Resource imported
✓ Mapping accurate
✓ Configuration matches
✓ State valid
✓ Terraform operational


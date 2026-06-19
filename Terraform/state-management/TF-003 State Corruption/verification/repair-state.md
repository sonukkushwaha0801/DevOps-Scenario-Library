# Repair State — Verification Procedure

## Purpose

Verify repaired Terraform state is valid, consistent, and safe for production operations.

Goal:
Ensure repaired state fully resolves corruption without introducing inconsistencies.

---

# Verification Checklist

| Check                    | Status |
| ------------------------ | ------ |
| State readable           | ⬜      |
| State structure valid    | ⬜      |
| Resource mapping correct | ⬜      |
| Imported resources valid | ⬜      |
| Terraform plan safe      | ⬜      |

---

# Phase 1 — Validate State Accessibility

## Check 1 — Read State

```bash
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable.

PASS:
Resources listed successfully.

FAIL:
State still corrupted.

---

# Phase 2 — Validate State Structure

## Check 2 — Inspect State Metadata

```bash
terraform show
```

Category: VERIFICATION
Risk: SAFE

Verify:

* state readable
* metadata valid
* resources visible

PASS:
State structure healthy.

FAIL:
Metadata or structural issues detected.

---

# Phase 3 — Validate Resource Mapping

## Check 3 — Inspect Resources

Confirm:

* resources mapped correctly
* IDs accurate
* dependencies intact

Check:

* compute
* network
* storage
* IAM

PASS:
Mappings accurate.

FAIL:
Missing or incorrect mappings.

---

# Phase 4 — Validate Imports

## Check 4 — Verify Imported Resources

Confirm:

* imports successful
* resource IDs correct
* no duplicate mappings

PASS:
Imported resources valid.

FAIL:
Import inconsistencies detected.

---

# Phase 5 — Validate Plan Safety

## Check 5 — Run Plan

```bash
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
Predictable plan.

PASS:
No dangerous changes.

FAIL:

* massive drift
* unexpected destroys
* resource recreation

---

# Phase 6 — Infrastructure Validation

Confirm:

* infrastructure healthy
* services operational
* no outages

PASS:
Infrastructure stable.

FAIL:
Operational issues detected.

---

# Exit Criteria

Incident resolved only if:

✓ State readable
✓ State structure valid
✓ Resource mapping correct
✓ Imports valid
✓ Infrastructure healthy
✓ Terraform operational

---

# Failure Handling

If verification fails:

Next path:

* rollback repair_state
  OR
* rebuild_state

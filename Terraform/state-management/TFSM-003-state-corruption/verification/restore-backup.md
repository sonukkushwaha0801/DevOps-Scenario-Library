# Restore Backup — Verification Procedure

## Purpose

Verify backup restoration successfully resolved Terraform state corruption.

Goal:
Ensure restored state is healthy, consistent, and safe for operations.

---

# Verification Checklist

| Check                    | Status |
| ------------------------ | ------ |
| State readable           | ⬜      |
| State consistent         | ⬜      |
| Resource mapping correct | ⬜      |
| Terraform plan safe      | ⬜      |

---

# Phase 1 — Validate State Accessibility

## Check 1 — Read State

```bash id="tf003-ver-1"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable.

PASS:
Resources listed successfully.

FAIL:
State inaccessible or corrupted.

---

# Phase 2 — Validate Resource Mapping

## Check 2 — Inspect Resources

Review:

* compute resources
* network resources
* storage resources
* IAM resources

Confirm:
Resources exist and are correctly mapped.

Category: VERIFICATION
Risk: SAFE

PASS:
Resources mapped correctly.

FAIL:
Missing or incorrect resources.

---

# Phase 3 — Validate State Consistency

## Check 3 — Inspect State Metadata

Example:

```bash id="tf003-ver-2"
terraform show
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable with valid metadata.

PASS:
State healthy.

FAIL:
Metadata inconsistencies detected.

---

# Phase 4 — Validate Plan Safety

## Check 4 — Run Plan

```bash id="tf003-ver-3"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
Predictable plan output.

PASS:
No dangerous changes.

FAIL:

* massive drift
* resource recreation
* destroy operations

---

# Phase 5 — Infrastructure Validation

Confirm:

* infrastructure healthy
* services operational
* no outages

Category: VERIFICATION
Risk: SAFE

PASS:
Infrastructure stable.

FAIL:
Operational issues detected.

---

# Exit Criteria

Incident resolved only if:

✓ State readable
✓ State consistent
✓ Resource mapping correct
✓ Infrastructure healthy
✓ Terraform operational

---

# Failure Handling

If verification fails:

Next path:

* repair_state
  OR
* rebuild_state

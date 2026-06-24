# Restore Backup — Verification Procedure

## Purpose

Verify backup restoration successfully recovered missing Terraform state.

Goal:
Ensure restored state is available, accurate, and safe for production operations.

---

# Verification Checklist

| Check                    | Status |
| ------------------------ | ------ |
| State available          | ⬜      |
| State readable           | ⬜      |
| Resource mapping correct | ⬜      |
| Terraform plan safe      | ⬜      |

---

# Phase 1 — Validate State Availability

## Check 1 — Confirm State Exists

```bash id="tf004-ver-1"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State available and readable.

PASS:
Resources listed successfully.

FAIL:
State missing or inaccessible.

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

PASS:
Resource mappings correct.

FAIL:
Missing or incorrect resources.

---

# Phase 3 — Validate State Consistency

## Check 3 — Inspect State

```bash id="tf004-ver-2"
terraform show
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable and consistent.

PASS:
State healthy.

FAIL:
State inconsistencies detected.

---

# Phase 4 — Validate Plan Safety

## Check 4 — Run Plan

```bash id="tf004-ver-3"
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
* unexpected resource recreation
* destroy operations

---

# Phase 5 — Infrastructure Validation

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

✓ State restored
✓ State readable
✓ Resource mappings correct
✓ Infrastructure healthy
✓ Terraform operational

---

# Failure Handling

If verification fails:

Next path:

* restore alternate backup
  OR
* rebuild_state

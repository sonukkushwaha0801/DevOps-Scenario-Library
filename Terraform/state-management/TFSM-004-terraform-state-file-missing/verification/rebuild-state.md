# Rebuild State — Verification Procedure

## Purpose

Verify rebuilt Terraform state is complete, accurate, and safe for production operations.

Goal:
Ensure rebuilt state fully represents existing infrastructure and Terraform can safely manage it.

---

# Verification Checklist

| Check                     | Status |
| ------------------------- | ------ |
| State readable            | ⬜      |
| All resources imported    | ⬜      |
| Resource mappings correct | ⬜      |
| Dependencies valid        | ⬜      |
| Terraform plan safe       | ⬜      |

---

# Phase 1 — Validate State Accessibility

## Check 1 — Read State

```bash id="tf004-ver-r1"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable.

PASS:
Resources listed successfully.

FAIL:
State inaccessible.

---

# Phase 2 — Validate Resource Coverage

## Check 2 — Verify All Resources Imported

Confirm all expected resources exist.

Check:

* compute
* networking
* storage
* IAM
* managed services

PASS:
All resources imported.

FAIL:
Missing resources detected.

---

# Phase 3 — Validate Resource Mapping

## Check 3 — Inspect Imported Resources

Confirm:

* resource IDs correct
* mappings accurate
* no duplicate imports

PASS:
Mappings valid.

FAIL:
Incorrect mappings.

---

# Phase 4 — Validate Dependencies

## Check 4 — Verify Dependencies

Confirm:

* network dependencies correct
* security dependencies correct
* service dependencies intact

Examples:

* VM attached to correct subnet
* storage attached correctly
* IAM references valid

PASS:
Dependencies valid.

FAIL:
Dependency issues detected.

---

# Phase 5 — Validate State Consistency

## Check 5 — Inspect State

```bash id="tf004-ver-r2"
terraform show
```

Category: VERIFICATION
Risk: SAFE

Expected:
State consistent.

PASS:
State healthy.

FAIL:
State inconsistencies detected.

---

# Phase 6 — Validate Plan Safety

## Check 6 — Run Plan

```bash id="tf004-ver-r3"
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
* destroy operations
* unexpected replacements

---

# Phase 7 — Infrastructure Validation

Confirm:

* infrastructure healthy
* services operational
* no outages
* dependencies functioning

PASS:
Infrastructure stable.

FAIL:
Operational issues detected.

---

# Exit Criteria

Incident resolved only if:

✓ State readable
✓ All resources imported
✓ Resource mappings correct
✓ Dependencies valid
✓ Infrastructure healthy
✓ Terraform operational

---

# Failure Handling

If verification fails:

Immediate actions:

* rollback rebuild_state
* escalate incident

Escalate to:

* Senior DevOps Engineer
* Platform Engineering Lead
* Incident Commander

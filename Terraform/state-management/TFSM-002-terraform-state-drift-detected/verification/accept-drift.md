# Accept Drift — Verification Procedure

## Purpose

Verify that manual infrastructure changes were successfully accepted into Terraform code.

Goal:
IaC must now match actual infrastructure.

---

# Verification Checklist

| Check                    | Status |
| ------------------------ | ------ |
| Terraform config updated | ⬜      |
| Config valid             | ⬜      |
| Plan clean               | ⬜      |
| IaC matches infra        | ⬜      |

---

# Phase 1 — Validate Configuration

## Check 1

```bash id="jlwm53"
terraform validate
```

Expected:
Configuration valid.

PASS:
No validation errors.

FAIL:
Invalid configuration.

---

# Phase 2 — Verify Plan

## Check 2

```bash id="jlwm54"
terraform plan
```

Expected:
No unexpected changes.

PASS:
Plan clean.

FAIL:
Drift still exists.

---

# Phase 3 — Verify Infrastructure

Check actual infrastructure.

Confirm:

* resource values correct
* intended manual change preserved

---

# Exit Criteria

✓ Drift resolved
✓ Terraform config updated
✓ IaC matches infrastructure
✓ No active incident

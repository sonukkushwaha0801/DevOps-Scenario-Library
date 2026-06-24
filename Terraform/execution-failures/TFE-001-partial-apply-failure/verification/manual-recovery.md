# Manual Recovery — Verification Procedure

## Purpose

Verify manual recovery successfully restored infrastructure stability, service health, and Terraform operability.

Goal:
Ensure incident is fully resolved and infrastructure is stable.

---

# Verification Checklist

| Check                    | Status |
| ------------------------ | ------ |
| Infrastructure stable    | ⬜      |
| Services healthy         | ⬜      |
| Dependencies healthy     | ⬜      |
| Terraform state valid    | ⬜      |
| Business impact resolved | ⬜      |

---

# Phase 1 — Validate Infrastructure

## Check 1 — Infrastructure Audit

Verify:

* compute healthy
* networking healthy
* storage healthy
* security resources healthy

PASS:
Infrastructure stable.

FAIL:
Infrastructure issues remain.

---

# Phase 2 — Validate Dependencies

## Check 2 — Dependency Validation

Confirm:

* service dependencies restored
* networking dependencies healthy
* security dependencies healthy

Examples:

* subnet routing valid
* IAM access valid
* load balancer healthy

PASS:
Dependencies healthy.

FAIL:
Dependency issues remain.

---

# Phase 3 — Validate Services

## Check 3 — Service Health Validation

Confirm:

* applications reachable
* services operational
* customer impact removed

Examples:

* API reachable
* UI accessible
* workloads healthy

PASS:
Services healthy.

FAIL:
Operational impact remains.

---

# Phase 4 — Validate Terraform State

## Check 4 — Verify State

```bash id="vmr-1"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable and valid.

PASS:
State healthy.

FAIL:
State inconsistent.

---

# Phase 5 — Validate Terraform Plan

## Check 5 — Run Plan

```bash id="vmr-2"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
Predictable plan.

PASS:
Terraform operational.

FAIL:

* drift
* replacements
* unexpected destroy

---

# Phase 6 — Business Validation

## Check 6 — Business Impact Assessment

Confirm:

* incident impact removed
* service availability restored
* normal operations resumed

PASS:
Business impact resolved.

FAIL:
Incident still active.

---

# Exit Criteria

Incident resolved only if:

✓ Infrastructure stable
✓ Services healthy
✓ Dependencies healthy
✓ Terraform operational
✓ Business impact resolved

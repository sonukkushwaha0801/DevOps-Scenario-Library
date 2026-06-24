# Manual Recovery — Verification Procedure

## Purpose

Verify manual recovery successfully restored infrastructure stability, provider consistency, service health, and Terraform operability.

Goal:
Ensure timeout incident is fully resolved.

---

# Verification Checklist

| Check                    | Status |
| ------------------------ | ------ |
| Infrastructure stable    | ⬜      |
| Provider stable          | ⬜      |
| Services healthy         | ⬜      |
| Terraform state valid    | ⬜      |
| Business impact resolved | ⬜      |

---

# Phase 1 — Validate Infrastructure

## Check 1 — Infrastructure Audit

Verify:

* compute healthy
* networking healthy
* storage healthy
* security healthy

PASS:
Infrastructure stable.

FAIL:
Infrastructure issues remain.

---

# Phase 2 — Validate Provider Stability

## Check 2 — Provider Validation

Confirm:

* provider APIs stable
* resource lifecycle stable
* no provisioning stuck states

PASS:
Provider stable.

FAIL:
Provider instability remains.

---

# Phase 3 — Validate Services

## Check 3 — Service Health Validation

Confirm:

* applications reachable
* services operational
* customer impact removed

PASS:
Services healthy.

FAIL:
Operational issues remain.

---

# Phase 4 — Validate Terraform State

## Check 4 — Check State

```bash id="vmrt-1"
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

```bash id="vmrt-2"
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

## Check 6 — Incident Closure Validation

Confirm:

* incident impact removed
* service availability restored
* normal operations resumed

PASS:
Incident resolved.

FAIL:
Incident still active.

---

# Exit Criteria

Incident resolved only if:

✓ Infrastructure stable
✓ Provider stable
✓ Services healthy
✓ Terraform operational
✓ Business impact resolved


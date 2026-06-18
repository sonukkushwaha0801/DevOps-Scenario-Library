# TF-001 — Verification Procedure

---

# Purpose

This verification procedure confirms that Terraform state lock recovery succeeded and infrastructure operations are safe to resume.

Incident is resolved only if all verification checks pass.

---

# Verification Severity

P1

Failure in verification means incident remains active.

---

# Verification Checklist

| Check                     | Status |
| ------------------------- | ------ |
| Lock removed              | [ ]    |
| State accessible          | [ ]    |
| Backend healthy           | [ ]    |
| Terraform operational     | [ ]    |
| Infrastructure consistent | [ ]    |

---

# Phase 1 — Validate Lock Removal

## Check 1: Re-run Terraform Plan

```bash id="ofkrkr"
terraform plan
```

Expected:

* Plan executes normally
* No lock error

PASS:
No lock-related error.

FAIL:

* Error acquiring state lock
* Failed to lock state

---

# Phase 2 — Validate State Accessibility

## Check 2: List State Resources

```bash id="xtbyli"
terraform state list
```

Expected:
Resources visible in state.

PASS:
State readable.

FAIL:

* State inaccessible
* Backend unreachable
* Empty state unexpectedly

---

# Phase 3 — Validate Backend Health

## Check 3: Verify Backend Connectivity

Run backend-specific health validation.

Examples:

* Remote state reachable
* Lock storage healthy
* Authentication valid

PASS:
Backend healthy.

FAIL:

* Authentication failure
* Storage unreachable
* Backend degraded

---

# Phase 4 — Validate Terraform Operations

## Check 4: Refresh State

```bash id="4juh8m"
terraform plan -refresh-only
```

Expected:
Refresh completes successfully.

PASS:
Terraform can communicate with infrastructure.

FAIL:

* Provider failure
* Backend failure
* Resource access issues

---

# Phase 5 — Validate Infrastructure Consistency

## Check 5: Inspect Plan Output

Review plan carefully.

Expected:

* No unexpected destroy
* No unexpected resource recreation
* No major drift

PASS:
Expected changes only.

FAIL:

* Massive drift
* Unexpected recreation
* Unexpected destroy operations

---

# Phase 6 — Final Validation

Incident can be closed only if ALL conditions pass.

---

# Exit Criteria

✓ State lock removed
✓ Terraform commands operational
✓ Backend healthy
✓ State accessible
✓ Infrastructure consistent
✓ No active Terraform process
✓ No active CI/CD execution

---

# Incident Closure Decision Matrix

## Close Incident

If:

* All checks PASS

Action:
Incident resolved.

---

## Keep Incident Open

If:

* Any check FAILS

Action:
Continue investigation.

Escalate to:

* Senior DevOps Engineer
* SRE
* Platform Engineering

---

# Post Verification Actions

Mandatory:

* Document incident timeline
* Record root cause
* Update scenario notes
* Implement preventive controls

Recommended:

* State backup automation
* Better CI/CD locking safeguards
* Improved incident alerts

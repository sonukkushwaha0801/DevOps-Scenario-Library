# Retry Apply — Commands Reference

## Scenario

Terraform apply failed after partially creating or modifying infrastructure.

Failure appears transient and retry may safely complete remaining changes.

Goal:
Safely retry Terraform apply to complete deployment.

---

# Recovery Priority

Preferred recovery path for transient failures.

Risk Level: Medium–High
Recovery Complexity: Medium

---

# Safe Retry Conditions

Retry only if failure caused by:

* request timeout
* API throttling
* temporary provider outage
* temporary network issue

Unsafe retry conditions:

* invalid configuration
* permission denied
* quota exceeded
* dependency failure

---

# Phase 1 — Investigate Failure

## Step 1 — Review Apply Output

Review:

* created resources
* failed resources
* error messages

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Understand partial apply state.

---

## Step 2 — Validate State

Run:

```bash
terraform state list
```

Category: INVESTIGATIVE
Risk: SAFE

Expected:
State readable and updated.

Failure Indicators:

* missing resources
* inconsistent state
* corrupted state

---

# Phase 2 — Validate Infrastructure

## Step 3 — Assess Partial Infrastructure

Check:

* successfully created resources
* failed resources
* dependency health

Examples:

* VPC created
* subnet created
* VM failed

Category: INVESTIGATIVE
Risk: SAFE

---

# Phase 3 — Validate Plan

## Step 4 — Run Plan

```bash
terraform plan
```

Category: INVESTIGATIVE
Risk: SAFE

Expected:
Plan shows only remaining changes.

PASS:
Retry likely safe.

FAIL:

* destroy operations
* unexpected replacements
* massive drift

---

# Phase 4 — Retry Apply

## Step 5 — Retry Deployment

```bash
terraform apply
```

Category: RECOVERY
Risk: HIGH

Purpose:
Complete remaining infrastructure changes.

Expected:
Remaining resources created successfully.

Failure Indicators:

* repeated failure
* new errors
* additional dependency failures

---

# Recovery Success Criteria

✓ Apply completed successfully
✓ Infrastructure consistent
✓ Dependencies healthy
✓ Terraform operational

---

# Escalation Conditions

Escalate immediately if:

* retry fails repeatedly
* state inconsistent
* plan unsafe
* infrastructure unstable

Next recovery path:

* rollback_partial
  OR
* import_missing_resources

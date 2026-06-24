# Retry Apply — Commands Reference

## Scenario

Terraform apply timed out or was interrupted before completion.

Resource status has been checked and retry is considered safe.

Goal:
Safely retry Terraform apply to complete infrastructure provisioning.

---

# Recovery Priority

Use only after resource status verification.

Risk Level: High
Recovery Complexity: Medium–High

---

# Safe Retry Conditions

Retry only if:

* resource not created
* previous operation incomplete
* provider not processing resource
* state healthy

Unsafe retry conditions:

* resource still provisioning
* resource already created but not tracked
* provider operation still active

---

# Phase 1 — Validate State

## Step 1 — Check Terraform State

```bash id="rta-1"
terraform state list
```

Category: INVESTIGATIVE
Risk: SAFE

Expected:
State readable.

Check:

* missing resources
* state consistency

---

# Phase 2 — Validate Plan

## Step 2 — Run Plan

```bash id="rta-2"
terraform plan
```

Category: INVESTIGATIVE
Risk: SAFE

Expected:
Plan shows pending resource creation.

PASS:
Retry likely safe.

FAIL:

* unexpected changes
* drift
* replacements

---

# Phase 3 — Retry Apply

## Step 3 — Retry Deployment

```bash id="rta-3"
terraform apply
```

Category: RECOVERY
Risk: HIGH

Purpose:
Complete pending infrastructure changes.

Expected:
Infrastructure provisioning completes successfully.

Failure Indicators:

* timeout again
* repeated interruption
* provider conflict

---

# Recovery Success Criteria

✓ Apply completed
✓ Infrastructure provisioned
✓ State valid
✓ Terraform operational

---

# Escalation Conditions

Escalate immediately if:

* timeout repeats
* resource status changes unexpectedly
* provider conflicts occur
* infrastructure inconsistent


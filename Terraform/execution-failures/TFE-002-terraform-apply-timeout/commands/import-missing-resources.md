# Import Missing Resources — Commands Reference

## Scenario

Terraform apply timed out or was interrupted.

Infrastructure resource was successfully created, but Terraform state does not track it.

Goal:
Import missing resources into Terraform state and restore infrastructure consistency.

---

# Recovery Priority

Use when resource exists but state tracking is missing.

Risk Level: High
Recovery Complexity: High

---

# Safe Import Conditions

Import only if:

* resource exists
* provisioning completed successfully
* resource configuration matches Terraform code
* state missing resource

Unsafe import conditions:

* resource still provisioning
* resource failed partially
* resource ID unclear

---

# Phase 1 — Validate Infrastructure

## Step 1 — Confirm Resource Exists

Check provider infrastructure.

Verify:

* resource exists
* resource healthy
* provisioning completed

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Confirm resource eligible for import.

---

# Phase 2 — Validate Terraform State

## Step 2 — Check State

```bash id="imrt-1"
terraform state list
```

Category: INVESTIGATIVE
Risk: SAFE

Expected:
Resource missing in state.

---

# Phase 3 — Import Resource

## Step 3 — Import Missing Resource

```bash id="imrt-2"
terraform import <resource_name> <resource_id>
```

Example:

```bash id="imrt-3"
terraform import aws_eks_cluster.main cluster-name
```

Category: RECOVERY
Risk: HIGH

Purpose:
Restore state tracking.

Expected:
Resource imported successfully.

Failure Indicators:

* import failure
* mapping mismatch
* invalid resource ID

---

# Phase 4 — Validate Imported Resource

## Step 4 — Inspect State

```bash id="imrt-4"
terraform show
```

Category: VERIFICATION
Risk: SAFE

Expected:
Imported resource visible and correct.

---

# Phase 5 — Validate Plan

## Step 5 — Run Plan

```bash id="imrt-5"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
No duplicate creation.

PASS:
State consistent.

FAIL:

* replacements
* drift
* duplicate creation

---

# Recovery Success Criteria

✓ Resource exists
✓ Resource imported
✓ State consistent
✓ Terraform operational

---

# Escalation Conditions

Escalate immediately if:

* import fails
* mapping incorrect
* state inconsistent
* plan unsafe


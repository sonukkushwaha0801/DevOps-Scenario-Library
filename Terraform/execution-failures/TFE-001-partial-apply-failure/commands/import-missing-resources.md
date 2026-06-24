# Import Missing Resources — Commands Reference

## Scenario

Terraform apply partially failed.

Some resources were created successfully in infrastructure but are missing from Terraform state.

Goal:
Import missing resources into Terraform state and restore infrastructure consistency.

---

# Recovery Priority

Use when resources exist but Terraform is not tracking them.

Risk Level: HIGH
Recovery Complexity: HIGH

---

# Safe Import Conditions

Import preferred when:

* resource exists in cloud
* resource missing in Terraform state
* resource matches Terraform configuration

Unsafe import conditions:

* resource configuration unknown
* resource IDs unclear
* resource manually modified

---

# Phase 1 — Investigate Failure

## Step 1 — Review Apply Output

Identify:

* created resources
* failed resources
* state tracking gaps

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Determine missing resources.

---

## Step 2 — Validate State

Run:

```bash id="imr-1"
terraform state list
```

Category: INVESTIGATIVE
Risk: SAFE

Expected:
State readable.

Purpose:
Identify tracked resources.

---

# Phase 2 — Validate Infrastructure

## Step 3 — Find Missing Resources

Check cloud infrastructure.

Identify:

* resources created successfully
* resources missing in state

Example:

* EC2 exists
* Terraform does not track EC2

Category: INVESTIGATIVE
Risk: SAFE

---

# Phase 3 — Import Resources

## Step 4 — Import Missing Resource

Command:

```bash id="imr-2"
terraform import <resource_name> <resource_id>
```

Example:

```bash id="imr-3"
terraform import aws_instance.web i-123456789
```

Category: RECOVERY
Risk: HIGH

Purpose:
Add missing resource to Terraform state.

Expected:
Resource imported successfully.

Failure Indicators:

* import failure
* invalid resource ID
* mapping mismatch

---

# Phase 4 — Validate State

## Step 5 — Verify Imported Resource

```bash id="imr-4"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
Imported resource visible in state.

PASS:
Resource tracked.

FAIL:
Resource missing.

---

# Phase 5 — Validate Plan

## Step 6 — Run Plan

```bash id="imr-5"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
No duplicate resource creation.

PASS:
Plan safe.

FAIL:

* duplicate creation attempts
* replacements
* drift detected

---

# Recovery Success Criteria

✓ Missing resources imported
✓ State consistent
✓ Infrastructure consistent
✓ Terraform operational

---

# Escalation Conditions

Escalate immediately if:

* imports fail repeatedly
* resource IDs unclear
* mappings incorrect
* plan unsafe

Next recovery path:

* manual_recovery

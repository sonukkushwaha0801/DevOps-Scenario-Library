# Check Resource Status — Commands Reference

## Scenario

Terraform apply timed out or was interrupted before completion.

Actual resource creation status is unknown.

Goal:
Determine real infrastructure status before selecting recovery path.

---

# Recovery Priority

Primary recovery path.

Must be performed first.

Risk Level: Medium
Recovery Complexity: High

---

# Phase 1 — Stop Further Changes

## Step 1 — Freeze Apply Operations

Immediately stop:

* terraform apply retries
* CI/CD pipeline retries
* infrastructure automation

Category: EMERGENCY
Risk: SAFE

Purpose:
Prevent duplicate provisioning.

---

# Phase 2 — Check Terraform State

## Step 2 — Validate State

Run:

```bash id="crs-1"
terraform state list
```

Category: INVESTIGATIVE
Risk: SAFE

Expected:
State readable.

Check:

* resources tracked
* partial state updates
* missing resources

---

# Phase 3 — Audit Infrastructure

## Step 3 — Check Actual Resource Status

Check provider infrastructure.

Determine:

* resource not created
* resource still creating
* resource created successfully
* resource partially created

Examples:

* VM provisioning status
* cluster provisioning status
* database creation status

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Identify real infrastructure state.

---

# Phase 4 — Validate Terraform Plan

## Step 4 — Run Plan

```bash id="crs-2"
terraform plan
```

Category: INVESTIGATIVE
Risk: SAFE

Expected:
Plan reveals infrastructure delta.

Possible indicators:

* resource creation pending
* drift detected
* state mismatch

---

# Phase 5 — Select Recovery Path

Choose recovery path based on findings.

---

## Case 1 — Resource Not Created

Recovery Path:

```text id="case1"
retry_apply
```

---

## Case 2 — Resource Still Creating

Recovery Path:

```text id="case2"
wait_and_monitor
```

---

## Case 3 — Resource Created But Missing In State

Recovery Path:

```text id="case3"
import_missing_resources
```

---

## Case 4 — Partial Resource Creation

Recovery Path:

```text id="case4"
manual_recovery
```

---

# Recovery Success Criteria

✓ Resource status confirmed
✓ Infrastructure status known
✓ State status known
✓ Correct recovery path selected

---

# Escalation Conditions

Escalate immediately if:

* resource status unclear
* infrastructure unstable
* provider status unknown
* state inconsistent


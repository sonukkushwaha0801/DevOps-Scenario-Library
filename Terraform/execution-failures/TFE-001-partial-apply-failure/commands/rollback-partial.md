# Rollback Partial Infrastructure — Commands Reference

## Scenario

Terraform apply failed after partially creating infrastructure.

Partial resources must be removed to restore clean baseline.

Goal:
Safely rollback partially created infrastructure.

---

# Recovery Priority

Use when retry apply is unsafe.

Risk Level: HIGH
Recovery Complexity: HIGH

---

# Safe Rollback Conditions

Rollback preferred when:

* deployment must remain atomic
* partial infra unacceptable
* invalid configuration detected
* dependency chain broken

Unsafe rollback conditions:

* shared infrastructure involved
* production resources impacted
* dependencies unclear

---

# Phase 1 — Investigate Failure

## Step 1 — Review Apply Output

Identify:

* created resources
* failed resources
* shared dependencies

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Determine rollback scope.

---

## Step 2 — Validate State

Run:

```bash id="rbp-1"
terraform state list
```

Category: INVESTIGATIVE
Risk: SAFE

Expected:
State readable.

Failure Indicators:

* missing resources
* inconsistent state

---

# Phase 2 — Validate Rollback Safety

## Step 3 — Identify Rollback Candidates

Check:

* safe-to-destroy resources
* shared resources
* dependencies

Examples of safe rollback:

* newly created compute
* new subnet
* temporary storage

Examples of unsafe rollback:

* shared network
* shared IAM
* production DB

Category: INVESTIGATIVE
Risk: SAFE

---

# Phase 3 — Validate Destroy Plan

## Step 4 — Generate Destroy Plan

```bash id="rbp-2"
terraform plan -destroy
```

Category: INVESTIGATIVE
Risk: SAFE

Expected:
Only partial resources targeted.

PASS:
Rollback safe.

FAIL:

* shared resources targeted
* unexpected destroy scope

---

# Phase 4 — Rollback Partial Infrastructure

## Step 5 — Destroy Partial Resources

Option 1:

```bash id="rbp-3"
terraform destroy
```

Option 2 (preferred):

Target specific resources.

```bash id="rbp-4"
terraform destroy -target=<resource_name>
```

Category: RECOVERY
Risk: HIGH

Purpose:
Remove partial infrastructure.

Expected:
Partial resources removed.

Failure Indicators:

* destroy failures
* dependency errors
* unexpected impact

---

# Recovery Success Criteria

✓ Partial resources removed
✓ Infrastructure clean
✓ State consistent
✓ Safe baseline restored

---

# Escalation Conditions

Escalate immediately if:

* shared resources involved
* destroy unsafe
* state inconsistent
* rollback fails

Next recovery path:

* manual_recovery

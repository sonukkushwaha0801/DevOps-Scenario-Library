# Reject Drift — Commands Reference

## Scenario

Infrastructure change is invalid or unauthorized.

Goal:
Restore infrastructure to match Terraform code.

---

# Phase 1 — Detect Drift

## Command 1

```bash id="jlwm31"
terraform plan
```

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Identify drift.

Expected:
Terraform shows infrastructure differences.

---

# Phase 2 — Analyze Impact

Review carefully:

* Resource updates
* Resource recreation
* Resource destroy actions

Important:
Do NOT apply blindly.

---

# Phase 3 — Reconcile Infrastructure

## Command 2

```bash id="jlwm32"
terraform apply
```

Category: RECOVERY
Risk: HIGH

Purpose:
Revert infrastructure to desired state.

Expected:
Terraform restores infrastructure.

Failure Indicators:
Unexpected destroy operations.

---

# Phase 4 — Validate State

## Command 3

```bash id="jlwm33"
terraform state list
```

Category: SAFE
Risk: SAFE

Purpose:
Validate state consistency.

---

# Phase 5 — Verify Recovery

## Command 4

```bash id="jlwm34"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
No changes.

Success:
Infrastructure matches IaC.

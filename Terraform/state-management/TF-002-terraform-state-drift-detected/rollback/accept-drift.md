# Accept Drift — Rollback Procedure

## Purpose

Rollback IaC changes if accepting drift causes problems.

Examples:

* wrong infrastructure values committed
* invalid configuration introduced
* Terraform plan becomes unsafe

---

# Rollback Triggers

Start rollback if:

* unexpected plan changes appear
* invalid Terraform config introduced
* infrastructure policy violation detected

---

# Phase 1 — Stop Changes

Immediately stop:

* merge to main
* CI/CD deployments
* infrastructure updates

---

# Phase 2 — Revert Terraform Code

Restore previous known-good configuration.

Example:

```hcl id="jlwm43"
instance_type = "t2.micro"
```

Use:

* Git revert
* Git checkout
* previous commit restoration

---

# Phase 3 — Validate

```bash id="jlwm44"
terraform validate
```

Expected:
Valid configuration.

---

# Phase 4 — Verify

```bash id="jlwm45"
terraform plan
```

Expected:
Expected changes only.

---

# Success Criteria

✓ IaC restored
✓ Configuration valid
✓ Plan safe

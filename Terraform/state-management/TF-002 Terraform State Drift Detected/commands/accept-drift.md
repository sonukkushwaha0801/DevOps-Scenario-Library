# Accept Drift — Commands Reference

## Scenario

Infrastructure change is valid and approved.

Goal:
Update Terraform code to match actual infrastructure.

---

# Phase 1 — Detect Drift

## Command 1

```bash id="jlwm24"
terraform plan
```

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Identify drift.

Expected:
Terraform detects resource differences.

Failure Indicators:
Unexpected resource replacement.

---

# Phase 2 — Inspect Drift

## Command 2

```bash id="jlwm25"
terraform state list
```

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Inspect resources under Terraform management.

---

## Command 3

Provider-specific:
Inspect actual cloud resource configuration.

Examples:

* VM size
* Security rules
* Storage config

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Compare real infra with Terraform code.

---

# Phase 3 — Accept Drift

## Action

Update Terraform configuration manually.

Example:

Before:

```hcl id="jlwm26"
instance_type = "t2.micro"
```

After:

```hcl id="jlwm27"
instance_type = "t2.medium"
```

Purpose:
Make IaC reflect actual infrastructure.

---

# Phase 4 — Validate IaC

## Command 4

```bash id="jlwm28"
terraform fmt
```

Category: SAFE
Risk: SAFE

---

## Command 5

```bash id="jlwm29"
terraform validate
```

Category: SAFE
Risk: SAFE

---

# Phase 5 — Verify Drift Resolution

## Command 6

```bash id="jlwm30"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
No unexpected changes.

Success:
Drift resolved.

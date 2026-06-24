# Rebuild State — Commands Reference

## Scenario

Terraform state file is missing.

No healthy backup exists or backup restoration failed.

Goal:
Rebuild Terraform state from existing infrastructure.

---

# Recovery Priority

Last resort recovery path.

Risk Level: CRITICAL
Recovery Complexity: VERY HIGH

Estimated Recovery Time:
2–12 hours+

---

# Phase 1 — Emergency Containment

## Step 1 — Stop All Terraform Operations

Immediately stop:

* terraform processes
* CI/CD pipelines
* infrastructure automation

```bash id="tf004-rebuild-1"
ps aux | grep terraform
```

If needed:

```bash id="tf004-rebuild-2"
kill -9 <PID>
```

Category: EMERGENCY
Risk: SAFE

Purpose:
Prevent accidental infrastructure changes.

---

# Phase 2 — Validate Terraform Code

## Step 2 — Validate IaC

Run:

```bash id="tf004-rebuild-3"
terraform validate
```

Category: SAFE
Risk: SAFE

Expected:
Terraform configuration valid.

Important:
Rebuild only from correct Terraform code.

---

# Phase 3 — Discover Existing Infrastructure

## Step 3 — Inventory Resources

Identify all infrastructure:

* compute
* network
* storage
* IAM
* managed services

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Create complete infrastructure inventory.

Important:
Inventory must be complete.

---

# Phase 4 — Initialize State

## Step 4 — Prepare Clean State

```bash id="tf004-rebuild-4"
terraform init
```

Category: RECOVERY
Risk: HIGH

Purpose:
Initialize fresh Terraform state.

---

# Phase 5 — Import Resources

## Step 5 — Import Infrastructure

Example:

```bash id="tf004-rebuild-5"
terraform import <resource_name> <resource_id>
```

Example:

```bash id="tf004-rebuild-6"
terraform import aws_instance.web i-123456789
```

Category: RECOVERY
Risk: HIGH

Purpose:
Rebuild state by importing resources.

Important:
Import in dependency order.

Recommended order:

* networking
* security
* compute
* storage
* services

---

# Phase 6 — Validate State

## Step 6 — Check Imported Resources

```bash id="tf004-rebuild-7"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
Resources visible in state.

PASS:
Resources imported.

FAIL:
Missing resources.

---

# Phase 7 — Validate Plan Safety

## Step 7 — Run Terraform Plan

```bash id="tf004-rebuild-8"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
Predictable plan output.

PASS:
No dangerous changes.

FAIL:

* massive drift
* unexpected destroy
* unsafe replacements

---

# Recovery Success Criteria

✓ State rebuilt
✓ Resources imported
✓ State readable
✓ Terraform operational
✓ Infrastructure consistent

---

# Escalation Conditions

Escalate immediately if:

* inventory incomplete
* imports fail repeatedly
* dependencies broken
* plan unsafe

Required escalation:

* Senior DevOps Engineer
* Platform Engineer
* Incident Commander

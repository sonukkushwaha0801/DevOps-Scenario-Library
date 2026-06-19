# Rebuild State — Commands Reference

## Scenario

Terraform state is completely unusable.

No healthy backup exists and repair attempts failed.

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

```bash id="tf003-rebuild-1"
ps aux | grep terraform
```

If needed:

```bash id="tf003-rebuild-2"
kill -9 <PID>
```

Category: EMERGENCY
Risk: SAFE

Purpose:
Prevent infrastructure changes during rebuild.

---

# Phase 2 — Preserve Existing State Files

## Step 2 — Backup All Existing State Files

```bash id="tf003-rebuild-3"
cp terraform.tfstate terraform.tfstate.rebuild.backup
```

Category: SAFE
Risk: SAFE

Purpose:
Preserve all forensic evidence.

---

# Phase 3 — Validate Terraform Code

## Step 3 — Ensure IaC Is Correct

Run:

```bash id="tf003-rebuild-4"
terraform validate
```

Category: SAFE
Risk: SAFE

Expected:
Terraform configuration valid.

Failure Indicators:

* invalid config
* outdated IaC

Important:
Rebuild only from correct Terraform code.

---

# Phase 4 — Initialize Empty State

## Step 4 — Prepare Fresh State

Reinitialize backend if required.

```bash id="tf003-rebuild-5"
terraform init
```

Category: RECOVERY
Risk: HIGH

Purpose:
Prepare clean state environment.

---

# Phase 5 — Discover Existing Infrastructure

## Step 5 — Inventory Resources

Identify:

* compute resources
* networking
* storage
* IAM
* dependencies

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Create full resource inventory.

Important:
Inventory must be complete.

---

# Phase 6 — Import Resources

## Step 6 — Rebuild State Using Imports

Example:

```bash id="tf003-rebuild-6"
terraform import <resource_name> <resource_id>
```

Examples:

```bash id="tf003-rebuild-7"
terraform import aws_instance.web i-123456789
```

Category: RECOVERY
Risk: HIGH

Purpose:
Map existing infrastructure back into Terraform state.

Important:
Import in dependency order.

Examples:

* network first
* compute next
* dependent services later

---

# Phase 7 — Validate State

## Step 7 — Check Imported Resources

```bash id="tf003-rebuild-8"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
Resources visible in state.

Failure Indicators:

* missing resources
* incomplete imports

---

# Phase 8 — Validate Plan Safety

## Step 8 — Run Terraform Plan

```bash id="tf003-rebuild-9"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
Safe and predictable plan.

Failure Indicators:

* massive drift
* resource replacement
* unexpected destroy operations

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

* resource inventory incomplete
* imports fail repeatedly
* dependencies broken
* plan unsafe after rebuild

Required escalation:

* Senior DevOps Engineer
* Platform Engineering
* Incident Commander

# Repair State — Commands Reference

## Scenario

Terraform state is corrupted and no valid backup is available.

Goal:
Repair state manually or using Terraform state operations.

---

# Recovery Priority

Use only if:

* no healthy backup exists
* backup restoration failed

Risk Level: HIGH
Recovery Complexity: HIGH

---

# Phase 1 — Emergency Containment

## Step 1 — Stop All Terraform Operations

Immediately stop:

* terraform processes
* CI/CD pipelines
* infrastructure jobs

```bash id="tf003-repair-1"
ps aux | grep terraform
```

If needed:

```bash id="tf003-repair-2"
kill -9 <PID>
```

Category: EMERGENCY
Risk: SAFE

Purpose:
Prevent further corruption.

---

# Phase 2 — Backup Corrupted State

## Step 2 — Create Recovery Copy

Never repair original file directly.

```bash id="tf003-repair-3"
cp terraform.tfstate terraform.tfstate.repair
```

Category: SAFE
Risk: SAFE

Purpose:
Preserve original corrupted state.

---

# Phase 3 — Diagnose Corruption Type

## Step 3 — Inspect State File

Example:

```bash id="tf003-repair-4"
cat terraform.tfstate
```

Or:

```bash id="tf003-repair-5"
jq . terraform.tfstate
```

Category: INVESTIGATIVE
Risk: SAFE

Identify:

* broken JSON
* invalid format
* missing resources
* metadata corruption

---

# Phase 4 — Repair State

## Repair Option 1 — Fix JSON Structure

Examples:

* missing braces
* invalid commas
* malformed objects

Tools:

* editor
* jq validator

Risk: HIGH

---

## Repair Option 2 — Fix Metadata

Examples:

* serial
* lineage
* terraform version

Risk: HIGH

---

## Repair Option 3 — Remove Corrupted Resources

Example:

```bash id="tf003-repair-6"
terraform state rm <resource_name>
```

Category: RECOVERY
Risk: HIGH

Purpose:
Remove invalid resource mappings.

---

## Repair Option 4 — Re-import Resources

Example:

```bash id="tf003-repair-7"
terraform import <resource_name> <resource_id>
```

Category: RECOVERY
Risk: HIGH

Purpose:
Rebuild missing resource mapping.

---

# Phase 5 — Validate State

## Step 5 — Check State Accessibility

```bash id="tf003-repair-8"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable.

Failure Indicators:

* parse errors remain
* state inaccessible

---

# Phase 6 — Validate Plan Safety

## Step 6 — Run Terraform Plan

```bash id="tf003-repair-9"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
Safe and predictable plan.

Failure Indicators:

* massive drift
* unexpected destroys
* invalid resource mapping

---

# Recovery Success Criteria

✓ State repaired
✓ State readable
✓ Resources mapped correctly
✓ Terraform operational

---

# Escalation Conditions

Escalate immediately if:

* repair fails
* state remains unreadable
* plan unsafe
* corruption too severe

Next recovery path:

* rebuild_state

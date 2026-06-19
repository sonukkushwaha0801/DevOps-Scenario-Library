# TF-004 — Terraform State File Missing

## Scenario Overview

Terraform state file is missing locally or from remote backend storage.

Terraform loses infrastructure awareness.

Terraform depends on state to understand:

* existing resources
* infrastructure mappings
* dependencies
* required changes

When state is missing, Terraform assumes infrastructure does not exist.

---

## Severity

* Priority: P0 / P1
* Category: State Management
* Recovery Complexity: Critical
* Estimated Recovery Time: 1–8 hours

---

# Core Problem

Terraform state is the source of infrastructure truth.

If state is missing:

* terraform plan becomes dangerous
* terraform apply becomes unsafe
* resource duplication risk increases

Critical rule:

Do not perform infrastructure changes until state availability is restored.

---

# Common Symptoms

* terraform state commands fail
* backend state object missing
* state file missing
* terraform plan wants to recreate everything

---

# Common Errors

Typical error messages:

```text id="tf004-errors"
No state file found
Failed to load state
State snapshot not found
Backend object missing
```

---

# Scenario Matching

Use this scenario if:

✓ Terraform state file missing
✓ Backend state object missing
✓ Terraform loses resource awareness
✓ Plan wants to recreate infrastructure

---

# Common Root Causes

* accidental deletion
* backend object deletion
* storage cleanup
* failed migration
* wrong backend configuration
* human error

---

# Missing State Types

Terraform missing state usually falls into one of these categories.

---

## 1. Local State Missing

Examples:

* deleted terraform.tfstate
* local filesystem cleanup

---

## 2. Remote State Missing

Examples:

* deleted backend object
* storage failure

---

## 3. Backend Configuration Mismatch

Examples:

* wrong key
* wrong bucket/container
* wrong backend path

---

## 4. Migration Failure

Examples:

* partial migration
* missing migrated state

---

# Incident Workflow

Missing state recovery requires structured decision-making.

```text id="tf004-flow"
Missing State Detected
        ↓
Assess State Availability
        ↓
Check Backup Availability
        ↓
Select Recovery Path
```

---

# Recovery Decision Tree

TF-004 has two recovery paths.

```text id="tf004-tree"
Missing State Detected
        ↓
Backup Available?
     /           \
   YES           NO
    |             |
Restore Backup  Rebuild State
```

---

# Recovery Path 1 — Restore Backup

Preferred recovery path.

Use when:

* healthy backup exists

Goal:
Restore missing state.

Flow:

```text id="tf004-r1"
Restore Backup
→ Validate State
→ Validate Plan
```

Risk:
Medium

Best recovery option.

---

# Recovery Path 2 — Rebuild State

Use when:

* backup unavailable
* restore failed

Goal:
Rebuild Terraform state from infrastructure.

Flow:

```text id="tf004-r2"
Inventory Resources
→ Import Resources
→ Validate State
```

Risk:
Critical

---

# Recovery Priority

Always follow this order:

```text id="tf004-priority"
1. Restore Backup
2. Rebuild State
```

Never rebuild if valid backup exists.

---

# Important Safety Rules

Never blindly run:

```bash id="tf004-safe"
terraform apply
```

During active missing state incident.

Risk:

* duplicate infrastructure
* resource conflicts
* destructive changes
* outages

---

# Investigation Workflow

Step 1 — Check state accessibility

```bash id="tf004-step1"
terraform state list
```

Step 2 — Validate backend configuration

Step 3 — Check backup availability

Step 4 — Select recovery path

---

# Scenario Files

| File          | Purpose                              |
| ------------- | ------------------------------------ |
| metadata.yaml | Scenario discovery engine            |
| commands/     | Recovery procedures                  |
| rollback/     | Recovery rollback                    |
| verification/ | Recovery validation                  |
| references.md | State concepts and recovery guidance |

---

# Scripts

| Script                   | Purpose                  |
| ------------------------ | ------------------------ |
| detect-missing-state.sh  | Detect missing state     |
| restore-state.sh         | Restore state backup     |
| validate-state.sh        | Validate state           |
| state-recovery-report.sh | Generate recovery report |

---

# Labs

Provider-specific labs:

* Generic
* AWS
* Azure
* GCP
* On-Prem

Each lab includes:

* missing state simulation
* restore backup workflow
* rebuild workflow

---

# Exit Criteria

Incident resolved only when:

✓ State available
✓ Resource mappings correct
✓ Terraform operational
✓ Infrastructure consistent
✓ No active incident

---

# Related Scenarios

* TF-001 Terraform State Lock Not Released
* TF-002 Terraform State Drift Detected
* TF-003 Terraform State Corruption
* TF-034 Partial Apply Failure

# TFSM-003 — Terraform State Corruption

## Scenario Overview

Terraform state is corrupted, inconsistent, incomplete, or unreadable.

State corruption prevents Terraform from safely managing infrastructure.

Terraform depends on state to understand:

* existing resources
* infrastructure mapping
* dependencies
* required changes

When state is corrupted, Terraform loses infrastructure awareness.

---

## Severity

* Priority: P0 / P1
* Category: State Management
* Recovery Complexity: Critical
* Estimated Recovery Time: 1–6 hours

---

# Core Problem

Terraform state is the source of infrastructure truth.

If state becomes corrupted:

* terraform plan becomes unreliable
* terraform apply becomes dangerous
* resource mapping may break

Critical rule:

Do not perform infrastructure changes until state integrity is restored.

---

# Common Symptoms

* terraform state commands fail
* terraform plan behaves unpredictably
* terraform apply unsafe
* resources missing from state
* unexpected resource recreation

---

# Common Errors

Typical error messages:

```text id="tf003-err"
Failed to load state
Unsupported state format
State file corrupted
Invalid state file
JSON parse error
```

---

# Scenario Matching

Use this scenario if:

✓ Terraform cannot read state
✓ State commands fail
✓ State file corrupted or invalid
✓ Resource mappings missing

---

# Common Root Causes

* interrupted state write
* backend corruption
* manual state edits
* failed migration
* failed recovery attempt
* storage corruption

---

# Common Corruption Types

Terraform state corruption usually falls into one of these categories:

---

## 1. State File Corruption

Examples:

* broken JSON
* invalid format
* truncated state

---

## 2. Partial Resource Corruption

Examples:

* missing resources
* incomplete mappings

---

## 3. Backend Corruption

Examples:

* backend storage failure
* inconsistent remote state

---

## 4. Metadata Corruption

Examples:

* invalid serial
* broken lineage
* version mismatch

---

# Incident Workflow

State corruption recovery requires structured decision-making.

```text id="tf003-flow"
State Corruption Detected
        ↓
Assess Severity
        ↓
Check Backup Availability
        ↓
Select Recovery Path
```

---

# Recovery Decision Tree

TFSM-003 has three recovery paths.

```text id="tf003-tree"
State Corruption Detected
        ↓
Backup Available?
     /           \
   YES           NO
    |             |
Restore Backup  Repair State
                    ↓
             Repair Successful?
                /      \
              YES      NO
               |        |
            Validate  Rebuild State
```

---

# Recovery Path 1 — Restore Backup

Preferred recovery path.

Use when:

* healthy backup exists

Goal:
Restore last known healthy state.

Flow:

```text id="tf003-r1"
Restore Backup
→ Validate State
→ Validate Plan
```

Risk:
Medium

Best recovery option.

---

# Recovery Path 2 — Repair State

Use when:

* backup unavailable
* corruption limited

Goal:
Repair corrupted state manually.

Flow:

```text id="tf003-r2"
Repair State
→ Validate Structure
→ Validate Mapping
```

Risk:
High

---

# Recovery Path 3 — Rebuild State

Use when:

* backup unavailable
* repair failed
* corruption severe

Goal:
Rebuild Terraform state from infrastructure.

Flow:

```text id="tf003-r3"
Inventory Resources
→ Import Resources
→ Validate State
```

Risk:
Critical

---

# Recovery Priority

Always follow this order:

```text id="tf003-priority"
1. Restore Backup
2. Repair State
3. Rebuild State
```

Never start with rebuild unless necessary.

---

# Important Safety Rules

Never blindly run:

```bash id="tf003-safe"
terraform apply
```

During active state corruption.

Risk:

* infra destruction
* massive drift
* resource recreation
* outages

---

# Investigation Workflow

Step 1 — Check state accessibility

```bash id="tf003-step1"
terraform state list
```

Step 2 — Inspect state

```bash id="tf003-step2"
terraform show
```

Step 3 — Validate plan

```bash id="tf003-step3"
terraform plan
```

Step 4 — Select recovery path

---

# Scenario Files

| File          | Purpose                               |
| ------------- | ------------------------------------- |
| metadata.yaml | Scenario discovery engine             |
| commands/     | Recovery procedures                   |
| rollback/     | Recovery rollback                     |
| verification/ | Recovery validation                   |
| references.md | State internals and recovery concepts |

---

# Scripts

| Script                     | Purpose                |
| -------------------------- | ---------------------- |
| detect-state-corruption.sh | Detect corruption      |
| backup-state.sh            | Backup state           |
| restore-state.sh           | Restore backup         |
| validate-state.sh          | Validate state         |
| state-health-report.sh     | Generate health report |

---

# Labs

Provider-specific labs:

* Generic
* AWS
* Azure
* GCP
* On-Prem

Each lab includes:

* corruption simulation
* restore backup workflow
* repair workflow
* rebuild workflow

---

# Exit Criteria

Incident resolved only when:

✓ State readable
✓ State consistent
✓ Resource mapping correct
✓ Terraform operational
✓ Infrastructure safe

---

# Related Scenarios

* TFSM-001 Terraform State Lock Not Released
* TFSM-002 Terraform State Drift Detected
* TFSM-004 Terraform State Missing
* TFSM-034 Partial Apply Failure

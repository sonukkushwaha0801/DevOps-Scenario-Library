# TFSM-002 — Terraform State Drift Detected

## Scenario Overview

Terraform state no longer matches actual infrastructure.

Drift occurs when infrastructure changes outside Terraform, creating mismatch between:

* Terraform code (desired state)
* Terraform state
* Real infrastructure

---

## Severity

* Priority: P1 / P2
* Category: State Management
* Recovery Complexity: High
* Estimated Recovery Time: 30–120 minutes

---

# Core Problem

Drift itself is not the actual problem.

The real problem is uncertainty about source of truth.

Critical question:

Which should win?

* Infrastructure?
  OR
* Terraform IaC?

---

## Common Symptoms

* Unexpected terraform plan changes
* Unexpected resource updates
* Unexpected resource recreation
* Infrastructure behavior differs from IaC
* Drift alerts triggered

---

## Common Indicators

Terraform often shows no explicit error.

Drift is usually detected through:

```bash
terraform plan
```

Example drift indicators:

```diff
~ instance_type = "t2.micro" -> "t2.medium"
```

```diff
-/+ resource must be replaced
```

---

# Scenario Matching

Use this scenario if:

✓ Terraform detects unexpected infrastructure changes
✓ Infrastructure differs from Terraform configuration
✓ Manual changes may have occurred outside Terraform
✓ Drift detection alert triggered

---

# Common Root Causes

* Manual infrastructure changes
* Cloud console modifications
* External automation changes
* Emergency production hotfixes
* Resource deletion outside Terraform
* Policy enforcement systems

---

# Incident Workflow

Drift detection requires investigation before action.

```text
Drift Detected
      ↓
Investigate Drift
      ↓
Identify Change Source
      ↓
Was Change Approved?
```

---

# Decision Tree

This scenario has two recovery paths.

```text
                Drift Detected
                      ↓
              Was change approved?
                /             \
              YES             NO
               |               |
        Accept Drift      Reject Drift
               |               |
        Update IaC        Restore Infra
```

---

# Recovery Path 1 — Accept Drift

Use when:

* Manual change is approved
* Infrastructure is correct
* Terraform code is outdated

Goal:
Update Terraform code to match real infrastructure.

Flow:

```text
Infrastructure wins
→ Update IaC
→ Validate
→ Verify
```

Files:

* commands/accept-drift.md
* rollback/accept-drift.md
* verification/accept-drift.md

---

# Recovery Path 2 — Reject Drift

Use when:

* Manual change is unauthorized
* Terraform code is correct
* Infrastructure changed unexpectedly

Goal:
Restore infrastructure to Terraform desired state.

Flow:

```text
IaC wins
→ Reconcile Infrastructure
→ Validate
→ Verify
```

Files:

* commands/reject-drift.md
* rollback/reject-drift.md
* verification/reject-drift.md

---

# Important Safety Rules

Never blindly run:

```bash
terraform apply
```

Without understanding:

* what changed
* who changed it
* why it changed
* impact of reverting

Risk:

* service disruption
* production outage
* unintended resource replacement

---

# Investigation Workflow

Step 1 — Detect Drift

```bash
terraform plan
```

Step 2 — Inspect State

```bash
terraform state list
```

Step 3 — Compare:

* Terraform code
* Terraform state
* Actual infrastructure

Step 4 — Decide Recovery Path

---

# Scenario Files

| File          | Purpose                   |
| ------------- | ------------------------- |
| metadata.yaml | Scenario discovery engine |
| commands/     | Recovery commands         |
| rollback/     | Recovery rollback         |
| verification/ | Recovery validation       |
| references.md | Docs and best practices   |

---

# Scripts

| Script          | Purpose               |
| --------------- | --------------------- |
| detect-drift.sh | Detect drift          |
| accept-drift.sh | Accept drift workflow |
| reject-drift.sh | Reject drift workflow |
| drift-report.sh | Generate drift report |

---

# Labs

Provider-specific labs:

* Generic
* AWS
* Azure
* GCP
* On-Prem

Each lab includes:

* Drift simulation
* Accept drift workflow
* Reject drift workflow

---

# Exit Criteria

Incident is resolved only when:

✓ Drift resolved
✓ Source of truth restored
✓ Terraform plan clean
✓ Infrastructure stable
✓ No active incident

---

# Related Scenarios

* TFSM-001 Terraform State Lock Not Released
* TFSM-003 Terraform State Corruption
* TFSM-034 Partial Apply Failure

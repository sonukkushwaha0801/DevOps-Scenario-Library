# TFE-002 — Terraform Apply Timeout

## Scenario Overview

Terraform apply timed out or was interrupted before infrastructure provisioning completed.

This creates one of the most dangerous Terraform execution failure scenarios because Terraform execution may stop while provider-side resource provisioning continues.

Result:
Infrastructure state becomes uncertain.

---

## Severity

* Severity: P0
* Priority: Critical
* Domain: Execution Failures
* Scenario ID: TF-EF-002

---

## Incident Summary

Typical execution flow:

```text id="eg2ek8"
terraform apply starts
↓
long-running resource provisioning begins
↓
apply times out / interrupted
↓
resource state becomes uncertain
```

Example:

```text id="mjzzvj"
✓ VPC created
✓ Subnets created
⏳ EKS provisioning started
✗ Apply interrupted
```

Critical uncertainty:

```text id="m0hksw"
Did resource creation finish?
Did provider continue processing?
Did state update?
```

---

## Common Symptoms

* terraform apply hanging
* apply timeout exceeded
* context deadline exceeded
* pipeline timeout
* interrupted apply

---

## Common Causes

* long-running resource provisioning
* CI/CD timeout
* provider timeout
* network instability
* API throttling
* CLI interruption

---

## Recovery Decision Flow

Apply timeout detected.

First question:

```text id="vylk3p"
What is actual resource state?
```

Recovery depends on this answer.

---

## Recovery Paths

### 1. Check Resource Status

Mandatory first recovery step.

Use to determine actual resource state.

---

### 2. Retry Apply

Use when resource was not created.

---

### 3. Import Missing Resources

Use when resource exists but state is missing.

---

### 4. Manual Recovery

Use when automated recovery is unsafe.

Highest-risk recovery path.

---

## Repository Structure

```bash id="5vl9fp"
TFE-002-terraform-apply-timeout/
├── README.md
├── metadata.yaml
├── references.md
│
├── commands/
│   ├── check-resource-status.md
│   ├── retry-apply.md
│   ├── import-missing-resources.md
│   └── manual-recovery.md
│
├── rollback/
│   ├── check-resource-status.md
│   ├── retry-apply.md
│   ├── import-missing-resources.md
│   └── manual-recovery.md
│
├── verification/
│   ├── check-resource-status.md
│   ├── retry-apply.md
│   ├── import-missing-resources.md
│   └── manual-recovery.md
│
├── scripts/
│   ├── detect-apply-timeout.sh
│   ├── check-resource-status.sh
│   ├── validate-state.sh
│   └── timeout-recovery-report.sh
│
├── diagrams/
│   ├── scenario-overview.webp
│   ├── timeout-flow.webp
│   └── recovery-decision-flow.webp
│
└── lab/
    ├── aws/
    ├── azure/
    ├── gcp/
    ├── generic/
    └── on-prem/
```

---

## Lab Environments

This scenario includes provider-specific and generic labs.

### AWS

Simulates:

* VPC created
* Subnets created
* EKS provisioning started
* apply interrupted

---

### Azure

Simulates:

* Resource Group created
* VNet created
* Subnets created
* AKS provisioning started
* apply interrupted

---

### GCP

Simulates:

* Network created
* Subnet created
* Firewall created
* GKE provisioning started
* apply interrupted

---

### Generic

Simulates:

* resource 1 created
* resource 2 created
* long-running operation interrupted

---

### On-Prem

Simulates:

* network provisioned
* storage provisioned
* VM provisioning interrupted

---

## Investigation Priorities

When TFE-002 occurs:

1. Stop retries
2. Check resource status
3. Validate Terraform state
4. Assess infrastructure impact
5. Select safest recovery path

---

## Key Lessons

Never blindly rerun:

```bash id="tmrvsi"
terraform apply
```

Always determine:

* resource state
* provider state
* Terraform state
* infrastructure consistency

Critical rule:

```text id="k5h7s6"
Unknown resource state must be resolved before recovery begins.
```

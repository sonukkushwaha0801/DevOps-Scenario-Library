# TFE-001 — Partial Apply Failure

## Scenario Overview

Terraform apply failed after partially creating or modifying infrastructure.

Some resources were created successfully while others failed, leaving infrastructure in a partially provisioned and potentially inconsistent state.

This is one of the most critical Terraform execution failure scenarios because both infrastructure and Terraform state may become inconsistent.

---

## Severity

* Severity: P0
* Priority: Critical
* Domain: Execution Failures
* Scenario ID: TF-EF-001

---

## Incident Summary

Typical execution flow:

```text
terraform apply starts
↓
resources created incrementally
↓
resource creation fails
↓
apply exits with error
```

Example:

```text
✓ VPC created
✓ Subnet created
✓ Security Group created
✗ EC2 creation failed
```

Result:

* partial infrastructure exists
* deployment incomplete
* state may be inconsistent
* dependencies may be broken

---

## Common Symptoms

* terraform apply failed midway
* partial infrastructure exists
* deployment incomplete
* resource dependency failures
* inconsistent infrastructure state

---

## Common Causes

* API throttling
* quota exceeded
* provider outage
* permission denied
* network timeout
* invalid configuration
* dependency failures

---

## Recovery Decision Flow

Partial Apply Failure detected.

Recovery depends on current infrastructure and Terraform state.

### Recovery Paths

#### 1. Retry Apply

Use when failure is temporary.

Examples:

* API timeout
* transient provider outage

---

#### 2. Rollback Partial

Use when partial infrastructure must be removed.

Examples:

* deployment must remain clean
* invalid configuration detected

---

#### 3. Import Missing Resources

Use when resources exist but are missing from Terraform state.

---

#### 4. Manual Recovery

Use when automated recovery is unsafe.

Highest-risk recovery path.

---

## Repository Structure

```bash
TFE-001-partial-apply-failure/
├── README.md
├── metadata.yaml
├── references.md
│
├── commands/
│   ├── retry-apply.md
│   ├── rollback-partial.md
│   ├── import-missing-resources.md
│   └── manual-recovery.md
│
├── rollback/
│   ├── retry-apply.md
│   ├── rollback-partial.md
│   ├── import-missing-resources.md
│   └── manual-recovery.md
│
├── verification/
│   ├── retry-apply.md
│   ├── rollback-partial.md
│   ├── import-missing-resources.md
│   └── manual-recovery.md
│
├── scripts/
│   ├── detect-partial-apply.sh
│   ├── resource-diff-report.sh
│   ├── validate-state.sh
│   └── apply-recovery-report.sh
│
├── diagrams/
│   ├── scenario-overview.webp
│   ├── failure-flow.webp
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
* Subnet created
* Security Group created
* EC2 creation failure

---

### Azure

Simulates:

* Resource Group created
* VNet created
* Subnet created
* VM creation failure

---

### GCP

Simulates:

* Network created
* Subnet created
* Firewall created
* VM creation failure

---

### Generic

Simulates:

* resource 1 created
* resource 2 created
* resource 3 failed

---

### On-Prem

Simulates:

* network provisioned
* storage provisioned
* VM provisioning failure

---

## Investigation Priorities

When TFE-001 occurs:

1. Identify created resources
2. Identify failed resources
3. Validate Terraform state
4. Assess infrastructure impact
5. Select safest recovery path

---

## Key Lessons

Never blindly rerun:

```bash
terraform apply
```

Always determine:

* what succeeded
* what failed
* state consistency
* infrastructure consistency

Critical rule:

Restore infrastructure consistency before resuming normal Terraform operations.

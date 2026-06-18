# TF-002 — References

---

# Purpose

This document contains official documentation, drift detection concepts, and best practices related to Terraform state drift.

Use this for:

* deeper technical understanding
* root cause analysis
* drift resolution strategy
* prevention improvements

This file is not part of active incident execution.

---

# 1. Terraform Official Documentation

## Terraform State

Purpose:
Understand Terraform state architecture and state management.

Key Concepts:

* resource mapping
* state tracking
* infrastructure synchronization

Official Documentation:

* Terraform State Documentation

---

## Terraform Plan

Purpose:
Understand how Terraform detects infrastructure drift.

Key Concepts:

* desired state
* actual state
* planned changes

Official Documentation:

* Terraform Plan Documentation

---

## Terraform Refresh

Purpose:
Understand state refresh and reconciliation.

Key Concepts:

* infrastructure read
* state synchronization
* drift detection

Official Documentation:

* Terraform Refresh Documentation

---

# 2. What is Drift?

Drift occurs when actual infrastructure differs from Terraform configuration or state.

Example:

Terraform expects:

```hcl id="jlwm63"
instance_type = "t2.micro"
```

Actual infrastructure:

```text id="jlwm64"
instance_type = "t2.medium"
```

Result:
Drift detected.

---

# 3. Common Drift Sources

Most drift originates from:

* manual infrastructure changes
* cloud console updates
* emergency production fixes
* external automation
* policy enforcement systems
* resource deletion outside Terraform

---

# 4. Drift Detection Methods

Common detection approaches:

---

## Method 1 — terraform plan

Most common.

```bash id="jlwm65"
terraform plan
```

Best for:

* manual investigation
* pre-deployment checks

---

## Method 2 — Scheduled Drift Detection

Examples:

* CI/CD pipelines
* scheduled plan runs
* compliance scans

Best for:

* production monitoring

---

## Method 3 — Policy & Compliance Tools

Examples:

* security scanners
* governance tools
* compliance automation

Best for:

* enterprise environments

---

# 5. Drift Resolution Strategies

There are only two valid strategies.

---

## Strategy 1 — Accept Drift

Use when:

* manual change approved
* infrastructure is correct
* IaC outdated

Action:
Update Terraform code.

Flow:

```text id="jlwm66"
Infrastructure wins
→ Update IaC
→ Validate
→ Verify
```

---

## Strategy 2 — Reject Drift

Use when:

* manual change unauthorized
* IaC is source of truth

Action:
Revert infrastructure.

Flow:

```text id="jlwm67"
IaC wins
→ Reconcile infrastructure
→ Validate
→ Verify
```

---

# 6. Best Practices

Recommended controls:

---

## Prevent Manual Changes

Best practice:
Restrict direct infrastructure changes.

Use:

* RBAC
* policy controls
* approvals

---

## Run Regular Drift Checks

Recommended:

* daily plan runs
* automated alerts
* compliance checks

---

## Maintain Single Source of Truth

Critical rule:

Terraform is reliable only when source of truth is clear.

Never allow:

* mixed ownership
* unmanaged infrastructure changes

---

# Key Lessons

Drift itself is not the problem.

The real problem is uncertainty about source of truth.

Critical question:
Which should win?

* Infrastructure?
  OR
* IaC?

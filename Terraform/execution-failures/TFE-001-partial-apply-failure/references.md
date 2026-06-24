# TFE-001 — References

---

# Purpose

This document contains technical references, execution failure concepts, partial apply behavior, recovery strategies, and best practices related to Terraform partial apply failures.

Use this for:

* deeper technical understanding
* root cause analysis
* recovery planning
* prevention improvements

This file is not part of active incident execution.

---

# 1. Terraform Apply Lifecycle

Terraform apply typically follows this workflow:

```text
Plan
→ Dependency Resolution
→ Resource Creation / Modification
→ State Update
→ Completion
```

Terraform executes infrastructure changes incrementally.

Resources are created or modified step by step.

---

# 2. Why Partial Apply Failures Are Dangerous

Terraform apply can fail after some resources have already been created.

Example:

* VPC created
* Subnet created
* Security Group created
* EC2 creation failed

Result:

```text
Desired State ≠ Terraform State ≠ Real Infrastructure
```

This creates infrastructure inconsistency.

---

# 3. Common Causes of Partial Apply Failure

Most common causes:

* API throttling
* quota exceeded
* provider outage
* permission denied
* network timeout
* dependency failures
* invalid configuration

Examples:

* invalid AMI
* invalid VM size
* missing permissions
* cloud service instability

---

# 4. Common Symptoms

Typical indicators:

* terraform apply failed midway
* partial infrastructure exists
* deployment incomplete
* dependencies broken
* service instability

---

# 5. Common Errors

Common error messages:

* Error applying plan
* Request timeout
* Quota exceeded
* Permission denied
* Resource creation failed

---

# 6. Recovery Strategies

TFE-001 has four recovery paths.

---

## Strategy 1 — Retry Apply

Preferred recovery path for transient failures.

Use when:

* failure is temporary
* infrastructure stable
* state healthy

Flow:

```text
Retry Apply
→ Validate
```

Risk:
Medium

---

## Strategy 2 — Rollback Partial

Destroy partially created resources.

Use when:

* partial infra unacceptable
* deployment must remain clean

Flow:

```text
Destroy Partial Infra
→ Validate Cleanup
```

Risk:
High

---

## Strategy 3 — Import Missing Resources

Use when:

* resources exist in cloud
* Terraform does not track them

Flow:

```text
Import Resources
→ Validate State
```

Risk:
High

---

## Strategy 4 — Manual Recovery

Last-resort recovery path.

Use when:

* automated recovery unsafe
* infrastructure heavily inconsistent

Flow:

```text
Manual Recovery
→ Validate
```

Risk:
Critical

---

# 7. Recovery Priority

Recommended order:

```text
Retry Apply
→ Rollback Partial
→ Import Missing Resources
→ Manual Recovery
```

Recovery path depends on incident state.

No universal path.

---

# 8. Useful Commands

Check state:

```bash
terraform state list
```

Inspect state:

```bash
terraform show
```

Validate plan:

```bash
terraform plan
```

Destroy resources:

```bash
terraform destroy
```

Import resources:

```bash
terraform import <resource_name> <resource_id>
```

---

# 9. Best Practices

---

## Validate Before Retrying

Never blindly rerun:

```bash
terraform apply
```

Always investigate first.

---

## Understand Resource Dependencies

Partial failures often impact dependency chains.

Examples:

* networking
* IAM
* load balancers
* compute

---

## Validate State Frequently

Always validate:

* state accessibility
* state consistency
* state accuracy

---

## Prefer Controlled Recovery

Recovery should minimize:

* blast radius
* downtime
* state inconsistency

---

# Key Lessons

Terraform apply success is not guaranteed after execution starts.

Partial apply failures can create:

* infrastructure inconsistency
* state inconsistency
* operational instability

Critical rule:

Restore infrastructure consistency before resuming normal operations.

# TFE-002 — References

---

# Purpose

This document contains technical references, timeout behavior concepts, async provider execution behavior, recovery strategies, and operational best practices related to Terraform apply timeout incidents.

Use this for:

* deeper technical understanding
* timeout incident investigation
* recovery planning
* prevention improvements

This file is not part of active incident execution.

---

# 1. Terraform Apply Lifecycle

Terraform apply typically follows this workflow:

```text
Plan
→ Dependency Resolution
→ Resource Creation
→ State Update
→ Completion
```

Terraform executes infrastructure changes incrementally.

But some resources are long-running.

Examples:

* Kubernetes clusters
* databases
* networking appliances

---

# 2. Why Apply Timeouts Are Dangerous

Timeout does not always mean failure.

Important:

```text
Terraform stopped
≠
Provider stopped
```

Provider may continue processing after Terraform exits.

This creates uncertainty.

---

# 3. Common Timeout Sources

Common timeout sources:

* CLI interruption
* CI/CD timeout
* network timeout
* provider API timeout
* long-running resources

Examples:

* EKS cluster provisioning
* AKS provisioning
* GKE provisioning
* database provisioning

---

# 4. Common Resource States After Timeout

Possible states:

---

## State 1 — Resource Not Created

Safe path:

```text
Retry Apply
```

---

## State 2 — Resource Still Creating

Safe path:

```text
Wait and Monitor
```

---

## State 3 — Resource Created

Safe path:

```text
Import Missing Resources
```

---

## State 4 — Partial Resource Created

Safe path:

```text
Manual Recovery
```

---

# 5. Common Symptoms

Typical indicators:

* terraform apply hanging
* apply timeout exceeded
* context deadline exceeded
* pipeline timeout
* interrupted apply

---

# 6. Common Errors

Typical errors:

* timeout exceeded
* request timeout
* context deadline exceeded
* operation interrupted
* signal killed

---

# 7. Recovery Strategies

TFE-002 has four recovery paths.

---

## Strategy 1 — Check Resource Status

Mandatory first step.

Flow:

```text
Check Resource Status
→ Determine Actual State
```

Risk:
Medium

---

## Strategy 2 — Retry Apply

Use only when resource not created.

Risk:
High

---

## Strategy 3 — Import Missing Resources

Use when resource created but state missing.

Risk:
Critical

---

## Strategy 4 — Manual Recovery

Use when resource state unclear or partially created.

Risk:
Critical+

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

Import resource:

```bash
terraform import <resource_name> <resource_id>
```

---

# 9. Best Practices

---

## Never Blindly Retry Apply

Always check:

* actual resource state
* provider state
* Terraform state

---

## Long-Running Resources Need Extra Caution

Examples:

* Kubernetes clusters
* managed databases
* large network deployments

These commonly trigger timeout incidents.

---

## Validate Provider-Side State

Terraform alone may not reveal true resource state.

Provider validation is mandatory.

---

## Prefer Safe Recovery Over Fast Recovery

Speed without certainty increases risk.

Always reduce ambiguity first.

---

# Key Lessons

Timeout incidents are not simple failures.

They are uncertainty incidents.

Critical rule:

```text
Unknown resource state must be resolved before recovery begins.
```

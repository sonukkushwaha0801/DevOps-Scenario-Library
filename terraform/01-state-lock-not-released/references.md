# TF-001 — References

## Purpose

This document contains authoritative references used during investigation, recovery, rollback, and verification of Terraform state lock incidents.

Use these references for:

* Vendor validation
* Version-specific behavior
* Backend implementation details
* Advanced troubleshooting
* Recovery confirmation

---

# Official Documentation

## Terraform State Locking

Terraform uses state locking to prevent multiple writers from modifying the same state simultaneously. State locking behavior depends on the configured backend. Terraform provides a force-unlock mechanism for recovery when automatic unlock fails.

Reference:

[Terraform State Locking Documentation](https://developer.hashicorp.com/terraform/language/state/locking?utm_source=chatgpt.com)

---

## Terraform Force Unlock

The `terraform force-unlock` command removes a lock from the current state without modifying infrastructure resources. Use only after verifying that no active Terraform operation is running.

Reference:

[Terraform Force Unlock Command Reference](https://developer.hashicorp.com/terraform/cli/commands/force-unlock?utm_source=chatgpt.com)

---

## Terraform S3 Backend

The S3 backend supports state locking. Recent Terraform versions support native S3 locking while older deployments commonly use DynamoDB-based locking. DynamoDB locking is being deprecated in future releases.

Reference:

[Terraform S3 Backend Documentation](https://developer.hashicorp.com/terraform/language/backend/s3?utm_source=chatgpt.com)

---

# AWS References

## DynamoDB State Locking

DynamoDB lock tables are commonly used to prevent concurrent Terraform state modifications when using an S3 backend. Lock records contain ownership and operation metadata used during investigations.

Reference:

[AWS DynamoDB Documentation](https://docs.aws.amazon.com/dynamodb/?utm_source=chatgpt.com)

---

## CloudTrail Investigation

Use CloudTrail when investigating:

* Lock deletion events
* Force unlock actions
* Unexpected backend modifications

Reference:

[AWS CloudTrail Documentation](https://docs.aws.amazon.com/cloudtrail/?utm_source=chatgpt.com)

---

# Recovery References

## Common Lock Failure Example

Typical stale lock errors include:

```text id="6xryfx"
Error acquiring the state lock

ConditionalCheckFailedException

Failed to lock state

Lock Info:
```

These signatures usually indicate TF-001 conditions and should be mapped to this scenario.

---

## Backend Lock Investigation

Terraform lock failures are frequently caused by:

* Interrupted apply operations
* CI/CD pipeline termination
* Concurrent Terraform executions
* Stale DynamoDB lock records

State locking exists specifically to prevent concurrent state modification and corruption.

---

# Version Considerations

## Terraform < 1.10

Common locking implementation:

```text id="fpf6e4"
S3 + DynamoDB
```

---

## Terraform >= 1.10

Supports:

```text id="eof7eo"
S3 Native Locking
```

and

```text id="qd6nwi"
S3 + DynamoDB Hybrid Locking
```

DynamoDB locking remains supported for compatibility but is planned for future removal.

---

# Internal Repository References

Related Terraform Scenarios:

```text id="izztkv"
TF-002 Backend Access Failure

TF-003 State Drift Detection

TF-004 Remote State Access Failure

TF-009 CI/CD Pipeline Failure

TF-013 State File Restore

TF-015 State Corruption Recovery
```

---

# Escalation References

Escalate to TF-015 immediately if:

```text id="mk6rv5"
- State corruption suspected

- State file inaccessible

- Unexpected resource recreation occurs

- Multiple concurrent state writers detected

- Infrastructure consistency cannot be verified
```

---

# Repository Quality Validation

Before closing the incident, verify:

```text id="eged6j"
✓ Official documentation reviewed if behavior differs

✓ Recovery completed

✓ Verification checklist passed

✓ No stale lock records remain

✓ State integrity confirmed

✓ Related scenarios reviewed if needed
```

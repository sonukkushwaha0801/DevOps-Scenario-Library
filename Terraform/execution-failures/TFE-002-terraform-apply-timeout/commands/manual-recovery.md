# Manual Recovery — Commands Reference

## Scenario

Terraform apply timed out or was interrupted, and automated recovery paths are unsafe.

Resource status or provider state is uncertain.

Goal:
Manually assess infrastructure and restore Terraform consistency.

---

# Recovery Priority

Last-resort recovery path.

Risk Level: Critical
Recovery Complexity: Very High

Estimated Recovery Time:
2–24 hours+

---

# Manual Recovery Conditions

Use manual recovery when:

* resource status unclear
* retry apply unsafe
* import unsafe
* provider state inconsistent

Examples:

* long-running cluster provisioning
* database provisioning uncertainty
* infrastructure partially created

---

# Phase 1 — Emergency Containment

## Step 1 — Freeze All Operations

Immediately stop:

* terraform apply
* terraform import
* CI/CD pipelines
* infrastructure automation

Category: EMERGENCY
Risk: SAFE

Purpose:
Prevent further infrastructure inconsistency.

---

# Phase 2 — Audit Infrastructure

## Step 2 — Perform Infrastructure Audit

Identify:

* resources created
* resources still provisioning
* failed resources
* partial resources

Category: INVESTIGATIVE
Risk: SAFE

Purpose:
Determine actual infrastructure state.

---

# Phase 3 — Validate Terraform State

## Step 3 — Check State

```bash id="mrt-1"
terraform state list
```

Category: INVESTIGATIVE
Risk: SAFE

Expected:
State readable.

Check:

* tracked resources
* missing resources
* inconsistencies

---

# Phase 4 — Select Recovery Strategy

Choose one:

* wait for provider completion
* manual cleanup
* import resources
* partial rebuild

Decision based on:

* provider status
* resource health
* business impact

---

# Phase 5 — Execute Recovery

## Step 5 — Perform Manual Recovery

Possible actions:

* manually verify provider status
* manually clean resources
* import completed resources
* rebuild failed resources

Category: RECOVERY
Risk: CRITICAL

Purpose:
Restore infrastructure consistency.

---

# Phase 6 — Validate Terraform

## Step 6 — Validate Plan

```bash id="mrt-2"
terraform plan
```

Category: VERIFICATION
Risk: SAFE

Expected:
Predictable plan.

PASS:
Terraform operational.

FAIL:

* drift
* replacements
* state mismatch

---

# Recovery Success Criteria

✓ Infrastructure state understood
✓ Resources stable
✓ Terraform state valid
✓ Terraform operational

---

# Mandatory Escalation

Escalate immediately to:

* Senior DevOps Engineer
* Platform Engineering Lead
* Incident Commander

Possible additional escalation:

* Cloud provider support
* Platform team

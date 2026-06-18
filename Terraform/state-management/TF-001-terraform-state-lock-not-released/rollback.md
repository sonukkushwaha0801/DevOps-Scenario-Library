# TF-001 — Rollback Procedure

---

# Purpose

This rollback procedure is used if recovery actions for Terraform state lock removal cause unexpected issues.

Examples:

* Wrong lock removed
* Concurrent Terraform execution started
* State inconsistency detected
* Backend corruption suspected

---

# Rollback Severity

P1 / P0 depending on impact

Immediate escalation required if infrastructure changes are actively occurring.

---

# Rollback Triggers

Initiate rollback immediately if any of the following occurs:

* Multiple terraform apply processes detected
* Infrastructure changes happening unexpectedly
* terraform plan output becomes inconsistent
* terraform state inaccessible
* Backend reports corrupted lock/state

---

# Phase 1 — Emergency Containment

## Step 1: Stop All Terraform Operations

Stop all running Terraform processes.

### Linux

```bash id="4k33z6"
ps aux | grep terraform
```

Kill active process if required.

```bash id="p0ynje"
kill -9 <PID>
```

---

## Step 2: Stop CI/CD Pipelines

Pause:

* GitHub Actions GitHub Actions
* Jenkins
* GitLab CI
* Any active deployment system

Goal:
Prevent further state modifications.

---

# Phase 2 — Incident Containment

## Step 3: Restrict Terraform Access

Temporarily block:

* Manual applies
* Automated applies
* Scheduled infrastructure jobs

Recommended actions:

* Lock deployment pipeline
* Disable merge to main
* Notify infra team

---

## Step 4: Notify Incident Team

Escalate to:

* DevOps Engineer
* Senior SRE
* Platform Architect
* Incident Commander

Required details:

* Scenario ID: TF-001
* Time of failure
* Recovery action attempted
* Current blast radius

---

# Phase 3 — State Recovery

## Step 5: Inspect State Health

Run:

```bash id="mv1avm"
terraform state list
```

Expected:
State readable.

Failure:

* State inaccessible
* Missing resources
* Backend unavailable

---

## Step 6: Restore State Backup (If Required)

Use latest healthy backup.

Possible backup sources:

* Remote backend snapshots
* Manual state backup
* Versioned state storage

Important:
Restore only after incident approval.

Risk Level:
HIGH

---

# Phase 4 — Recovery Validation

## Step 7: Validate State Consistency

Run:

```bash id="ef4m3j"
terraform plan
```

Expected:
Clean or predictable plan.

Failure Indicators:

* Massive drift detected
* Unexpected resource recreation
* Destroy operations shown unexpectedly

---

# Phase 5 — Exit Criteria

Rollback successful only if:

✓ All Terraform processes stopped
✓ No concurrent execution
✓ State accessible
✓ Backend healthy
✓ Infrastructure stable

---

# Post-Incident Actions

Mandatory after rollback:

* Perform root cause analysis
* Document lock origin
* Improve lock handling
* Improve CI/CD cleanup logic
* Add preventive controls

Recommended prevention:

* Lock timeout strategy
* Pipeline cleanup hooks
* State backup automation

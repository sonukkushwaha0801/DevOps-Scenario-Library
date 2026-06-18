# TF-001 Lab — Reproduce Terraform State Lock Not Released

## Objective

Reproduce a Terraform state lock incident in a controlled environment and practice:

* Detecting lock acquisition failures
* Investigating lock ownership
* Identifying stale locks
* Recovering using Terraform best practices
* Verifying successful recovery

This lab simulates one of the most common Terraform production incidents.

---

# Learning Outcomes

After completing this lab, you should be able to:

✓ Recognize Terraform lock errors

✓ Investigate lock ownership

✓ Distinguish active locks from stale locks

✓ Safely perform lock recovery

✓ Verify backend health after recovery

✓ Avoid accidental state corruption

---

# Scenario Overview

A Terraform deployment is running.

The process terminates unexpectedly before releasing the lock.

Another engineer attempts a deployment and encounters:

```text id="fwp5m4"
Error acquiring the state lock
```

Your task is to investigate and recover safely.

---

# Lab Architecture

```text id="2hq5qt"
Terraform CLI
      │
      ▼
 AWS S3 Backend
      │
      ▼
 DynamoDB Lock Table
```

---

# Prerequisites

## Required Tools

```text id="r5lbjt"
Terraform >= 1.5

AWS CLI

AWS Account

Bash Shell
```

---

## Required AWS Resources

```text id="1fq6tl"
S3 Bucket

DynamoDB Table
```

Example:

```text id="h40v5w"
terraform-lab-state-bucket

terraform-lab-lock-table
```

---

# Environment Setup

## Step 1 — Create Working Directory

```bash id="4hny9o"
mkdir tf-lock-lab

cd tf-lock-lab
```

---

## Step 2 — Create Terraform Configuration

Create:

```text id="mkjlwm"
main.tf
```

```hcl id="d0i8mq"
terraform {

  backend "s3" {

    bucket         = "terraform-lab-state-bucket"
    key            = "lab/terraform.tfstate"
    region         = "us-east-1"

    dynamodb_table = "terraform-lab-lock-table"
  }
}

resource "null_resource" "example" {}
```

---

## Step 3 — Initialize Terraform

```bash id="jlwmk7"
terraform init
```

Expected:

```text id="4wjlwm"
Terraform has been successfully initialized
```

---

# Incident Reproduction

## Step 4 — Create Long Running Operation

Add:

```hcl id="xq9l5w"
resource "time_sleep" "wait" {

  create_duration = "300s"
}
```

Install provider:

```bash id="jlwm5m"
terraform init
```

---

## Step 5 — Start Apply

Terminal 1:

```bash id="jlwm7x"
terraform apply
```

Approve execution.

Terraform acquires lock.

---

## Step 6 — Simulate Failure

While apply is running:

Terminate Terraform forcefully.

Linux:

```bash id="jlwm3g"
pkill -9 terraform
```

or

Close terminal window.

---

# Validate Incident

## Step 7 — Attempt New Deployment

Open Terminal 2:

```bash id="jlwm2s"
terraform plan
```

Expected Error:

```text id="jlwm1j"
Error acquiring the state lock

ConditionalCheckFailedException

Lock Info:
```

Lab incident successfully reproduced.

---

# Investigation Phase

## Step 8 — Check Running Terraform Processes

```bash id="jlwm8h"
ps -ef | grep terraform
```

Expected:

```text id="jlwm9u"
No active terraform process.
```

---

## Step 9 — Investigate Lock Entry

```bash id="jlwm4k"
aws dynamodb scan \
  --table-name terraform-lab-lock-table
```

Expected:

Lock entry still exists.

Review:

```text id="jlwm0y"
LockID

Operation

Who

Created
```

---

# Recovery Phase

## Step 10 — Capture Lock ID

From the Terraform error:

```text id="jlwm6q"
Lock Info:

ID: xxxxxxxx-xxxx-xxxx
```

Copy the ID.

---

## Step 11 — Unlock State

```bash id="jlwm1v"
terraform force-unlock <LOCK_ID>
```

Expected:

```text id="jlwm8r"
Terraform state has been successfully unlocked.
```

---

# Verification Phase

## Step 12 — Verify State Access

```bash id="jlwm5r"
terraform state list
```

Expected:

```text id="jlwm7b"
null_resource.example
```

---

## Step 13 — Verify Lock Acquisition

```bash id="jlwm2n"
terraform plan
```

Expected:

```text id="jlwm3x"
No changes.
```

or

```text id="jlwm6m"
Plan: X to add
```

without lock errors.

---

## Step 14 — Verify Lock Table

```bash id="jlwm7z"
aws dynamodb scan \
  --table-name terraform-lab-lock-table
```

Expected:

```json id="jlwm4v"
{
  "Items": []
}
```

No stale lock entries.

---

# Recovery Success Criteria

The lab is successful only if:

```text id="jlwm9w"
✓ Lock error reproduced

✓ Lock owner investigated

✓ Lock record identified

✓ State unlocked safely

✓ terraform plan succeeds

✓ terraform state list succeeds

✓ No stale lock records remain
```

---

# Failure Scenarios To Explore

Optional exercises:

### Exercise 1

Attempt unlock while Terraform is still running.

Observe the risk.

---

### Exercise 2

Create two simultaneous applies.

Observe lock protection behavior.

---

### Exercise 3

Investigate lock metadata using DynamoDB.

Document findings.

---

### Exercise 4

Run terraform-lock-investigator.sh

Compare findings with manual investigation.

---

# Cleanup

Destroy resources:

```bash id="jlwm1z"
terraform destroy
```

Remove backend resources if no longer needed:

```text id="jlwm5c"
S3 Bucket

DynamoDB Table
```

---

# Expected Production Takeaway

In real incidents:

```text id="jlwm8e"
Do NOT immediately execute:

terraform force-unlock
```

Always verify:

1. No active Terraform process exists.
2. No active CI/CD deployment exists.
3. Lock ownership is understood.
4. State consistency can be verified.

Only then perform recovery.

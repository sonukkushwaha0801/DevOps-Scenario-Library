# AWS Lab — TF-001

This lab reproduces Terraform stale lock incidents using remote state and backend locking.

## Architecture

* State Storage → Amazon S3 bucket
* Lock Storage → Amazon DynamoDB table

## Scenario

Terraform apply is interrupted before lock cleanup.

Result:
State remains locked.

Subsequent Terraform operations fail.

## Learning Goals

* Understand remote backend locking
* Reproduce stale lock issue
* Investigate lock ownership
* Recover safely

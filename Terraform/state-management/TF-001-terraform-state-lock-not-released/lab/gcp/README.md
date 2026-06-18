# GCP Lab — TF-001

This lab reproduces Terraform state lock incidents using GCP remote backend.

## Architecture

* State Storage → Google Cloud Storage bucket
* Locking Mechanism → Backend object generation locking

## Scenario

Terraform operation fails before state update completes or lock metadata clears.

Result:
Future Terraform operations fail due to backend lock conflict.

## Learning Goals

* Understand GCP backend locking
* Reproduce stale lock behavior
* Investigate backend conflicts
* Recover safely

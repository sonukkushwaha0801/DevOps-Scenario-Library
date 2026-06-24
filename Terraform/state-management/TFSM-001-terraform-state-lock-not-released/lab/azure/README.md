# Azure Lab — TFSM-001

This lab reproduces Terraform stale lock incidents using Azure remote backend.

## Architecture

* State Storage → Microsoft Azure Blob Storage
* Locking Mechanism → Blob Lease Lock

## Scenario

Terraform acquires blob lease lock and operation fails before lease release.

Result:
State remains locked.

Future Terraform operations fail.

## Learning Goals

* Understand Azure backend locking
* Reproduce stale lock issue
* Investigate lease lock behavior
* Recover safely

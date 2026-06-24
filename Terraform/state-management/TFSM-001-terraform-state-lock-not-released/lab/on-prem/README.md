# On-Prem Lab — TFSM-001

This lab reproduces Terraform stale lock incidents in self-hosted environments.

## Architecture

* State Storage → Self-hosted backend
* Locking → External lock coordination system

Examples:

* Object storage
* Distributed KV store
* Shared storage backend

## Scenario

Terraform operation fails before lock cleanup completes.

Result:
State remains locked.

Subsequent Terraform operations fail.

## Learning Goals

* Understand on-prem lock handling
* Reproduce stale lock issue
* Investigate lock ownership
* Recover safely

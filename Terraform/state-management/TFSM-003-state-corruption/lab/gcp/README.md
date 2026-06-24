# GCP Lab — TFSM-003

This lab reproduces Terraform state corruption in GCP-backed environments.

## Scenario

Terraform uses GCP backend for remote state storage.

State becomes corrupted due to:

* interrupted write
* manual modification
* backend corruption

Result:
Terraform cannot safely manage infrastructure.

---

## Learning Goals

* Reproduce state corruption
* Detect corruption
* Practice recovery paths
* Validate safe recovery

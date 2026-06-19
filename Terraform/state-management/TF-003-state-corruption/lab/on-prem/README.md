# On-Prem Lab — TF-003

This lab reproduces Terraform state corruption in on-prem environments.

## Scenario

Terraform uses local or shared state storage.

State becomes corrupted due to:

* interrupted writes
* manual edits
* filesystem corruption

Result:
Terraform cannot safely manage infrastructure.

---

## Learning Goals

* Reproduce state corruption
* Detect corruption
* Practice recovery paths
* Validate safe recovery

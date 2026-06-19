# AWS Lab — TF-003

This lab reproduces Terraform state corruption in AWS-backed environments.

## Scenario

Terraform uses remote backend for state storage.

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

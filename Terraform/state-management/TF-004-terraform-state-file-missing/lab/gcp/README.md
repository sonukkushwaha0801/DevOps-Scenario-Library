# GCP Lab — TF-004

This lab reproduces Terraform missing state scenarios in GCP-backed environments.

## Scenario

Terraform uses GCP backend for state storage.

State becomes missing due to:

* accidental deletion
* bucket cleanup
* wrong backend prefix
* migration failure

Result:
Terraform loses infrastructure awareness.

---

## Learning Goals

* Reproduce missing state scenario
* Detect state loss
* Practice recovery paths
* Validate safe recovery

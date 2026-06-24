# On-Prem Lab — TFSM-004

This lab reproduces Terraform missing state scenarios in on-prem environments.

## Scenario

Terraform uses local or shared state storage.

State becomes missing due to:

* accidental deletion
* filesystem cleanup
* storage failure
* human error

Result:
Terraform loses infrastructure awareness.

---

## Learning Goals

* Reproduce missing state scenario
* Detect state loss
* Practice recovery paths
* Validate safe recovery

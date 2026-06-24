# On-Prem Lab — TFE-001

This lab reproduces Terraform partial apply failure scenarios in on-prem environments.

## Scenario

Terraform apply creates some infrastructure successfully but fails before deployment completes.

Result:
Infrastructure becomes partially provisioned.

Example:

* Network created
* Storage allocated
* Virtual Machine creation failed

---

## Learning Goals

* Reproduce partial apply failure
* Investigate created resources
* Practice recovery paths
* Validate infrastructure consistency

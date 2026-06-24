# On-Prem Lab — TFE-002

This lab reproduces Terraform apply timeout scenarios in on-prem environments.

## Scenario

Terraform apply begins infrastructure provisioning but gets interrupted before completion.

Result:
Resource state becomes uncertain.

Example:

* Network provisioned
* Storage provisioned
* VM provisioning started
* Apply interrupted

---

## Learning Goals

* Reproduce apply timeout
* Investigate resource status
* Practice recovery paths
* Validate infrastructure consistency

# Generic Lab — TFE-002

This lab reproduces Terraform apply timeout scenarios in a platform-neutral environment.

## Scenario

Terraform apply begins resource provisioning but gets interrupted before completion.

Result:
Resource state becomes uncertain.

---

## Learning Goals

* Understand apply timeout behavior
* Investigate resource status
* Practice recovery paths
* Validate infrastructure consistency

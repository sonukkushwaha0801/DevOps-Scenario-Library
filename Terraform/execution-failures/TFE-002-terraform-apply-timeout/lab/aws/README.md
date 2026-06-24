# AWS Lab — TFE-002

This lab reproduces Terraform apply timeout scenarios in AWS environments.

## Scenario

Terraform apply begins infrastructure provisioning but times out before completion.

Result:
Resource state becomes uncertain.

Example:

* VPC created
* Subnets created
* EKS provisioning started
* Apply interrupted

---

## Learning Goals

* Reproduce apply timeout
* Investigate resource status
* Practice recovery paths
* Validate infrastructure consistency

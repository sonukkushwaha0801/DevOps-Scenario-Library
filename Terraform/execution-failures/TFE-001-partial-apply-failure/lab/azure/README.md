# Azure Lab — TFE-001

This lab reproduces Terraform partial apply failure scenarios in Azure environments.

## Scenario

Terraform apply creates some Azure resources successfully but fails before completing deployment.

Result:
Infrastructure becomes partially provisioned.

Example:

* Resource Group created
* Virtual Network created
* Subnet created
* Virtual Machine creation failed

---

## Learning Goals

* Reproduce partial apply failure
* Investigate created resources
* Practice recovery paths
* Validate infrastructure consistency

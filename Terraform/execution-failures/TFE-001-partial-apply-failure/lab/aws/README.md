# AWS Lab — TFE-001

This lab reproduces Terraform partial apply failure scenarios in AWS environments.

## Scenario

Terraform apply creates some AWS resources successfully but fails before completing deployment.

Result:
Infrastructure becomes partially provisioned.

Example:

* VPC created
* Subnet created
* Security Group created
* EC2 creation failed

---

## Learning Goals

* Reproduce partial apply failure
* Investigate created resources
* Practice recovery paths
* Validate infrastructure consistency

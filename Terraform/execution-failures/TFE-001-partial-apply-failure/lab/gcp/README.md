# GCP Lab — TFE-001

This lab reproduces Terraform partial apply failure scenarios in GCP environments.

## Scenario

Terraform apply creates some GCP resources successfully but fails before completing deployment.

Result:
Infrastructure becomes partially provisioned.

Example:

* Network created
* Subnet created
* Firewall created
* VM creation failed

---

## Learning Goals

* Reproduce partial apply failure
* Investigate created resources
* Practice recovery paths
* Validate infrastructure consistency

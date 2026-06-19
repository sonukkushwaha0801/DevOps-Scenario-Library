# On-Prem Lab — TF-002

This lab reproduces Terraform state drift in on-prem environments.

## Scenario

Terraform provisions infrastructure in an on-prem environment.

A manual infrastructure change is made outside Terraform.

Result:
Terraform state no longer matches actual infrastructure.

Drift is detected.

---

## Learning Goals

* Reproduce infrastructure drift
* Detect drift using terraform plan
* Decide drift resolution path
* Practice both recovery paths

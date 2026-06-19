# GCP Lab — TF-002

This lab reproduces Terraform state drift in GCP.

## Scenario

Terraform provisions infrastructure in GCP.

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

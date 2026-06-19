# Generic Lab — TF-002

This lab reproduces Terraform state drift in a platform-neutral environment.

## Scenario

Terraform provisions infrastructure.

A change is made outside Terraform.

Result:
Terraform state no longer matches actual infrastructure.

Drift is detected.

---

## Learning Goals

* Understand infrastructure drift
* Detect drift using terraform plan
* Decide drift resolution path
* Practice both recovery paths

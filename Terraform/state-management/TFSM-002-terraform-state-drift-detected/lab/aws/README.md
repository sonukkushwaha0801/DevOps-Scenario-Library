# AWS Lab — TFSM-002

This lab reproduces Terraform state drift in AWS.

## Scenario

Terraform provisions infrastructure in AWS.

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

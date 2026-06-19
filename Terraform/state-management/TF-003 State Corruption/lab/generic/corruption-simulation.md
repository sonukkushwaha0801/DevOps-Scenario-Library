# Corruption Simulation

## Step 1 — Initialize Terraform

```bash id="gnv75s"
terraform init
terraform apply
```

Expected:
State created.

---

## Step 2 — Inspect Healthy State

Check:

* metadata
* resources
* serial
* lineage

---

## Step 3 — Simulate Corruption

Examples:

* break JSON
* remove resource block
* corrupt metadata

Example:

```json id="8z1r7h"
{
  "version": 4,
  "terraform_version":
```

---

## Step 4 — Observe Failure

Run:

```bash id="q9bpcn"
terraform state list
```

Expected:
State errors appear.

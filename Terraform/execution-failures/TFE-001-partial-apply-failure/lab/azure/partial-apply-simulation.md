# Partial Apply Simulation

## Step 1 — Initialize Terraform

```bash id="azure-step1"
terraform init
```

---

## Step 2 — Start Apply

```bash id="azure-step2"
terraform apply
```

Expected:
Terraform creates:

* Resource Group
* Virtual Network
* Subnet

Expected failure:
VM creation fails due to invalid VM size.

---

## Step 3 — Observe Failure

Expected result:
Partial infrastructure exists.

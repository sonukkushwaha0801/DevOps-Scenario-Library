# Partial Apply Simulation

## Step 1 — Initialize Terraform

```bash id="gcp-step1"
terraform init
```

---

## Step 2 — Start Apply

```bash id="gcp-step2"
terraform apply
```

Expected:
Terraform creates:

* Network
* Subnet
* Firewall

Expected failure:
VM creation fails due to invalid machine type.

---

## Step 3 — Observe Failure

Expected result:
Partial infrastructure exists.

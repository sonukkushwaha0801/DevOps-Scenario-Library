# Partial Apply Simulation

## Step 1 — Initialize Terraform

```bash id="onprem-step1"
terraform init
```

---

## Step 2 — Start Apply

```bash id="onprem-step2"
terraform apply
```

Expected:
Terraform creates:

* network
* storage

Expected failure:
VM provisioning fails.

---

## Step 3 — Observe Failure

Expected:
Partial infrastructure exists.

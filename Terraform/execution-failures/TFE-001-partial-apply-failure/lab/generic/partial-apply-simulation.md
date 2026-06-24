# Partial Apply Simulation

## Step 1 — Initialize Terraform

```bash id="generic-step1"
terraform init
```

---

## Step 2 — Start Apply

```bash id="generic-step2"
terraform apply
```

Expected:
Terraform creates:

* success_1
* success_2

Expected failure:
failure resource exits with error.

---

## Step 3 — Observe Failure

Expected:
Partial resources created.

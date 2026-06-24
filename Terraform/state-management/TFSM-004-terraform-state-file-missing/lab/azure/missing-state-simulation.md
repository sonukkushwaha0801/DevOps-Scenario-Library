# Missing State Simulation

## Step 1 — Deploy Infrastructure

```bash id="tf004-azure-step1"
terraform init
terraform apply
```

Expected:
Infrastructure created and state stored in Azure Blob Storage.

---

## Step 2 — Verify State Exists

```bash id="tf004-azure-step2"
terraform state list
```

Expected:
Resources listed.

---

## Step 3 — Delete State Blob

Simulate accidental deletion of backend state object.

Delete:

* terraform.tfstate blob

Result:
State disappears from backend.

---

## Step 4 — Observe Failure

Run:

```bash id="tf004-azure-step3"
terraform plan
```

Expected:
Terraform may attempt to recreate all infrastructure.

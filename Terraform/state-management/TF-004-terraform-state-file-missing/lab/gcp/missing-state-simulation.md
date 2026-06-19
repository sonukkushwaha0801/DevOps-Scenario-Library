# Missing State Simulation

## Step 1 — Deploy Infrastructure

```bash id="tf004-gcp-step1"
terraform init
terraform apply
```

Expected:
Infrastructure created and state stored in GCS.

---

## Step 2 — Verify State Exists

```bash id="tf004-gcp-step2"
terraform state list
```

Expected:
Resources listed.

---

## Step 3 — Delete State Object

Simulate accidental deletion of GCS backend object.

Delete:

* terraform.tfstate object

Result:
State disappears from backend.

---

## Step 4 — Observe Failure

Run:

```bash id="tf004-gcp-step3"
terraform plan
```

Expected:
Terraform may attempt to recreate all infrastructure.

# Missing State Simulation

## Step 1 — Deploy Infrastructure

```bash id="tf004-aws-step1"
terraform init
terraform apply
```

Expected:
Infrastructure created and state stored in S3.

---

## Step 2 — Verify State Exists

```bash id="tf004-aws-step2"
terraform state list
```

Expected:
Resources listed.

---

## Step 3 — Delete State Object

Simulate accidental deletion of S3 state object.

Delete:

* terraform.tfstate

Result:
State disappears from backend.

---

## Step 4 — Observe Failure

Run:

```bash id="tf004-aws-step3"
terraform plan
```

Expected:
Terraform may attempt to recreate all infrastructure.

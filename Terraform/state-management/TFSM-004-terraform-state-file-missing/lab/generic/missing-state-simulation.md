# Missing State Simulation

## Step 1 — Initialize Terraform

```bash id="tf004-generic-step1"
terraform init
terraform apply
```

Expected:
Infrastructure created and state file generated.

---

## Step 2 — Verify State Exists

Run:

```bash id="tf004-generic-step2"
terraform state list
```

Expected:
Resources listed.

---

## Step 3 — Delete State File

Simulate accidental deletion.

Delete:

* terraform.tfstate

Example:

```bash id="tf004-generic-step3"
rm terraform.tfstate
```

Result:
State file removed.

---

## Step 4 — Observe Failure

Run:

```bash id="tf004-generic-step4"
terraform plan
```

Expected:
Terraform may attempt to recreate all infrastructure.

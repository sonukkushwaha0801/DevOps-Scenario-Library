# Missing State Simulation

## Step 1 — Deploy Infrastructure

```bash id="tf004-onprem-step1"
terraform init
terraform apply
```

Expected:
Infrastructure created and local state file generated.

---

## Step 2 — Verify State Exists

Run:

```bash id="tf004-onprem-step2"
terraform state list
```

Expected:
Resources listed.

---

## Step 3 — Delete State File

Simulate accidental deletion.

Example:

```bash id="tf004-onprem-step3"
rm terraform.tfstate
```

Result:
State removed.

---

## Step 4 — Observe Failure

Run:

```bash id="tf004-onprem-step4"
terraform plan
```

Expected:
Terraform may attempt to recreate infrastructure.

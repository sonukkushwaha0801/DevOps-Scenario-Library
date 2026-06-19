# Manual Change Simulation

## Step 1 — Deploy Infrastructure

```bash id="jlwm184"
terraform init
terraform apply
```

Expected:
Infrastructure created.

---

## Step 2 — Simulate Manual Change

Assume actual infrastructure changes outside Terraform.

Before:

```text id="jlwm185"
size = small
```

After:

```text id="jlwm186"
size = medium
```

Terraform state is now outdated.

Drift introduced successfully.

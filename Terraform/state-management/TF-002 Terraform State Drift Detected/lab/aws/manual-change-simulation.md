# Manual Change Simulation

## Step 1 — Deploy Infrastructure

```bash id="jlwm107"
terraform init
terraform apply
```

Expected:
EC2 instance created.

---

## Step 2 — Make Manual Change

Change EC2 instance manually via:

* AWS Console
* AWS CLI

Example:
Change instance type.

Before:

```text id="jlwm108"
t2.micro
```

After:

```text id="jlwm109"
t2.medium
```

Terraform is unaware of this change.

Drift introduced successfully.

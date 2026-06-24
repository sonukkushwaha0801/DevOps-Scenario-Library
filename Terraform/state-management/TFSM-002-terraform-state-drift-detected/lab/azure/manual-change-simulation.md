# Manual Change Simulation

## Step 1 — Deploy Infrastructure

```bash id="jlwm147"
terraform init
terraform apply
```

Expected:
Azure VM created.

---

## Step 2 — Make Manual Change

Change VM manually via:

* Azure Portal
* Azure CLI

Example:
Change VM size.

Before:

```text id="jlwm148"
Standard_B1s
```

After:

```text id="jlwm149"
Standard_B2s
```

Terraform is unaware of this change.

Drift introduced successfully.

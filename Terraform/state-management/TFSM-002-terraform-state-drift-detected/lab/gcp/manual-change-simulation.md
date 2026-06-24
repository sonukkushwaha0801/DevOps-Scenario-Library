# Manual Change Simulation

## Step 1 — Deploy Infrastructure

```bash id="jlwm127"
terraform init
terraform apply
```

Expected:
Compute instance created.

---

## Step 2 — Make Manual Change

Change VM manually via:

* GCP Console
* gcloud CLI

Example:
Change machine type.

Before:

```text id="jlwm128"
e2-micro
```

After:

```text id="jlwm129"
e2-small
```

Terraform is unaware of this change.

Drift introduced successfully.

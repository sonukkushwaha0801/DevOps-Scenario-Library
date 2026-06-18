# Manual Change Simulation

## Step 1 — Deploy Infrastructure

```bash id="jlwm167"
terraform init
terraform apply
```

Expected:
VM created.

---

## Step 2 — Make Manual Change

Change VM manually using:

* virtualization platform UI
* CLI
* admin tools

Example:
Change CPU and memory.

Before:

```text id="jlwm168"
cpu = 2
memory = 4096
```

After:

```text id="jlwm169"
cpu = 4
memory = 8192
```

Terraform is unaware of this change.

Drift introduced successfully.

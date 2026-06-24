# Apply Timeout Simulation

## Step 1 — Initialize Terraform

```bash
terraform init
```

---

## Step 2 — Start Apply

```bash
terraform apply
```

Wait until long-running operation begins.

---

## Step 3 — Interrupt Apply

Simulate timeout/interruption:

```bash
CTRL + C
```

Expected:

* VPC created
* Subnets created
* provisioning interrupted

Result:
Resource state uncertain.

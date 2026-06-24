# Apply Timeout Simulation

## Step 1 — Initialize Terraform

```bash id="azure-timeout-step1"
terraform init
```

---

## Step 2 — Start Apply

```bash id="azure-timeout-step2"
terraform apply
```

Wait until long-running operation begins.

---

## Step 3 — Interrupt Apply

Simulate timeout/interruption:

```bash id="azure-timeout-step3"
CTRL + C
```

Expected:

* Resource Group created
* VNet created
* Subnet created
* provisioning interrupted

Result:
Resource state uncertain.

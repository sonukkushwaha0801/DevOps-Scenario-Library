# Apply Timeout Simulation

## Step 1 — Initialize Terraform

```bash id="onprem-timeout-step1"
terraform init
```

---

## Step 2 — Start Apply

```bash id="onprem-timeout-step2"
terraform apply
```

Wait until long-running operation begins.

---

## Step 3 — Interrupt Apply

Simulate timeout/interruption:

```bash id="onprem-timeout-step3"
CTRL + C
```

Expected:

* network provisioned
* storage provisioned
* VM provisioning interrupted

Result:
Resource state uncertain.

---

## Recovery Exercises

After simulating timeout, practice:

* commands/check-resource-status.md
* commands/retry-apply.md
* commands/import-missing-resources.md
* commands/manual-recovery.md


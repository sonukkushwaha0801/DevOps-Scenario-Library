# Apply Timeout Simulation

## Step 1 — Initialize Terraform

```bash id="generic-timeout-step1"
terraform init
```

---

## Step 2 — Start Apply

```bash id="generic-timeout-step2"
terraform apply
```

Wait until long-running resource execution begins.

---

## Step 3 — Interrupt Apply

Simulate timeout/interruption:

```bash id="generic-timeout-step3"
CTRL + C
```

Expected:

* resource_1 created
* resource_2 created
* long-running operation interrupted

Result:
Resource state uncertain.

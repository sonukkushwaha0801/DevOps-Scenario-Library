# Apply Timeout Simulation

## Step 1 — Initialize Terraform

```bash id="gcp-timeout-step1"
terraform init
```

---

## Step 2 — Start Apply

```bash id="gcp-timeout-step2"
terraform apply
```

Wait until long-running operation begins.

---

## Step 3 — Interrupt Apply

Simulate timeout/interruption:

```bash id="gcp-timeout-step3"
CTRL + C
```

Expected:

* Network created
* Subnet created
* Firewall created
* provisioning interrupted

Result:
Resource state uncertain.

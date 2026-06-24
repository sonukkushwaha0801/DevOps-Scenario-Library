# Reproduce Lock Issue

## Step 1 — Initialize Backend

```bash id="xrg5l4"
terraform init
```

Expected:
Azure backend initialized.

---

## Step 2 — Start Apply

```bash id="zwyqgk"
terraform apply
```

Approve execution.

Terraform acquires blob lease.

---

## Step 3 — Interrupt Execution

Terminate process abruptly.

Example:

```bash id="0c3dhv"
kill -9 <terraform_pid>
```

OR:

* close terminal
* terminate pipeline runner

This simulates:

* CI/CD crash
* terminal crash
* network interruption

---

## Step 4 — Retry Operation

```bash id="wdrcqz"
terraform plan
```

Expected error:

```text id="l4ppji"
Error acquiring the state lock
```

Possible Azure-specific error:

```text id="4gs3be"
state blob is already locked
```

Lab issue reproduced successfully.

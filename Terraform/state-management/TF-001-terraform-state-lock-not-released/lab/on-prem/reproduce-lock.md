# Reproduce Lock Issue

## Step 1 — Initialize Backend

```bash id="6j1jlwm"
terraform init
```

Expected:
Backend initialized.

---

## Step 2 — Start Apply

```bash id="7j1jlwm"
terraform apply
```

Approve execution.

Terraform acquires lock.

---

## Step 3 — Interrupt Execution

Terminate process abruptly.

Example:

```bash id="8j1jlwm"
kill -9 <terraform_pid>
```

Simulates:

* runner crash
* host failure
* backend interruption

---

## Step 4 — Retry Operation

```bash id="9j1jlwm"
terraform plan
```

Expected:
Lock-related error.

Lab issue reproduced successfully.

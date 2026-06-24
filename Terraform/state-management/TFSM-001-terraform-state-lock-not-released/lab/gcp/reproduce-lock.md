# Reproduce Lock Issue

## Step 1 — Initialize Backend

```bash id="jlwm8"
terraform init
```

Expected:
GCP backend initialized.

---

## Step 2 — Start Apply

```bash id="jlwm9"
terraform apply
```

Approve execution.

Terraform begins state operation.

---

## Step 3 — Interrupt Execution

Abruptly terminate process.

Example:

```bash id="jlwm10"
kill -9 <terraform_pid>
```

OR:

* close terminal
* kill CI runner

This simulates:

* pipeline crash
* abrupt termination
* backend write interruption

---

## Step 4 — Retry Operation

```bash id="jlwm11"
terraform plan
```

Possible error:

```text id="jlwm12"
Error acquiring the state lock
```

Or backend conflict errors.

Lab issue reproduced successfully.

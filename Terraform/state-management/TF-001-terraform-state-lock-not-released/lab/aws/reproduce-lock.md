# Reproduce Lock Issue

## Step 1 — Initialize Backend

```bash id="0j1uc7"
terraform init
```

Expected:
Remote backend initialized.

---

## Step 2 — Start Apply

```bash id="9j7afq"
terraform apply
```

Approve execution.

Terraform acquires lock.

---

## Step 3 — Interrupt Apply

Abruptly terminate process.

Example:

```bash id="r9yv6g"
kill -9 <terraform_pid>
```

OR:

* close terminal
* terminate CI runner

This simulates:

* pipeline crash
* terminal failure
* runner shutdown

---

## Step 4 — Retry Operation

```bash id="zdu6m0"
terraform plan
```

Expected error:

```text id="1fqu2x"
Error acquiring the state lock
```

Example lock message:

```text id="s85r55"
ConditionalCheckFailedException
```

Lab issue reproduced successfully.

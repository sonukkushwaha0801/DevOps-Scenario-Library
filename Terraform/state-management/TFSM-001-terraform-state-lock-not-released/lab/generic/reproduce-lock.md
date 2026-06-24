# Reproduce Lock Incident

## Step 1 — Initialize Lab

```
terraform init
```

Expected:
Initialization successful.

---

## Step 2 — Start Terraform Apply

```
terraform apply
```

Approve execution.

---

## Step 3 — Interrupt Execution

While apply is running:

* Close terminal abruptly
  OR
* Kill Terraform process

Example:

```
kill -9 <terraform_pid>
```

This simulates:

* abrupt failure
* CI/CD crash
* network interruption

---

## Step 4 — Retry Terraform Command

Run:

```
terraform apply
```

Expected failure:

```
Error acquiring the state lock
```

Lab issue reproduced successfully.

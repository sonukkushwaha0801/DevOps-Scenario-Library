# Corruption Simulation

## Step 1 — Deploy Infrastructure

```bash id="83icw4"
terraform init
terraform apply
```

Expected:
Infrastructure created.

---

## Step 2 — Download State

Pull current state.

```bash id="rlj3vk"
terraform state pull > terraform.tfstate
```

---

## Step 3 — Corrupt State

Examples:

* break JSON
* remove resource block
* modify metadata

Example corruption:

```json id="9uvlz6"
{
  "version": 4,
  "terraform_version":
```

---

## Step 4 — Push Corrupted State

```bash id="7mimk9"
terraform state push terraform.tfstate
```

Expected:
Corrupted state introduced.

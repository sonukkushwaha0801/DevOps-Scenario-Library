# Corruption Simulation

## Step 1 — Deploy Infrastructure

```bash id="0mg7gj"
terraform init
terraform apply
```

Expected:
Infrastructure created.

---

## Step 2 — Pull State

```bash id="ry2l1x"
terraform state pull > terraform.tfstate
```

---

## Step 3 — Corrupt State

Examples:

* break JSON
* remove resource block
* modify metadata

Example:

```json id="1o8h4l"
{
  "version": 4,
  "terraform_version":
```

---

## Step 4 — Push Corrupted State

```bash id="69c6c5"
terraform state push terraform.tfstate
```

Expected:
Corrupted state introduced.

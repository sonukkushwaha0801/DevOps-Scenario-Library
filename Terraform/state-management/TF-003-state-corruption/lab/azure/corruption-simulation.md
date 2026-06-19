# Corruption Simulation

## Step 1 — Deploy Infrastructure

```bash id="v9vl4z"
terraform init
terraform apply
```

Expected:
Infrastructure created.

---

## Step 2 — Pull State

```bash id="jhlxw6"
terraform state pull > terraform.tfstate
```

---

## Step 3 — Corrupt State

Examples:

* break JSON
* remove resource block
* modify metadata

Example:

```json id="cgj2ae"
{
  "version": 4,
  "terraform_version":
```

---

## Step 4 — Push Corrupted State

```bash id="93l0jw"
terraform state push terraform.tfstate
```

Expected:
Corrupted state introduced.

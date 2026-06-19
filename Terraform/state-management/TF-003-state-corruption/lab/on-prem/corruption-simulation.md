# Corruption Simulation

## Step 1 — Deploy Infrastructure

```bash id="zfjv4z"
terraform init
terraform apply
```

Expected:
State file created locally.

---

## Step 2 — Open State File

Example:

```bash id="kecvjt"
cat terraform.tfstate
```

---

## Step 3 — Corrupt State File

Examples:

* break JSON
* remove resource block
* modify metadata

Example corruption:

```json id="oksw1m"
{
  "version": 4,
  "terraform_version":
```

Save file.

---

## Step 4 — Observe Failure

Run:

```bash id="76sxsv"
terraform state list
```

Expected:
Terraform fails to read state.

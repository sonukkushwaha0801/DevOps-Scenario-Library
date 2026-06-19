# Drift Acceptance Lab

## Scenario

Manual change is valid.

Infrastructure should remain as-is.

Terraform code must be updated.

---

## Step 1 — Detect Drift

```bash id="jlwm110"
terraform plan
```

Expected:
Drift detected.

---

## Step 2 — Update Terraform Code

Before:

```hcl id="jlwm111"
instance_type = "t2.micro"
```

After:

```hcl id="jlwm112"
instance_type = "t2.medium"
```

---

## Step 3 — Validate

```bash id="jlwm113"
terraform plan
```

Expected:
No unexpected changes.

---

# Success Criteria

✓ Drift resolved
✓ IaC updated
✓ Terraform plan clean

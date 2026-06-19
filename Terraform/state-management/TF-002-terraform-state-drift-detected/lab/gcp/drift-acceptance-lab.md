# Drift Acceptance Lab

## Scenario

Manual change is valid.

Infrastructure remains as-is.

Terraform code must be updated.

---

## Step 1 — Detect Drift

```bash id="jlwm130"
terraform plan
```

Expected:
Drift detected.

---

## Step 2 — Update Terraform Code

Before:

```hcl id="jlwm131"
machine_type = "e2-micro"
```

After:

```hcl id="jlwm132"
machine_type = "e2-small"
```

---

## Step 3 — Verify

```bash id="jlwm133"
terraform plan
```

Expected:
No changes.

---

# Success Criteria

✓ Drift resolved
✓ IaC updated
✓ Terraform plan clean

# Drift Acceptance Lab

## Scenario

Manual change is valid.

Infrastructure remains as-is.

Terraform code must be updated.

---

## Step 1 — Detect Drift

```bash id="jlwm150"
terraform plan
```

Expected:
Drift detected.

---

## Step 2 — Update Terraform Code

Before:

```hcl id="jlwm151"
size = "Standard_B1s"
```

After:

```hcl id="jlwm152"
size = "Standard_B2s"
```

---

## Step 3 — Verify

```bash id="jlwm153"
terraform plan
```

Expected:
No changes.

---

# Success Criteria

✓ Drift resolved
✓ IaC updated
✓ Terraform plan clean

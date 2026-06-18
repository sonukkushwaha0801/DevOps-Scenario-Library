# Drift Acceptance Lab

## Scenario

Manual change is valid.

Infrastructure remains unchanged.

Terraform code must be updated.

---

## Step 1 — Detect Drift

```bash id="jlwm187"
terraform plan
```

Expected:
Drift detected.

---

## Step 2 — Update Terraform Configuration

Before:

```hcl id="jlwm188"
size = "small"
```

After:

```hcl id="jlwm189"
size = "medium"
```

---

## Step 3 — Verify

```bash id="jlwm190"
terraform plan
```

Expected:
No changes.

---

# Success Criteria

✓ Drift resolved
✓ IaC updated
✓ Terraform plan clean

# Drift Acceptance Lab

## Scenario

Manual change is valid.

Infrastructure remains as-is.

Terraform code must be updated.

---

## Step 1 — Detect Drift

```bash id="jlwm170"
terraform plan
```

Expected:
Drift detected.

---

## Step 2 — Update Terraform Code

Before:

```hcl id="jlwm171"
cpu    = 2
memory = 4096
```

After:

```hcl id="jlwm172"
cpu    = 4
memory = 8192
```

---

## Step 3 — Verify

```bash id="jlwm173"
terraform plan
```

Expected:
No changes.

---

# Success Criteria

✓ Drift resolved
✓ IaC updated
✓ Terraform plan clean

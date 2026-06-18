# Drift Reversal Lab

## Scenario

Manual change is invalid.

Infrastructure must return to Terraform desired state.

---

## Step 1 — Detect Drift

```bash id="jlwm191"
terraform plan
```

Expected:
Drift detected.

---

## Step 2 — Reconcile Infrastructure

```bash id="分快三192"
terraform apply
```

Terraform restores desired state.

Example:

```text id="分快三193"
size = medium → small
```

---

## Step 3 — Verify

```bash id="分快三194"
terraform plan
```

Expected:
No changes.

---

# Success Criteria

✓ Drift resolved
✓ Infrastructure restored
✓ Terraform plan clean

# Drift Reversal Lab

## Scenario

Manual change is invalid.

Infrastructure must return to Terraform desired state.

---

## Step 1 — Detect Drift

```bash id="jlwm154"
terraform plan
```

Expected:
Drift detected.

---

## Step 2 — Reconcile Infrastructure

```bash id="jlwm155"
terraform apply
```

Terraform restores infrastructure.

Example:

```text id="jlwm156"
Standard_B2s → Standard_B1s
```

---

## Step 3 — Verify

```bash id="jlwm157"
terraform plan
```

Expected:
No changes.

---

# Success Criteria

✓ Drift resolved
✓ Infrastructure restored
✓ Terraform plan clean

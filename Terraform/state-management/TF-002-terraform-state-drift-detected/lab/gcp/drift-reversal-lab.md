# Drift Reversal Lab

## Scenario

Manual change is invalid.

Infrastructure must return to Terraform desired state.

---

## Step 1 — Detect Drift

```bash id="jlwm134"
terraform plan
```

Expected:
Drift detected.

---

## Step 2 — Reconcile Infrastructure

```bash id="jlwm135"
terraform apply
```

Terraform restores infrastructure.

Example:

```text id="jlwm136"
e2-small → e2-micro
```

---

## Step 3 — Verify

```bash id="jlwm137"
terraform plan
```

Expected:
No changes.

---

# Success Criteria

✓ Drift resolved
✓ Infrastructure restored
✓ Terraform plan clean

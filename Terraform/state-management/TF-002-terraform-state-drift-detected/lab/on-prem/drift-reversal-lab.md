# Drift Reversal Lab

## Scenario

Manual change is invalid.

Infrastructure must return to Terraform desired state.

---

## Step 1 — Detect Drift

```bash id="jlwm174"
terraform plan
```

Expected:
Drift detected.

---

## Step 2 — Reconcile Infrastructure

```bash id="jlwm175"
terraform apply
```

Terraform restores infrastructure.

Example:

```text id="jlwm176"
cpu = 4 → 2
memory = 8192 → 4096
```

---

## Step 3 — Verify

```bash id="jlwm177"
terraform plan
```

Expected:
No changes.

---

# Success Criteria

✓ Drift resolved
✓ Infrastructure restored
✓ Terraform plan clean

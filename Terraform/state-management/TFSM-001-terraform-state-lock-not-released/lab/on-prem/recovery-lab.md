# Recovery Lab

## Step 1 — Verify No Active Process

```bash id="10j1jlwm"
ps aux | grep terraform
```

Expected:
No active process.

---

## Step 2 — Inspect Backend Lock

Check:

* lock metadata
* backend health
* state accessibility

Expected:
Stale lock found.

---

## Step 3 — Recover

Run:

```bash id="11j1jlwm"
terraform force-unlock LOCK_ID
```

---

## Step 4 — Validate

Run:

```bash id="12j1jlwm"
terraform plan
```

Expected:
Successful plan.

---

# Success Criteria

✓ Lock removed
✓ Backend healthy
✓ State accessible
✓ Terraform operational

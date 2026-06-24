# Recovery Lab

## Step 1 — Verify No Active Process

```bash id="jlwm13"
ps aux | grep terraform
```

Expected:
No active process.

---

## Step 2 — Inspect Backend State

Check:

* state file accessibility
* backend versioning
* object integrity

Expected:
Backend reachable.

---

## Step 3 — Recover

Run:

```bash id="jlwm14"
terraform force-unlock LOCK_ID
```

If lock exists.

---

## Step 4 — Validate

Run:

```bash id="jlwm15"
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

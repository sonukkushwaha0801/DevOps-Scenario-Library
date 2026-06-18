# Recovery Lab

## Step 1 — Investigate

Check active Terraform processes.

```
ps aux | grep terraform
```

Expected:
No active process.

---

## Step 2 — Diagnose

Run helper scripts.

```
../../scripts/investigate-lock.sh
```

---

## Step 3 — Recover

Run unlock script.

```
../../scripts/force-unlock-safe.sh
```

Provide lock ID.

---

## Step 4 — Verify

Run:

```
terraform plan
```

Expected:
Successful plan.

---

# Success Criteria

✓ Lock removed
✓ Terraform operational
✓ State accessible
✓ No active incident

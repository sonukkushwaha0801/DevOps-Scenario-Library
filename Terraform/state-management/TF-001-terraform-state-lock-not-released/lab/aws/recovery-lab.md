# Recovery Lab

## Step 1 — Verify No Active Process

```bash id="g9p0k8"
ps aux | grep terraform
```

Expected:
No active process.

---

## Step 2 — Inspect Lock Record

Check lock table manually.

Expected:
Stale lock exists.

---

## Step 3 — Recover

Run:

```bash id="ecqub4"
terraform force-unlock LOCK_ID
```

---

## Step 4 — Validate

Run:

```bash id="qg3vsl"
terraform plan
```

Expected:
Successful plan.

---

# Success Criteria

✓ Lock removed
✓ State accessible
✓ Backend healthy
✓ Terraform operational

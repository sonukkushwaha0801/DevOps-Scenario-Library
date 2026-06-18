# Recovery Lab

## Step 1 — Verify No Active Process

```bash id="2r8pr8"
ps aux | grep terraform
```

Expected:
No active process.

---

## Step 2 — Validate Lease Lock

Check blob lease state in Azure portal or CLI.

Expected:
Lease still active.

---

## Step 3 — Recover

Run:

```bash id="k9t7dc"
terraform force-unlock LOCK_ID
```

OR manually break lease if necessary.

---

## Step 4 — Validate Recovery

```bash id="j4m66h"
terraform plan
```

Expected:
Plan succeeds.

---

# Success Criteria

✓ Lease lock removed
✓ State accessible
✓ Backend healthy
✓ Terraform operational

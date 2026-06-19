# Reject Drift — Rollback Procedure

## Purpose

Rollback infrastructure reconciliation if reverting drift causes issues.

Examples:

* infrastructure outage
* failed apply
* unexpected destroy
* partial resource replacement

---

# Rollback Triggers

Initiate rollback if:

* service outage occurs
* apply partially succeeds
* unexpected infrastructure behavior detected

---

# Phase 1 — Emergency Stop

Stop:

* active Terraform operations
* CI/CD pipelines
* manual infrastructure changes

---

# Phase 2 — Assess Blast Radius

Check:

* affected resources
* service impact
* outage severity

Classify:

* low
* medium
* high
* critical

---

# Phase 3 — Restore Infrastructure

Recovery options:

* restore manual changes
* restore previous infra state
* use backup configuration

Important:
Choose least disruptive recovery path.

---

# Phase 4 — Validate State

```bash id="jlwm46"
terraform state list
```

Expected:
State accessible.

---

# Phase 5 — Verify

```bash id="jlwm47"
terraform plan
```

Expected:
Stable and predictable plan.

---

# Success Criteria

✓ Infrastructure stable
✓ No outage
✓ State consistent
✓ Incident contained

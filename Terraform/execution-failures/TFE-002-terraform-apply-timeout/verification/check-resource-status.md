# Check Resource Status — Verification Procedure

## Purpose

Verify resource status investigation successfully determined actual infrastructure state after apply timeout.

Goal:
Ensure infrastructure state is known and recovery path selection is accurate.

---

# Verification Checklist

| Check                      | Status |
| -------------------------- | ------ |
| Resource status confirmed  | ⬜      |
| Provider status reliable   | ⬜      |
| Terraform state understood | ⬜      |
| Recovery path valid        | ⬜      |

---

# Phase 1 — Validate Resource Status

## Check 1 — Confirm Resource State

Verify actual resource state.

Confirm one of:

* resource not created
* resource still provisioning
* resource created
* resource partially created

PASS:
Resource state confirmed.

FAIL:
Resource state still unclear.

---

# Phase 2 — Validate Provider Status

## Check 2 — Verify Provider Data

Confirm:

* provider API responses consistent
* cloud console consistent
* infrastructure telemetry consistent

PASS:
Provider data reliable.

FAIL:
Conflicting provider status.

---

# Phase 3 — Validate Terraform State

## Check 3 — Check State

```bash id="vcs-1"
terraform state list
```

Category: VERIFICATION
Risk: SAFE

Expected:
State readable and understandable.

PASS:
State status clear.

FAIL:
State inconsistent.

---

# Phase 4 — Validate Recovery Path

## Check 4 — Confirm Selected Path

Confirm selected recovery path matches actual resource state.

Examples:

* resource missing → retry apply
* resource created → import
* partial resource → manual recovery

PASS:
Recovery path valid.

FAIL:
Wrong recovery path selected.

---

# Exit Criteria

Status verification successful only if:

✓ Resource state confirmed
✓ Provider data reliable
✓ Terraform state understood
✓ Recovery path valid


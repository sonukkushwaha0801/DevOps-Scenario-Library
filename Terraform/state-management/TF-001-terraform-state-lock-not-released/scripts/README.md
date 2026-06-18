# TF-001 Scripts

These scripts are helper utilities for investigating and recovering from Terraform state lock incidents.

## Important Rules

* Review script before execution
* Validate environment before running
* Never run force unlock blindly
* Scripts do not replace manual verification

## Script Categories

### Investigative

Safe scripts used to inspect environment.

* investigate-lock.sh
* lock-diagnostics.sh

### Recovery

Scripts assisting unlock workflow.

* force-unlock-safe.sh

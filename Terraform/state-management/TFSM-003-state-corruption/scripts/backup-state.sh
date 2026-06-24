#!/bin/bash

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="terraform.tfstate.backup.$TIMESTAMP"

echo "Creating backup: $BACKUP_FILE"
cp terraform.tfstate "$BACKUP_FILE"

echo "Backup completed."


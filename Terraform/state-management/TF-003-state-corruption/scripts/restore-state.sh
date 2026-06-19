#!/bin/bash

read -p "Enter backup filename: " BACKUP_FILE

if [ ! -f "$BACKUP_FILE" ]; then
    echo "Backup file not found."
    exit 1
fi

echo "WARNING: This will overwrite current state."

read -p "Type YES to continue: " CONFIRM

if [ "$CONFIRM" != "YES" ]; then
    echo "Operation cancelled."
    exit 1
fi

cp "$BACKUP_FILE" terraform.tfstate

echo "State restored."

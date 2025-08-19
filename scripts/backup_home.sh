#!/bin/bash

# Source directory to backup
SOURCE_DIR="/home/dorbsyfx-sys-admin_svr"

# Destination directory (mounted Windows drive)
DEST_DIR="/media/sf_E_Drive"

# Backup filename with timestamp
BACKUP_FILE="home_backup_$(date +'%Y%m%d_%H%M%S').tar.gz"

# Full path to the backup file
DEST_PATH="$DEST_DIR/$BACKUP_FILE"

# Create backup
tar -czf "$DEST_PATH" -C "$SOURCE_DIR" .

# Optional: keep only last 7 backups
cd "$DEST_DIR" || exit
ls -1tr home_backup_*.tar.gz | head -n -7 | xargs -d '\n' rm -f --

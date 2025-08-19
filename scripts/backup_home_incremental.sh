#!/bin/bash

# Source directory to backup
SOURCE_DIR="/home/dorbsyfx-sys-admin_svr/"

# Destination directory (mounted Windows drive)
DEST_DIR="/media/sf_E_Drive/backups"

# Make sure destination exists
mkdir -p "$DEST_DIR"

# Backup filename based on date
DATE=$(date +'%Y%m%d_%H%M%S')
BACKUP_PATH="$DEST_DIR/backup_$DATE"

# Perform incremental backup with rsync
# --archive preserves permissions, --delete removes deleted files from backup
# --link-dest points to the last backup for incremental behavior
LAST_BACKUP=$(ls -1tr "$DEST_DIR" | tail -n 1)

if [ -n "$LAST_BACKUP" ]; then
    rsync -a --delete --link-dest="$DEST_DIR/$LAST_BACKUP" "$SOURCE_DIR" "$BACKUP_PATH"
else
    rsync -a "$SOURCE_DIR" "$BACKUP_PATH"
fi

# Optional: keep only last 7 backups
cd "$DEST_DIR" || exit
ls -1tr | head -n -7 | xargs -d '\n' rm -rf --

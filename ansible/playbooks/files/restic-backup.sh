#!/bin/bash

export RESTIC_REPOSITORY="/mnt/backups"
export RESTIC_PASSWORD="mysecurepass"

LOGFILE="/tmp/restic-backup-$(date +%F).log"
EMAIL="udoteh523@gmail.com"

{
    echo "Starting Restic backup: $(date)"
    restic backup /etc /home
    restic forget --keep-daily 7 --keep-weekly 4 --keep-monthly 6
    restic prune
    echo "Backup completed successfully: $(date)"
} > "$LOGFILE" 2>&1

if [ $? -eq 0 ]; then
    mail -s "✅ Restic Backup Successful on $(hostname)" "$EMAIL" < "$LOGFILE"
else
    mail -s "❌ Restic Backup Failed on $(hostname)" "$EMAIL" < "$LOGFILE"
fi


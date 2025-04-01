#!/bin/bash
export RESTIC_REPOSITORY="/mnt/backups"
export RESTIC_PASSWORD="mysecurepass"

restic backup /etc /home
restic forget --keep-daily 7 --keep-weekly 4 --keep-monthly 6
restic prune

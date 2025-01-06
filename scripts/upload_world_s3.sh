#!/bin/bash

# Variables
VALHEIM_WORLD_PATH="/home/valheim/.config/unity3d/IronGate/Valheim/worlds_local"
S3_BUCKET_NAME="terraform-valheim-llanuza-v1"
S3_BUCKET_PATH="DaTServerV4"
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_NAME="valheim-world-backup-${TIMESTAMP}.tar.gz"

# Check if the world files exist
if [ ! -d "$VALHEIM_WORLD_PATH" ]; then
    echo "Error: Valheim world directory not found at $VALHEIM_WORLD_PATH"
    exit 1
fi

# Create a compressed archive of the world files
echo "Creating a backup archive..."
tar -czf "/tmp/$BACKUP_NAME" -C "$VALHEIM_WORLD_PATH" .

if [ $? -ne 0 ]; then
    echo "Error: Failed to create backup archive."
    exit 1
fi

# Upload the archive to S3
echo "Uploading the backup to S3..."
aws s3 cp "/tmp/$BACKUP_NAME" "s3://$S3_BUCKET_NAME/$S3_BUCKET_PATH/$BACKUP_NAME"

if [ $? -ne 0 ]; then
    echo "Error: Failed to upload backup to S3."
    exit 1
fi

# Cleanup the local backup file
rm "/tmp/$BACKUP_NAME"

echo "Backup successfully uploaded to S3: s3://$S3_BUCKET_NAME/$S3_BUCKET_PATH/$BACKUP_NAME"
exit 0

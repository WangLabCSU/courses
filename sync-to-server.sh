#!/bin/bash

# Sync _site directory to lab-bio server
# Usage: ./sync-to-server.sh

set -e

SOURCE_DIR="_site"
TARGET_HOST="lab-bio"
TARGET_DIR="/home/bio/manage/appnet/apps/courses"

echo "Starting sync from $SOURCE_DIR to $TARGET_HOST:$TARGET_DIR..."

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist."
    echo "Please run the build script first to generate the _site directory."
    exit 1
fi

# Sync with rsync: force overwrite, delete extraneous files on destination
rsync -avz --delete "$SOURCE_DIR/" "$TARGET_HOST:$TARGET_DIR/"

echo "Sync completed successfully!"

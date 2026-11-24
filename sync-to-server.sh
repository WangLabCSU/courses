#!/bin/bash

# Sync _site directory to lab-bio server
# Usage: ./sync-to-server.sh [主机序号]

set -e

SOURCE_DIR="_site"
TARGET_DIR="/home/bio/manage/appnet/apps/courses"

# 可选目标主机（序号 -> ~/.ssh/config 中的别名）
# 1: lab-bio-in 校内直连（默认）；2: lab-bio biotree.top 域名
TARGET_HOSTS=("lab-bio-in" "lab-bio")
DEFAULT_HOST_NUMBER=1

usage() {
    echo "用法: $0 [主机序号]"
    local i=1
    for host in "${TARGET_HOSTS[@]}"; do
        echo "  $i - $host"
        i=$((i + 1))
    done
    echo "  不传参数时使用 $DEFAULT_HOST_NUMBER (${TARGET_HOSTS[$((DEFAULT_HOST_NUMBER - 1))]})"
}

case "$1" in
    -h|--help)
        usage
        exit 0
        ;;
esac

HOST_NUMBER="${1:-$DEFAULT_HOST_NUMBER}"

case "$HOST_NUMBER" in
    ''|*[!0-9]*)
        echo "错误: 主机序号必须是数字，收到 '$HOST_NUMBER'。" >&2
        usage >&2
        exit 1
        ;;
esac

if [ "$HOST_NUMBER" -lt 1 ] || [ "$HOST_NUMBER" -gt "${#TARGET_HOSTS[@]}" ]; then
    echo "错误: 主机序号 $HOST_NUMBER 超出范围 (1-${#TARGET_HOSTS[@]})。" >&2
    usage >&2
    exit 1
fi

TARGET_HOST="${TARGET_HOSTS[$((HOST_NUMBER - 1))]}"

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

#!/bin/bash
# This script logs system resource usage to a log file.
LOG_FILE="$HOME/logs/resource.log"
mkdir -p "$(dirname "$LOG_FILE")"

# Get system resource usage
cpu=$(vmstat 1 2 | tail -1 | awk '{print 100 - $15}')
mem=$(awk '/MemTotal/ {t=$2} /MemAvailable/ {a=$2} END {printf "%.1f", (t-a)/t*100}' /proc/meminfo)
disk=$(df -h / | awk 'NR==2 {print $5}')

if command -v nvidia-smi &> /dev/null; then
    gpu=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | head -1)
else
    gpu="N/A"
fi

echo "$(date '+%F %T') | CPU: ${cpu}% | RAM: ${mem}% | Disk: $disk | GPU: ${gpu}%" >> "$LOG_FILE"
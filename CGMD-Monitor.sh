#!/bin/bash

tput civis
trap "tput cnorm; exit" SIGINT SIGTERM
clear

while true; do
    tput cup 0 0

    # Get system resource usage
    cpu_info=$(vmstat 1 2 | tail -1 | awk '{printf "%d%%", 100 - $15}')
    mem_info=$(awk '/MemTotal/ {t=$2} /MemAvailable/ {a=$2} END {printf "%.2f / %.2f GB (%.1f%%)", (t-a)/1024/1024, t/1024/1024, (t-a)/t*100}' /proc/meminfo)
    disk_info=$(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}')

    if command -v nvidia-smi &> /dev/null; then
        gpu_info=$(nvidia-smi --query-gpu=utilization.gpu,memory.used,memory.total --format=csv,noheader,nounits | awk -F', ' '{printf "%s%% | VRAM: %s/%s MB  ", $1, $2, $3}')
    else
        gpu_info="N/A"
    fi

    # Display the information
    echo "=== SYSTEM MONITOR ===";  tput el
    printf "%-8s : %s\n" "CPU" "$cpu_info";  tput el
    printf "%-8s : %s\n" "RAM" "$mem_info";  tput el
    printf "%-8s : %s\n" "DISK " "$disk_info";  tput el
    printf "%-8s : %s\n" "GPU" "$gpu_info";  tput el
    echo "======================";  tput el
    echo "Press Ctrl+C to exit"
done
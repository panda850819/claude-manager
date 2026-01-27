#!/usr/bin/env bash

# Example: Memory monitoring and alerting
# This script monitors Claude process memory usage and alerts if it exceeds a threshold

set -euo pipefail

# Configuration
MEMORY_THRESHOLD_MB=2000  # Alert if total Claude memory exceeds this (in MB)
CHECK_INTERVAL=300        # Check every 5 minutes (in seconds)
LOG_FILE="${HOME}/.claude-manager/memory-monitor.log"

# Ensure log directory exists
mkdir -p "$(dirname "$LOG_FILE")"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

notify() {
    local message="$1"
    if command -v terminal-notifier &> /dev/null; then
        terminal-notifier -title "Claude Manager - Memory Alert" -message "$message"
    elif command -v notify-send &> /dev/null; then
        notify-send "Claude Manager - Memory Alert" "$message"
    fi
}

get_total_memory() {
    local total=0
    while read -r pid; do
        [ -z "$pid" ] && continue
        local mem
        mem=$(ps -p "$pid" -o rss= 2>/dev/null | awk '{print $1}' || echo "0")
        total=$((total + mem))
    done < <(pgrep -f "claude" | grep -v "grep" || true)

    # Convert KB to MB
    echo $((total / 1024))
}

log "Starting memory monitor (threshold: ${MEMORY_THRESHOLD_MB}MB)"

while true; do
    total_memory=$(get_total_memory)

    log "Current total memory: ${total_memory}MB"

    if [ "$total_memory" -gt "$MEMORY_THRESHOLD_MB" ]; then
        log "⚠️  Memory threshold exceeded: ${total_memory}MB > ${MEMORY_THRESHOLD_MB}MB"

        # Show status
        claude-manager status | tee -a "$LOG_FILE"

        # Send notification
        notify "Claude processes using ${total_memory}MB memory. Consider running 'claude-manager clean-idle'"

        # Optionally, auto-clean (uncomment to enable)
        # log "Auto-cleaning idle processes..."
        # claude-manager clean-idle -y | tee -a "$LOG_FILE"
    fi

    sleep "$CHECK_INTERVAL"
done

#!/usr/bin/env bash

# Example: Automated cleanup using cron
# This script can be scheduled to run periodically to clean up idle Claude processes

# Add to crontab with: crontab -e
# Example: Run every hour
# 0 * * * * /path/to/cron-cleanup.sh

set -euo pipefail

# Configuration
LOG_FILE="${HOME}/.claude-manager/cleanup.log"
NOTIFY=true  # Set to false to disable notifications

# Ensure log directory exists
mkdir -p "$(dirname "$LOG_FILE")"

# Log function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# Send notification (requires terminal-notifier on macOS or notify-send on Linux)
notify() {
    if [ "$NOTIFY" = true ]; then
        local message="$1"
        if command -v terminal-notifier &> /dev/null; then
            # macOS
            terminal-notifier -title "Claude Manager" -message "$message"
        elif command -v notify-send &> /dev/null; then
            # Linux
            notify-send "Claude Manager" "$message"
        fi
    fi
}

log "Starting automated cleanup..."

# Check if claude-manager is installed
if ! command -v claude-manager &> /dev/null; then
    log "ERROR: claude-manager not found in PATH"
    exit 1
fi

# Get process count before cleanup
before=$(claude-manager list 2>/dev/null | grep -c 'PID:' || echo "0")
log "Found $before Claude processes before cleanup"

# Perform cleanup
if [ "$before" -eq 0 ]; then
    log "No processes to clean"
    exit 0
fi

# Clean idle processes
output=$(claude-manager clean-idle -y 2>&1)
log "Cleanup output: $output"

# Get process count after cleanup
after=$(claude-manager list 2>/dev/null | grep -c 'PID:' || echo "0")
cleaned=$((before - after))

log "Cleaned $cleaned processes, $after remaining"

# Send notification if processes were cleaned
if [ "$cleaned" -gt 0 ]; then
    notify "Cleaned $cleaned idle Claude processes"
fi

log "Automated cleanup completed"

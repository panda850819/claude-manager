# Examples

This directory contains example scripts and configurations for using Claude Manager in various scenarios.

## Available Examples

### cron-cleanup.sh

Automated cleanup script that can be scheduled with cron to periodically clean idle Claude processes.

**Usage:**

```bash
# Make executable
chmod +x examples/cron-cleanup.sh

# Test manually
./examples/cron-cleanup.sh

# Add to crontab
crontab -e

# Example: Run every hour
0 * * * * /full/path/to/examples/cron-cleanup.sh
```

**Features:**
- Logs all cleanup operations
- Optional desktop notifications
- Safe automated cleanup with logging

### memory-monitor.sh

Continuous memory monitoring script that alerts when Claude processes exceed a memory threshold.

**Usage:**

```bash
# Make executable
chmod +x examples/memory-monitor.sh

# Run in background
./examples/memory-monitor.sh &

# Or run in a dedicated terminal/tmux pane
./examples/memory-monitor.sh
```

**Features:**
- Continuous monitoring
- Configurable memory threshold
- Desktop notifications
- Optional auto-cleanup

**Configuration:**

Edit the script to adjust:
- `MEMORY_THRESHOLD_MB` - Alert threshold (default: 2000MB)
- `CHECK_INTERVAL` - Check frequency in seconds (default: 300)
- Auto-cleanup option (commented out by default)

## Integration Ideas

### Tmux Integration

Add to your `~/.tmux.conf`:

```bash
# Show Claude process count in status bar
set -g status-right "#[fg=yellow]Claude: #(claude-manager list 2>/dev/null | grep -c 'PID:')#[default] | %H:%M"

# Bind key to show status
bind C-c run-shell "tmux display-popup -E 'claude-manager status'"
```

### Zellij Integration

Create a layout with a dedicated monitoring pane:

```kdl
layout {
    pane split_direction="vertical" {
        pane {
            // Your main work area
        }
        pane size="30%" {
            // Monitor pane
            command "watch"
            args "-n" "60" "claude-manager status"
        }
    }
}
```

### Alfred/Raycast Integration

Create a custom script command:

**Alfred:**
```bash
# Script: claude-status
claude-manager status
```

**Raycast:**
```bash
#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Claude Status
# @raycast.mode fullOutput

claude-manager status
```

### Systemd Service (Linux)

Create a systemd user service for automated cleanup:

```ini
# ~/.config/systemd/user/claude-cleanup.service
[Unit]
Description=Claude Manager Auto Cleanup

[Service]
Type=oneshot
ExecStart=/usr/local/bin/claude-manager clean-idle -y

[Install]
WantedBy=default.target
```

```ini
# ~/.config/systemd/user/claude-cleanup.timer
[Unit]
Description=Run Claude cleanup hourly

[Timer]
OnCalendar=hourly
Persistent=true

[Install]
WantedBy=timers.target
```

Enable and start:
```bash
systemctl --user enable --now claude-cleanup.timer
```

## Custom Scripts

Feel free to create your own scripts based on these examples! Common use cases:

- **Pre-shutdown cleanup** - Clean processes before system shutdown
- **Daily report** - Generate daily summary of Claude usage
- **Memory budget** - Enforce total memory limits
- **Session tracking** - Track which sessions are active and when
- **Auto-archive** - Archive logs of cleaned sessions

## Contributing Examples

Have a useful script or integration? Please contribute!

1. Add your script to this directory
2. Update this README with documentation
3. Submit a pull request

See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines.

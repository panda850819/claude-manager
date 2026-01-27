# Claude Manager

> Intelligent process manager for Claude Code agents - Keep your memory under control

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell: Bash](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![Platform: macOS | Linux](https://img.shields.io/badge/Platform-macOS%20%7C%20Linux-blue.svg)](https://github.com/yourusername/claude-manager)

## 🎯 What is Claude Manager?

Claude Manager is a lightweight CLI tool designed to manage Claude Code agent processes intelligently. If you're a heavy Claude Code user, especially in multi-window environments like Zellij or Tmux, you've probably noticed that agent processes can accumulate and consume significant memory over time.

**Claude Manager solves this problem** by providing smart detection and cleanup of idle processes while protecting your active sessions.

## ✨ Key Features

- **🧠 Smart Process Detection** - Automatically identifies active, running, standby, and idle processes based on CPU and memory usage
- **🛡️ Multi-Window Protection** - Detects and protects ALL active Claude sessions across different windows/panes (Zellij, Tmux, etc.)
- **📊 Detailed Status Reports** - Beautiful, color-coded status display with resource usage
- **🎯 Targeted Cleanup** - Multiple cleanup modes for different scenarios
- **⚡ Shell Integration** - Convenient aliases and auto-cleanup functions
- **🔒 Safety First** - Always protects current and active sessions from accidental cleanup

## 🚀 Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/claude-manager.git
cd claude-manager

# Run the installer
./install.sh
```

The installer will:
1. Install `claude-manager` to `/usr/local/bin`
2. Optionally set up shell integrations with convenient aliases

### Basic Usage

```bash
# View detailed status of all Claude processes
claude-manager status

# Clean only truly idle processes (safe)
claude-manager clean-idle

# Clean all non-active processes
claude-manager clean-all

# View help
claude-manager help
```

## 📖 Commands

### `status`

Display a detailed status report of all Claude Code processes with resource usage and categorization.

```bash
claude-manager status
```

**Output Example:**

```
═══════════════════════════════════════════════════════════════
                  Claude Code Status Report
═══════════════════════════════════════════════════════════════

Process Details:
┌────────┬──────────┬──────────┬──────────────────────────────────┐
│  PID   │   CPU%   │   MEM    │            STATUS                │
├────────┼──────────┼──────────┼──────────────────────────────────┤
│ 7174   │    45.2% │    900M  │ 當前 (Current)                   │
│ 8234   │     8.1% │    400M  │ 活躍 (Active)                    │
│ 9012   │     0.2% │     50M  │ 閒置 (Idle)                      │
└────────┴──────────┴──────────┴──────────────────────────────────┘

Summary:
  Total Processes:  3
  Active:           2
  Running:          0
  Standby:          0
  Idle:             1

Status Legend:
  當前 (Current)   - This conversation window
  活躍 (Active)    - Other active windows (CPU >3% or Mem >200MB)
  運行中 (Running) - Processing tasks (CPU >5%)
  待機 (Standby)   - Large memory footprint but low CPU
  閒置 (Idle)      - Truly idle (CPU <0.5%, Mem <100MB)
```

### `list`

Simple list of all Claude Code process PIDs.

```bash
claude-manager list
```

### `clean-idle`

Safely clean only truly idle processes (CPU < 0.5%, Memory < 100MB). This is the **recommended** cleanup command.

```bash
# With confirmation prompt
claude-manager clean-idle

# Skip confirmation
claude-manager clean-idle -y
```

**When to use:**
- Regular maintenance
- You have multiple windows running and want to clean up only truly idle processes
- Safe to use anytime

### `clean-all`

Clean all non-active processes, including standby processes with large memory footprints.

```bash
# With confirmation prompt
claude-manager clean-all

# Skip confirmation
claude-manager clean-all -y
```

**When to use:**
- You want to free up more memory
- You're done with background sessions but they're still consuming resources
- More aggressive than `clean-idle`

### `kill`

Force kill **ALL** Claude Code processes. ⚠️ **Use with caution!**

```bash
# With confirmation prompt
claude-manager kill

# Skip confirmation (dangerous!)
claude-manager kill -y
```

**When to use:**
- Nuclear option when something is seriously wrong
- You want to completely restart all Claude sessions
- **Warning:** This will kill even your current active session!

## 🔍 Process Status Explained

Claude Manager categorizes processes into five states:

| Status | Criteria | Protected? | Cleaned by |
|--------|----------|-----------|------------|
| **當前 (Current)** | This conversation window | ✅ Always | None |
| **活躍 (Active)** | CPU >3% OR Mem >200MB | ✅ Always | None |
| **運行中 (Running)** | CPU >5% but not main session | ✅ Yes | None |
| **待機 (Standby)** | Large memory but low CPU | ⚠️ No | `clean-all` |
| **閒置 (Idle)** | CPU <0.5% AND Mem <100MB | ❌ No | `clean-idle`, `clean-all` |

## 🎨 Shell Integration

### Aliases

After installing shell integration, you get these convenient aliases:

```bash
cm          # claude-manager
cms         # claude-manager status
cmc         # claude-manager clean-idle
cmca        # claude-manager clean-all
```

### Auto-cleanup Function

```bash
# Manually trigger auto-cleanup
cm-auto-clean
```

This function automatically cleans idle processes when you're in a multi-window environment (Zellij or Tmux).

### Optional: Auto-cleanup on Exit

You can enable automatic cleanup when exiting your shell by uncommenting this line in the shell integration file:

```bash
trap cm-auto-clean EXIT
```

## 🛠️ Advanced Usage

### Multi-Window Environments (Zellij, Tmux)

Claude Manager is specifically designed for multi-window environments. It automatically:

1. Detects all active Claude sessions across different panes/windows
2. Protects them during cleanup
3. Shows you which sessions are active in the status report

**Example scenario in Zellij:**

```
Pane 1: Writing code      (PID 7174, CPU 45%, 900MB) → Protected
Pane 2: Background tasks  (PID 8234, CPU 8%, 400MB)  → Protected
Pane 3: Finished session  (PID 9012, CPU 0.2%, 50MB) → Can be cleaned
```

When you run `claude-manager clean-idle` from any pane:
- It will protect PIDs 7174 and 8234 (both active)
- It will safely clean PID 9012 (idle)

### Integration with Shell Hooks

You can integrate claude-manager into your shell startup/exit hooks:

**Zsh example (~/.zshrc):**

```bash
# Source claude-manager integration
source ~/.config/claude-manager/shell/zsh.sh

# Optional: Show status when starting a new shell
if command -v claude-manager &> /dev/null; then
    echo "💡 Claude processes: $(claude-manager list 2>/dev/null | grep -c 'PID')"
fi

# Optional: Auto-cleanup on exit
trap "claude-manager clean-idle -y" EXIT
```

## 📊 Use Cases

### 1. Daily Development Workflow

```bash
# Morning: Check what's running
cms

# During work: Multiple Claude windows for different tasks
# (processes accumulate naturally)

# End of day: Clean up
cmc -y
```

### 2. Memory Emergency

```bash
# System running slow, need memory NOW
cmca -y  # Clean all non-active processes

# Still need more memory?
cm kill -y  # Nuclear option
```

### 3. Before Starting Heavy Tasks

```bash
# Clean up before starting a memory-intensive task
cms              # Check current status
cmc -y          # Clean idle processes
# Now start your heavy task with more free memory
```

## 🤔 FAQ

### Why do Claude processes accumulate?

When you use Claude Code with multiple conversations or agents, each session spawns processes. Even after you finish a task, these processes may remain in memory. Over time, this can lead to significant memory consumption.

### Is it safe to clean processes?

Yes! Claude Manager uses intelligent detection to protect:
- Your current session
- Any active sessions (high CPU or large memory = actively working)
- Processes that are clearly doing work

The `clean-idle` command is very conservative and only cleans processes that are truly idle.

### What if I accidentally kill my current session?

The `kill` command is the only one that can kill your current session. That's why it requires explicit confirmation and is clearly marked as dangerous. For normal cleanup, use `clean-idle` or `clean-all`.

### Does it work with Docker containers?

Yes, if you're running Claude Code inside a Docker container, claude-manager will work as long as:
- You have the required commands (`bash`, `pgrep`, `ps`, `bc`)
- You run it from inside the container

### Can I customize the thresholds?

Currently, thresholds are hardcoded in the script:
- Active CPU: >3%
- Active Memory: >200MB
- Running CPU: >5%
- Idle CPU: <0.5%
- Idle Memory: <100MB

You can modify these in the script if needed. We may add configuration file support in future versions.

## 🐛 Troubleshooting

### "No Claude Code processes found"

This means there are no running Claude Code processes. This is normal if you haven't started Claude yet.

### "Command not found: bc"

Install `bc` (basic calculator):

```bash
# macOS
brew install bc

# Ubuntu/Debian
sudo apt-get install bc

# CentOS/RHEL
sudo yum install bc
```

### "Permission denied" when cleaning

This usually means you're trying to clean processes owned by another user. Make sure you're running claude-manager as the same user that started the Claude processes.

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Report bugs** - Open an issue with details about the problem
2. **Suggest features** - Share your ideas for improvements
3. **Submit PRs** - Fork, create a feature branch, and submit a pull request
4. **Improve docs** - Help make the documentation clearer

### Development Setup

```bash
# Clone the repo
git clone https://github.com/yourusername/claude-manager.git
cd claude-manager

# Make your changes to claude-manager script

# Test locally
./claude-manager status

# Submit a PR
```

## 📝 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built for the [Claude Code](https://claude.ai/claude-code) community
- Inspired by the need to manage multiple Claude agent sessions efficiently
- Special thanks to all contributors

## 📮 Support

- **Issues**: [GitHub Issues](https://github.com/yourusername/claude-manager/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/claude-manager/discussions)

---

Made with ❤️ for the Claude Code community

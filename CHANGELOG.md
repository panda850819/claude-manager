# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-01-27

### Added

- Initial release of Claude Manager
- Core commands:
  - `list` - List all Claude Code processes
  - `status` - Show detailed status with resource usage
  - `clean-idle` - Clean only truly idle processes
  - `clean-all` - Clean all non-active processes
  - `kill` - Force kill all processes
- Smart process detection with five categories:
  - Current (this conversation)
  - Active (CPU >3% or Memory >200MB)
  - Running (CPU >5%)
  - Standby (large memory but low CPU)
  - Idle (CPU <0.5% and Memory <100MB)
- Multi-window protection for Zellij and Tmux
- Beautiful color-coded status reports
- Installation script with shell integration support
- Shell integrations for Zsh and Bash:
  - Convenient aliases (cm, cms, cmc, cmca)
  - Auto-cleanup function
  - Optional periodic reminders
- Comprehensive documentation:
  - README with usage examples
  - Contributing guidelines
  - Shell integration docs
- Safety features:
  - Always protects active sessions
  - Confirmation prompts for destructive operations
  - `-y` flag to skip confirmations

### Security

- Script uses `set -euo pipefail` for safe error handling
- Only targets processes owned by current user
- No sudo or elevated privileges required for basic operations

---

## Future Plans

Ideas for future releases (not committed):

- [ ] Configuration file support for customizing thresholds
- [ ] Support for additional shells (fish, etc.)
- [ ] Web dashboard for monitoring
- [ ] Automatic scheduling of cleanups
- [ ] Integration with system notifications
- [ ] Docker container support
- [ ] Windows WSL support
- [ ] Homebrew formula
- [ ] More detailed process information (start time, parent, etc.)
- [ ] Export status to JSON/CSV
- [ ] Historical tracking of process usage

---

[1.0.0]: https://github.com/panda850819/claude-manager/releases/tag/v1.0.0

# Shell Integrations

This directory contains shell integration scripts for claude-manager.

## Installation

The installer (`install.sh`) will automatically copy the appropriate integration file to `~/.config/claude-manager/shell/` and provide instructions for sourcing it.

## Manual Installation

If you prefer to install manually:

### Zsh

1. Copy the integration file (or source it directly):
   ```bash
   cp shell-integrations/zsh.sh ~/.config/claude-manager/shell/zsh.sh
   ```

2. Add to your `~/.zshrc`:
   ```bash
   source ~/.config/claude-manager/shell/zsh.sh
   ```

3. Reload your shell:
   ```bash
   source ~/.zshrc
   ```

### Bash

1. Copy the integration file (or source it directly):
   ```bash
   cp shell-integrations/bash.sh ~/.config/claude-manager/shell/bash.sh
   ```

2. Add to your `~/.bashrc`:
   ```bash
   source ~/.config/claude-manager/shell/bash.sh
   ```

3. Reload your shell:
   ```bash
   source ~/.bashrc
   ```

## Features

### Aliases

- `cm` - Short for `claude-manager`
- `cms` - Quick status check (`claude-manager status`)
- `cmc` - Clean idle processes (`claude-manager clean-idle`)
- `cmca` - Clean all non-active processes (`claude-manager clean-all`)

### Functions

- `cm-auto-clean` - Automatically clean idle processes (detects Zellij/Tmux environments)
- `cm-check-idle` - Check for idle processes and show a reminder

### Optional Features

The integration files include several optional features that are commented out by default:

1. **Show status on shell start** - Display Claude process count when starting a new shell
2. **Auto-clean on exit** - Automatically clean idle processes when exiting the shell
3. **Periodic reminders** - Show cleanup reminders if many processes are running

To enable these features, simply uncomment the relevant lines in the integration file.

## Customization

Feel free to modify these integration files to suit your workflow. You can:

- Add your own aliases
- Modify the cleanup thresholds
- Add custom functions
- Integrate with your prompt or other shell features

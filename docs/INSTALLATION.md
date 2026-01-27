# Installation Guide

Complete installation instructions for Claude Manager.

## System Requirements

### Supported Operating Systems

- macOS 10.15 or later
- Linux (most distributions)

### Required Commands

The following commands must be available on your system:

- `bash` (version 4.0 or later recommended)
- `pgrep` - Process grep
- `ps` - Process status
- `bc` - Basic calculator

### Checking Requirements

```bash
# Check if required commands are available
command -v bash && echo "✓ bash"
command -v pgrep && echo "✓ pgrep"
command -v ps && echo "✓ ps"
command -v bc && echo "✓ bc"
```

If any command is missing, install it using your package manager.

## Installation Methods

### Method 1: Quick Install (Recommended)

```bash
# Download and run installer
curl -fsSL https://raw.githubusercontent.com/yourusername/claude-manager/main/install.sh | bash

# Or with git
git clone https://github.com/yourusername/claude-manager.git
cd claude-manager
./install.sh
```

### Method 2: Manual Install

```bash
# Download the script
curl -fsSL https://raw.githubusercontent.com/yourusername/claude-manager/main/claude-manager -o /usr/local/bin/claude-manager

# Make it executable
chmod +x /usr/local/bin/claude-manager

# Verify installation
claude-manager version
```

### Method 3: Local Install (No sudo required)

If you don't have sudo access or prefer a local installation:

```bash
# Create a local bin directory
mkdir -p ~/bin

# Download the script
curl -fsSL https://raw.githubusercontent.com/yourusername/claude-manager/main/claude-manager -o ~/bin/claude-manager

# Make it executable
chmod +x ~/bin/claude-manager

# Add to PATH (add this to your ~/.zshrc or ~/.bashrc)
export PATH="$HOME/bin:$PATH"

# Reload shell
source ~/.zshrc  # or source ~/.bashrc
```

## Shell Integration

### Zsh

1. The installer will create the integration file at:
   ```
   ~/.config/claude-manager/shell/zsh.sh
   ```

2. Add to your `~/.zshrc`:
   ```bash
   # Claude Manager integration
   if [ -f ~/.config/claude-manager/shell/zsh.sh ]; then
       source ~/.config/claude-manager/shell/zsh.sh
   fi
   ```

3. Reload your shell:
   ```bash
   source ~/.zshrc
   ```

### Bash

1. The installer will create the integration file at:
   ```
   ~/.config/claude-manager/shell/bash.sh
   ```

2. Add to your `~/.bashrc`:
   ```bash
   # Claude Manager integration
   if [ -f ~/.config/claude-manager/shell/bash.sh ]; then
       source ~/.config/claude-manager/shell/bash.sh
   fi
   ```

3. Reload your shell:
   ```bash
   source ~/.bashrc
   ```

## Verification

After installation, verify everything works:

```bash
# Check version
claude-manager version

# Try listing processes
claude-manager list

# View status
claude-manager status

# Test aliases (if shell integration is installed)
cms  # Should show status
```

## Updating

### If installed via git

```bash
cd claude-manager
git pull
./install.sh
```

### If installed manually

```bash
# Re-download and replace
curl -fsSL https://raw.githubusercontent.com/yourusername/claude-manager/main/claude-manager -o /usr/local/bin/claude-manager
chmod +x /usr/local/bin/claude-manager
```

## Uninstallation

```bash
# Remove the main script
sudo rm /usr/local/bin/claude-manager

# Remove shell integrations (optional)
rm -rf ~/.config/claude-manager

# Remove from shell config
# Delete or comment out the source line in ~/.zshrc or ~/.bashrc
```

## Troubleshooting

### "Command not found: claude-manager"

1. Check if it's installed:
   ```bash
   ls -l /usr/local/bin/claude-manager
   ```

2. Check if /usr/local/bin is in your PATH:
   ```bash
   echo $PATH | grep -o '/usr/local/bin'
   ```

3. If not in PATH, add it to your shell config:
   ```bash
   export PATH="/usr/local/bin:$PATH"
   ```

### "Permission denied"

The script file might not be executable:

```bash
chmod +x /usr/local/bin/claude-manager
```

### "Command not found: bc"

Install the `bc` package:

```bash
# macOS
brew install bc

# Ubuntu/Debian
sudo apt-get install bc

# CentOS/RHEL
sudo yum install bc

# Arch Linux
sudo pacman -S bc
```

### Shell integration not working

1. Check if the file exists:
   ```bash
   ls -l ~/.config/claude-manager/shell/
   ```

2. Verify it's sourced in your shell config:
   ```bash
   grep -n "claude-manager" ~/.zshrc  # or ~/.bashrc
   ```

3. Check for syntax errors:
   ```bash
   bash -n ~/.config/claude-manager/shell/bash.sh  # or zsh.sh
   ```

## Docker Installation

If you're running Claude Code in a Docker container:

```dockerfile
# Add to your Dockerfile
RUN apt-get update && apt-get install -y bc procps curl
RUN curl -fsSL https://raw.githubusercontent.com/yourusername/claude-manager/main/claude-manager -o /usr/local/bin/claude-manager \
    && chmod +x /usr/local/bin/claude-manager
```

## Next Steps

After installation:

1. Read the [main README](../README.md) for usage examples
2. Try running `claude-manager status` to see your current processes
3. Customize the shell integration to your liking
4. Set up auto-cleanup if desired

## Support

If you encounter issues:

- Check the [FAQ](../README.md#-faq) in the main README
- Search [existing issues](https://github.com/yourusername/claude-manager/issues)
- Open a new issue with details about your environment

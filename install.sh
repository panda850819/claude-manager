#!/usr/bin/env bash

# claude-manager installer
# https://github.com/panda850819/claude-manager

set -euo pipefail

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

INSTALL_DIR="${INSTALL_DIR:-/usr/local/bin}"
SHELL_INTEGRATIONS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/claude-manager/shell"

echo -e "${CYAN}════════════════════════════════════════════${NC}"
echo -e "${CYAN}   Claude Manager Installer${NC}"
echo -e "${CYAN}════════════════════════════════════════════${NC}"
echo ""

# Check if running on supported OS
if [[ "$OSTYPE" != "darwin"* ]] && [[ "$OSTYPE" != "linux-gnu"* ]]; then
    echo -e "${RED}Error: Unsupported operating system: $OSTYPE${NC}"
    echo -e "claude-manager currently supports macOS and Linux only."
    exit 1
fi

# Check required commands
echo -e "${BLUE}Checking system requirements...${NC}"

required_commands=("bash" "pgrep" "ps" "bc")
missing_commands=()

for cmd in "${required_commands[@]}"; do
    if ! command -v "$cmd" &> /dev/null; then
        missing_commands+=("$cmd")
    fi
done

if [ ${#missing_commands[@]} -gt 0 ]; then
    echo -e "${RED}Error: Missing required commands: ${missing_commands[*]}${NC}"
    echo ""
    echo "Please install the missing commands and try again."
    exit 1
fi

echo -e "${GREEN}✓ All requirements met${NC}"
echo ""

# Install claude-manager
echo -e "${BLUE}Installing claude-manager...${NC}"

if [ ! -f "claude-manager" ]; then
    echo -e "${RED}Error: claude-manager script not found in current directory${NC}"
    echo "Please run this installer from the claude-manager repository directory."
    exit 1
fi

# Check if install directory is writable
if [ ! -w "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}Note: $INSTALL_DIR is not writable, using sudo...${NC}"
    sudo cp claude-manager "$INSTALL_DIR/claude-manager"
    sudo chmod +x "$INSTALL_DIR/claude-manager"
else
    cp claude-manager "$INSTALL_DIR/claude-manager"
    chmod +x "$INSTALL_DIR/claude-manager"
fi

echo -e "${GREEN}✓ Installed to $INSTALL_DIR/claude-manager${NC}"
echo ""

# Ask about shell integration
echo -e "${BLUE}Would you like to install shell integrations?${NC}"
echo -e "This will add convenient aliases and functions to your shell."
echo ""
read -rp "Install shell integrations? (y/N): " install_shell

if [[ "$install_shell" =~ ^[Yy]$ ]]; then
    # Create shell integrations directory
    mkdir -p "$SHELL_INTEGRATIONS_DIR"

    # Detect shell
    current_shell=$(basename "$SHELL")

    case "$current_shell" in
        zsh)
            cat > "$SHELL_INTEGRATIONS_DIR/zsh.sh" << 'EOF'
# claude-manager shell integration for Zsh

# Aliases
alias cm='claude-manager'
alias cms='claude-manager status'
alias cmc='claude-manager clean-idle'
alias cmca='claude-manager clean-all'

# Functions
cm-auto-clean() {
    if [ -n "$ZELLIJ" ] || [ -n "$TMUX" ]; then
        echo "🧹 Auto-cleaning idle Claude processes..."
        claude-manager clean-idle -y
    fi
}

# Optional: Auto-clean on shell exit
# Uncomment the following line to enable
# trap cm-auto-clean EXIT
EOF
            echo -e "${GREEN}✓ Created Zsh integration${NC}"
            echo ""
            echo -e "${YELLOW}Add the following to your ~/.zshrc:${NC}"
            echo -e "${CYAN}source $SHELL_INTEGRATIONS_DIR/zsh.sh${NC}"
            ;;

        bash)
            cat > "$SHELL_INTEGRATIONS_DIR/bash.sh" << 'EOF'
# claude-manager shell integration for Bash

# Aliases
alias cm='claude-manager'
alias cms='claude-manager status'
alias cmc='claude-manager clean-idle'
alias cmca='claude-manager clean-all'

# Functions
cm-auto-clean() {
    if [ -n "$ZELLIJ" ] || [ -n "$TMUX" ]; then
        echo "🧹 Auto-cleaning idle Claude processes..."
        claude-manager clean-idle -y
    fi
}

# Optional: Auto-clean on shell exit
# Uncomment the following line to enable
# trap cm-auto-clean EXIT
EOF
            echo -e "${GREEN}✓ Created Bash integration${NC}"
            echo ""
            echo -e "${YELLOW}Add the following to your ~/.bashrc:${NC}"
            echo -e "${CYAN}source $SHELL_INTEGRATIONS_DIR/bash.sh${NC}"
            ;;

        *)
            echo -e "${YELLOW}Shell integration for $current_shell is not available.${NC}"
            echo -e "You can still use claude-manager directly from the command line."
            ;;
    esac

    echo ""
fi

# Installation complete
echo -e "${GREEN}════════════════════════════════════════════${NC}"
echo -e "${GREEN}   Installation Complete!${NC}"
echo -e "${GREEN}════════════════════════════════════════════${NC}"
echo ""
echo -e "Try running: ${CYAN}claude-manager status${NC}"
echo ""
echo -e "For more information:"
echo -e "  ${CYAN}claude-manager help${NC}"
echo -e "  ${CYAN}https://github.com/panda850819/claude-manager${NC}"
echo ""

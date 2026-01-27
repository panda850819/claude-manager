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

# Optional: Show Claude status when starting shell
# Uncomment to enable
# if command -v claude-manager &> /dev/null; then
#     local process_count=$(claude-manager list 2>/dev/null | grep -c 'PID:' || echo "0")
#     if [ "$process_count" -gt 0 ]; then
#         echo "💡 Claude processes running: $process_count"
#     fi
# fi

# Optional: Auto-clean on shell exit
# Uncomment the following line to enable
# trap cm-auto-clean EXIT

# Optional: Periodic cleanup reminder
# Shows a reminder if there are many idle processes
cm-check-idle() {
    if command -v claude-manager &> /dev/null; then
        local total=$(claude-manager list 2>/dev/null | grep -c 'PID:' || echo "0")
        if [ "$total" -gt 5 ]; then
            echo "💡 Tip: You have $total Claude processes. Run 'cmc' to clean idle ones."
        fi
    fi
}

# Optional: Add to precmd to show reminder before each prompt
# Uncomment to enable (Zsh only)
# autoload -Uz add-zsh-hook
# add-zsh-hook precmd cm-check-idle

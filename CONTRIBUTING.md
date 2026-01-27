# Contributing to Claude Manager

Thank you for your interest in contributing to Claude Manager! This document provides guidelines and instructions for contributing.

## Code of Conduct

Be respectful, inclusive, and constructive in all interactions. We aim to maintain a welcoming environment for all contributors.

## How to Contribute

### Reporting Bugs

If you find a bug, please create an issue with:

1. **Clear title** - Describe the issue concisely
2. **Environment details** - OS, shell, Claude Code version
3. **Steps to reproduce** - How can we recreate the issue?
4. **Expected vs actual behavior** - What should happen vs what actually happens
5. **Logs or screenshots** - If applicable

**Example:**

```
Title: clean-idle removes active processes in Tmux

Environment:
- OS: macOS 14.0
- Shell: zsh 5.9
- Terminal multiplexer: Tmux 3.3a

Steps to reproduce:
1. Start two Claude sessions in different Tmux panes
2. Run claude-manager status (shows both as active)
3. Run claude-manager clean-idle
4. One active session was killed

Expected: Only truly idle processes should be cleaned
Actual: Active process was removed
```

### Suggesting Features

Feature requests are welcome! Please:

1. **Check existing issues** - Someone might have already suggested it
2. **Describe the use case** - Why is this feature needed?
3. **Provide examples** - How would it work?
4. **Consider alternatives** - Are there other ways to achieve the goal?

### Submitting Pull Requests

1. **Fork the repository**

   ```bash
   git clone https://github.com/panda850819/claude-manager.git
   cd claude-manager
   ```

2. **Create a feature branch**

   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow the existing code style
   - Add comments for complex logic
   - Update documentation if needed

4. **Test your changes**

   ```bash
   # Test the script locally
   ./claude-manager status
   ./claude-manager clean-idle

   # Test installation
   ./install.sh
   ```

5. **Commit your changes**

   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

   Use conventional commit messages:
   - `feat:` - New feature
   - `fix:` - Bug fix
   - `docs:` - Documentation changes
   - `refactor:` - Code refactoring
   - `test:` - Adding tests
   - `chore:` - Maintenance tasks

6. **Push to your fork**

   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create a Pull Request**
   - Go to the original repository
   - Click "New Pull Request"
   - Select your branch
   - Fill in the PR template

## Development Guidelines

### Code Style

- Use **4 spaces** for indentation (not tabs)
- Use **meaningful variable names**
- Add **comments** for non-obvious logic
- Follow **bash best practices**:
  - Use `set -euo pipefail` at the start
  - Quote variables: `"$variable"`
  - Use `[[ ]]` instead of `[ ]`
  - Prefer `$()` over backticks

### Testing

Before submitting a PR, please test:

1. **Basic functionality**
   - `claude-manager list`
   - `claude-manager status`
   - `claude-manager clean-idle`
   - `claude-manager clean-all`

2. **Edge cases**
   - No Claude processes running
   - Single process
   - Many processes (10+)
   - Multi-window environments (Zellij/Tmux)

3. **Installation**
   - Fresh install
   - Upgrade from previous version
   - Uninstall

### Documentation

If your change affects user-facing behavior:

1. Update the README.md
2. Update command help text in the script
3. Add examples if applicable
4. Update CHANGELOG.md

## Project Structure

```
claude-manager/
├── claude-manager          # Main script
├── install.sh              # Installation script
├── README.md               # Main documentation
├── LICENSE                 # MIT License
├── CONTRIBUTING.md         # This file
├── CHANGELOG.md            # Version history
├── .gitignore             # Git ignore patterns
└── shell-integrations/     # Shell integration scripts
    ├── zsh.sh             # Zsh integration
    ├── bash.sh            # Bash integration
    └── README.md          # Integration docs
```

## Release Process

(For maintainers)

1. Update version in `claude-manager` script
2. Update CHANGELOG.md
3. Create a git tag: `git tag -a v1.x.x -m "Release v1.x.x"`
4. Push tag: `git push origin v1.x.x`
5. Create GitHub release from tag
6. Announce on relevant channels

## Questions?

If you have questions about contributing:

- Open an issue with the "question" label
- Start a discussion in GitHub Discussions

Thank you for contributing to Claude Manager! 🎉

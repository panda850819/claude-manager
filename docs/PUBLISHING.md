# Publishing Guide

Steps to publish Claude Manager as an open-source project.

## Pre-Publication Checklist

- [x] Core script implemented and tested
- [x] Installation script created
- [x] Comprehensive documentation written
- [x] LICENSE file added (MIT)
- [x] CONTRIBUTING guidelines created
- [x] CHANGELOG initialized
- [x] Shell integrations provided
- [x] Example scripts included
- [x] Git repository initialized
- [ ] GitHub repository created
- [ ] Update GitHub URLs in all files
- [ ] Create initial release
- [ ] Test installation from GitHub

## Step 1: Create GitHub Repository

1. Go to [GitHub](https://github.com/new)
2. Create a new repository named `claude-manager`
3. Don't initialize with README (we already have one)
4. Set visibility to Public
5. Copy the repository URL

## Step 2: Update GitHub URLs

Replace `panda850819` with your actual GitHub username in these files:

```bash
# Files to update:
- README.md (badges, installation instructions, links)
- install.sh (download URLs)
- claude-manager (help URL)
- CONTRIBUTING.md (repository URLs)
- CHANGELOG.md (release links)
- docs/INSTALLATION.md (download URLs)
```

Quick replacement:
```bash
# Replace with your actual username
find . -type f -not -path './.git/*' -exec sed -i '' 's/panda850819/YOURACTUALUSERNAME/g' {} +
```

## Step 3: Push to GitHub

```bash
# Add remote
git remote add origin https://github.com/YOURUSERNAME/claude-manager.git

# Push
git branch -M main
git push -u origin main
```

## Step 4: Create Initial Release

1. Go to your repository on GitHub
2. Click "Releases" → "Create a new release"
3. Tag version: `v1.0.0`
4. Release title: `Claude Manager v1.0.0`
5. Description: Copy from CHANGELOG.md
6. Click "Publish release"

## Step 5: Test Installation

Test the installation process from GitHub:

```bash
# Test quick install
curl -fsSL https://raw.githubusercontent.com/YOURUSERNAME/claude-manager/main/install.sh | bash

# Test manual install
curl -fsSL https://raw.githubusercontent.com/YOURUSERNAME/claude-manager/main/claude-manager -o ~/bin/claude-manager
chmod +x ~/bin/claude-manager
```

## Step 6: Add Repository Metadata

### Topics

Add these topics to your repository (Settings → Topics):
- `claude`
- `claude-code`
- `process-manager`
- `cli`
- `bash`
- `shell-script`
- `developer-tools`
- `memory-management`

### About Section

Add a concise description:
```
Intelligent process manager for Claude Code agents - Keep your memory under control
```

## Step 7: Create README Badge Images

Update the badge URLs in README.md if needed. Consider adding:

- ![GitHub release](https://img.shields.io/github/v/release/YOURUSERNAME/claude-manager)
- ![GitHub stars](https://img.shields.io/github/stars/YOURUSERNAME/claude-manager)
- ![GitHub issues](https://img.shields.io/github/issues/YOURUSERNAME/claude-manager)

## Step 8: Optional Enhancements

### GitHub Actions

Create `.github/workflows/test.yml` for automated testing:

```yaml
name: Test

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Test script
        run: |
          bash -n claude-manager
          bash -n install.sh
```

### Issue Templates

Create `.github/ISSUE_TEMPLATE/bug_report.md` and `feature_request.md` to help users file better issues.

### Pull Request Template

Create `.github/PULL_REQUEST_TEMPLATE.md` to standardize PRs.

## Step 9: Announce

Share your project:

### Social Media

- Twitter/X with #Claude, #ClaudeCode, #DevTools
- Reddit: r/programming, r/commandline
- Hacker News: Show HN

### Communities

- Claude Discord/Community (if available)
- Dev.to blog post
- Product Hunt

### Example Announcement

```
🚀 Introducing Claude Manager - Intelligent Process Manager for Claude Code

If you're a Claude Code power user, you've probably noticed agent
processes accumulating and eating your RAM. I built a tool to solve this!

Features:
✅ Smart detection of active vs idle processes
✅ Multi-window protection (Zellij, Tmux)
✅ Beautiful CLI with detailed status reports
✅ Safe, automated cleanup options

Open source (MIT): https://github.com/YOURUSERNAME/claude-manager

Would love your feedback! 🙏
```

## Step 10: Maintenance

### Regular Tasks

- Respond to issues promptly
- Review and merge pull requests
- Update CHANGELOG.md with each release
- Keep documentation up to date
- Monitor for security issues

### Versioning

Follow [Semantic Versioning](https://semver.org/):
- MAJOR: Breaking changes
- MINOR: New features (backward compatible)
- PATCH: Bug fixes

## Post-Launch Improvements

Consider these for future versions:

1. **Homebrew Formula** - Create a tap for easy installation on macOS
2. **AUR Package** - Package for Arch Linux users
3. **Apt/Yum Repositories** - For Debian/RedHat based systems
4. **Configuration File** - Allow users to customize thresholds
5. **More Shell Support** - Fish, Nu, etc.
6. **Tests** - Add automated tests
7. **CI/CD** - Automated releases and testing

## Getting Help

If you need help with publishing:

- GitHub Docs: https://docs.github.com/
- Open Source Guide: https://opensource.guide/
- Choose a License: https://choosealicense.com/

Good luck with your open source project! 🎉

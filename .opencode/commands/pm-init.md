---
description: Initialize the PM system and check dependencies
---

# Init

Initialize the PM system and check dependencies.

## Usage
```
/pm-init
```

## Instructions

### 1. Display Banner

```
 ██████╗ ██████╗██████╗ ███╗   ███╗
██╔════╝██╔════╝██╔══██╗████╗ ████║
██║     ██║     ██████╔╝██╔████╔██║
╚██████╗╚██████╗██║     ██║ ╚═╝ ██║
 ╚═════╝ ╚═════╝╚═╝     ╚═╝     ╚═╝

Claude Code Project Management (OpenCode Edition)
```

### 2. Check Dependencies

**GitHub CLI:**
```bash
if command -v gh &> /dev/null; then
  echo "GitHub CLI (gh) installed"
else
  echo "GitHub CLI (gh) not found"
  echo "Install: brew install gh (macOS) or apt install gh (Linux)"
fi
```

**GitHub Authentication:**
```bash
if gh auth status &> /dev/null; then
  echo "GitHub authenticated"
else
  echo "GitHub not authenticated"
  echo "Run: gh auth login"
fi
```

**gh-sub-issue Extension (optional):**
```bash
if gh extension list | grep -q "yahsan2/gh-sub-issue"; then
  echo "gh-sub-issue extension installed"
else
  echo "Installing gh-sub-issue..."
  gh extension install yahsan2/gh-sub-issue
fi
```

### 3. Create Directory Structure

```bash
mkdir -p .ccpm/prds
mkdir -p .ccpm/epics
mkdir -p .ccpm/context
mkdir -p .ccpm/rules
```

### 4. Check Git Configuration

```bash
if git rev-parse --git-dir > /dev/null 2>&1; then
  echo "Git repository detected"
  
  if git remote -v | grep -q origin; then
    remote_url=$(git remote get-url origin)
    echo "Remote: $remote_url"
  else
    echo "No remote configured"
    echo "Add with: git remote add origin <url>"
  fi
fi
```

### 5. Create GitHub Labels

If connected to GitHub repository:
```bash
gh label create "epic" --color "0E8A16" --description "Epic issue" --force
gh label create "task" --color "1D76DB" --description "Task within epic" --force
```

### 6. Output Summary

```
Initialization Complete!
========================

System Status:
  gh version: {version}
  Auth: {authenticated/not authenticated}
  Extensions: {count} installed

Next Steps:
  1. Create your first PRD: /pm-prd-new <feature-name>
  2. View help: /pm-help
  3. Check status: /pm-status
```

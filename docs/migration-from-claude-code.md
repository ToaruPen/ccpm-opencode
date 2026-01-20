# Migration Guide: Claude Code to OpenCode

This guide helps you migrate from the original CCPM (Claude Code PM) to the OpenCode edition.

## Overview

The OpenCode edition reorganizes CCPM to work with OpenCode while maintaining the same workflow and functionality. The main changes are:

1. **Directory structure** - Separated commands/agents from data
2. **Command naming** - Changed from `/pm:` to `/pm-` format
3. **Configuration** - Uses `opencode.json` instead of Claude settings

## Directory Mapping

### Before (Claude Code)

```
.claude/
├── commands/
│   └── pm/              # PM commands
├── agents/              # Agent definitions
├── prds/                # PRD files
├── epics/               # Epic and task files
├── context/             # Project context
├── rules/               # Rule files
└── scripts/             # Helper scripts
```

### After (OpenCode)

```
.opencode/
├── commands/            # All PM commands (pm-*.md)
└── agents/              # Agent definitions

.ccpm/
├── prds/                # PRD files
├── epics/               # Epic and task files
├── context/             # Project context
└── rules/               # Rule files

scripts/
└── pm/                  # Helper scripts
```

## Path Changes

| Original Path | New Path |
|---------------|----------|
| `.claude/prds/` | `.ccpm/prds/` |
| `.claude/epics/` | `.ccpm/epics/` |
| `.claude/context/` | `.ccpm/context/` |
| `.claude/rules/` | `.ccpm/rules/` |
| `.claude/commands/pm/` | `.opencode/commands/` |
| `.claude/agents/` | `.opencode/agents/` |
| `.claude/scripts/` | `scripts/` |

## Command Changes

Commands now use hyphen format instead of colon:

| Original | New |
|----------|-----|
| `/pm:init` | `/pm-init` |
| `/pm:help` | `/pm-help` |
| `/pm:prd-new` | `/pm-prd-new` |
| `/pm:prd-parse` | `/pm-prd-parse` |
| `/pm:prd-list` | `/pm-prd-list` |
| `/pm:prd-edit` | `/pm-prd-edit` |
| `/pm:prd-status` | `/pm-prd-status` |
| `/pm:epic-decompose` | `/pm-epic-decompose` |
| `/pm:epic-sync` | `/pm-epic-sync` |
| `/pm:epic-oneshot` | `/pm-epic-oneshot` |
| `/pm:epic-list` | `/pm-epic-list` |
| `/pm:epic-show` | `/pm-epic-show` |
| `/pm:epic-status` | `/pm-epic-status` |
| `/pm:epic-edit` | `/pm-epic-edit` |
| `/pm:epic-close` | `/pm-epic-close` |
| `/pm:epic-refresh` | `/pm-epic-refresh` |
| `/pm:epic-start` | `/pm-epic-start` |
| `/pm:epic-start-worktree` | `/pm-epic-start-worktree` |
| `/pm:epic-merge` | `/pm-epic-merge` |
| `/pm:issue-start` | `/pm-issue-start` |
| `/pm:issue-sync` | `/pm-issue-sync` |
| `/pm:issue-show` | `/pm-issue-show` |
| `/pm:issue-status` | `/pm-issue-status` |
| `/pm:issue-edit` | `/pm-issue-edit` |
| `/pm:issue-close` | `/pm-issue-close` |
| `/pm:issue-reopen` | `/pm-issue-reopen` |
| `/pm:issue-analyze` | `/pm-issue-analyze` |
| `/pm:next` | `/pm-next` |
| `/pm:status` | `/pm-status` |
| `/pm:standup` | `/pm-standup` |
| `/pm:blocked` | `/pm-blocked` |
| `/pm:in-progress` | `/pm-in-progress` |
| `/pm:sync` | `/pm-sync` |
| `/pm:import` | `/pm-import` |
| `/pm:validate` | `/pm-validate` |
| `/pm:clean` | `/pm-clean` |
| `/pm:search` | `/pm-search` |

## Migration Steps

### Step 1: Backup Existing Data

```bash
# Backup your .claude directory
cp -r .claude .claude.backup
```

### Step 2: Create New Directory Structure

```bash
# Create OpenCode directories
mkdir -p .opencode/commands
mkdir -p .opencode/agents
mkdir -p .ccpm/prds
mkdir -p .ccpm/epics
mkdir -p .ccpm/context
mkdir -p .ccpm/rules
mkdir -p scripts/pm
```

### Step 3: Copy Data Files

```bash
# Move PRD and Epic data
cp -r .claude/prds/* .ccpm/prds/ 2>/dev/null || true
cp -r .claude/epics/* .ccpm/epics/ 2>/dev/null || true
cp -r .claude/context/* .ccpm/context/ 2>/dev/null || true
```

### Step 4: Install OpenCode Commands

Copy the OpenCode command files from the CCPM OpenCode repository:

```bash
# From CCPM OpenCode repository
cp -r .opencode/commands/* YOUR_PROJECT/.opencode/commands/
cp -r .opencode/agents/* YOUR_PROJECT/.opencode/agents/
cp -r .ccpm/rules/* YOUR_PROJECT/.ccpm/rules/
cp -r scripts/* YOUR_PROJECT/scripts/
cp opencode.json YOUR_PROJECT/
```

### Step 5: Update References in Data Files

If your PRD/Epic files contain references to the old paths, update them:

```bash
# Find and replace .claude/ with .ccpm/ in your data files
find .ccpm -name "*.md" -exec sed -i '' 's/\.claude\//\.ccpm\//g' {} \;

# Find and replace /pm: with /pm- in your data files
find .ccpm -name "*.md" -exec sed -i '' 's/\/pm:/\/pm-/g' {} \;
```

### Step 6: Update CLAUDE.md to AGENTS.md

If you have a `CLAUDE.md` file:

```bash
# Rename and update
mv CLAUDE.md AGENTS.md

# Update any internal references
sed -i '' 's/CLAUDE\.md/AGENTS.md/g' AGENTS.md
sed -i '' 's/\.claude\//\.ccpm\//g' AGENTS.md
```

### Step 7: Create opencode.json

Create `opencode.json` in your project root:

```json
{
  "$schema": "https://opencode.ai/config.schema.json",
  "instructions": [
    "@.ccpm/rules/datetime.md",
    "@.ccpm/rules/github-operations.md",
    "@.ccpm/rules/path-standards.md"
  ],
  "agents": {
    "code-analyzer": ".opencode/agents/code-analyzer.md",
    "file-analyzer": ".opencode/agents/file-analyzer.md",
    "test-runner": ".opencode/agents/test-runner.md",
    "parallel-worker": ".opencode/agents/parallel-worker.md"
  }
}
```

### Step 8: Verify Migration

```bash
# Run validation
/pm-validate

# Or use shell script
./scripts/pm/validate.sh
```

### Step 9: Clean Up (Optional)

After confirming everything works:

```bash
# Remove old .claude directory (keep backup until confident)
rm -rf .claude

# Update .gitignore if needed
echo ".ccpm/epics/" >> .gitignore
```

## Configuration Differences

### Claude Code Settings

The original used Claude Code's built-in settings and `CLAUDE.md`.

### OpenCode Configuration

OpenCode uses `opencode.json` for configuration:

```json
{
  "$schema": "https://opencode.ai/config.schema.json",
  "instructions": [
    "List of rule files to always load"
  ],
  "agents": {
    "agent-name": "path/to/agent.md"
  }
}
```

## Rule File Changes

Rule files now use `@` syntax for file references:

```markdown
<!-- Before (Claude Code) -->
Read the datetime rule from .claude/rules/datetime.md

<!-- After (OpenCode) -->
Before starting, read: @.ccpm/rules/datetime.md
```

## Agent Reference Changes

Agents are now referenced through `opencode.json` configuration rather than direct path references.

## Troubleshooting

### Commands Not Found

Ensure `.opencode/commands/` contains all `pm-*.md` files and OpenCode is configured to read from this directory.

### Path Errors

If you see errors about `.claude/` paths:
1. Check your data files for old path references
2. Run the sed replacement commands from Step 5
3. Update any custom scripts

### GitHub Sync Issues

The GitHub integration works the same way. Ensure:
- `gh` CLI is installed and authenticated
- `gh-sub-issue` extension is installed
- Repository has correct labels (`epic`, `task`)

### Missing Rules

If commands fail due to missing rules:
1. Ensure `.ccpm/rules/` contains all 11 rule files
2. Check `opencode.json` instructions array

## Getting Help

- Check [README.md](../README.md) for general documentation
- See [docs/commands.md](commands.md) for command reference
- Run `/pm-help` for quick command overview
- Run `/pm-validate` to check system integrity

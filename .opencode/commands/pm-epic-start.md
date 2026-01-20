---
description: Launch parallel agents to work on epic tasks in a shared branch
---

# Epic Start

Launch parallel agents to work on epic tasks in a shared branch.

## Usage
```
/pm-epic-start <epic_name>
```

## Quick Check

1. **Verify epic exists:**
   ```bash
   test -f .ccpm/epics/$ARGUMENTS/epic.md || echo "Epic not found. Run: /pm-prd-parse $ARGUMENTS"
   ```

2. **Check GitHub sync:**
   Look for `github:` field in epic frontmatter.
   If missing: "Epic not synced. Run: /pm-epic-sync $ARGUMENTS first"

3. **Check for uncommitted changes:**
   ```bash
   git status --porcelain
   ```
   If not empty: "You have uncommitted changes. Please commit or stash them first"

## Instructions

### 1. Create or Enter Branch

```bash
if ! git branch -a | grep -q "epic/$ARGUMENTS"; then
  git checkout main
  git pull origin main
  git checkout -b epic/$ARGUMENTS
  git push -u origin epic/$ARGUMENTS
else
  git checkout epic/$ARGUMENTS
  git pull origin epic/$ARGUMENTS
fi
```

### 2. Identify Ready Issues

Read all task files in `.ccpm/epics/$ARGUMENTS/`:
- Parse frontmatter for `status`, `depends_on`, `parallel` fields
- Build dependency graph

Categorize issues:
- **Ready**: No unmet dependencies, not started
- **Blocked**: Has unmet dependencies
- **In Progress**: Already being worked on
- **Complete**: Finished

### 3. Launch Parallel Agents

For each ready issue with analysis, use Task tool:
```yaml
Task:
  description: "Issue #{issue} Stream {X}"
  subagent_type: "general"
  prompt: |
    Working in branch: epic/$ARGUMENTS
    Issue: #{issue} - {title}
    Stream: {stream_name}

    Your scope:
    - Files: {file_patterns}
    - Work: {stream_description}

    Commit frequently with format:
    "Issue #{issue}: {specific change}"
```

### 4. Track Active Agents

Create `.ccpm/epics/$ARGUMENTS/execution-status.md`:
```markdown
---
started: {datetime}
branch: epic/$ARGUMENTS
---

# Execution Status

## Active Agents
- Agent-1: Issue #1234 Stream A - Started {time}

## Queued Issues
- Issue #1236 - Waiting for #1234
```

### 5. Output

```
Epic Execution Started: $ARGUMENTS

Branch: epic/$ARGUMENTS

Launching {total} agents across {issue_count} issues:

Issue #1234: Task Title
  - Stream A: {name} (Agent-1) Started
  - Stream B: {name} (Agent-2) Started

Blocked Issues:
  - #1236: Depends on #1234

Monitor with: /pm-epic-status $ARGUMENTS
```

## Error Handling

If uncommitted changes found:
```
You have uncommitted changes. Please commit or stash them.

To commit: git add . && git commit -m "message"
To stash: git stash push -m "Work in progress"
```

## Important Notes

- Agents work in the SAME branch (not separate branches)
- Maximum parallel agents: 5-10 recommended
- Monitor system resources if launching many agents

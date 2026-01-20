---
description: Launch parallel agents in a git worktree
---

# Epic Start (Worktree)

Launch parallel agents to work on epic tasks in a shared git worktree.

## Usage
```
/pm-epic-start-worktree <epic_name>
```

## Quick Check

1. **Verify epic exists:**
   ```bash
   test -f .ccpm/epics/$ARGUMENTS/epic.md || echo "Epic not found"
   ```

2. **Check GitHub sync:**
   Look for `github:` field in epic frontmatter.

3. **Check for worktree:**
   ```bash
   git worktree list | grep "epic-$ARGUMENTS"
   ```

## Instructions

### 1. Create or Enter Worktree

```bash
if ! git worktree list | grep -q "epic-$ARGUMENTS"; then
  git checkout main
  git pull origin main
  git worktree add ../epic-$ARGUMENTS -b epic/$ARGUMENTS
  echo "Created worktree: ../epic-$ARGUMENTS"
else
  echo "Using existing worktree: ../epic-$ARGUMENTS"
fi
```

### 2. Identify Ready Issues

Read all task files in `.ccpm/epics/$ARGUMENTS/`:
- Parse frontmatter for `status`, `depends_on`, `parallel`
- Build dependency graph
- Categorize: Ready, Blocked, In Progress, Complete

### 3. Launch Parallel Agents

For each ready issue:
```yaml
Task:
  description: "Issue #{issue} Stream {X}"
  subagent_type: "general"
  prompt: |
    Working in worktree: ../epic-$ARGUMENTS/
    Issue: #{issue} - {title}
    Stream: {stream_name}

    Your scope:
    - Files: {file_patterns}
    - Work: {stream_description}

    Read requirements from:
    - .ccpm/epics/$ARGUMENTS/{task_file}
    - .ccpm/epics/$ARGUMENTS/{issue}-analysis.md

    Commit frequently with format:
    "Issue #{issue}: {specific change}"
```

### 4. Track Active Agents

Create `.ccpm/epics/$ARGUMENTS/execution-status.md`:
```markdown
---
started: {datetime}
worktree: ../epic-$ARGUMENTS
branch: epic/$ARGUMENTS
---

# Execution Status

## Active Agents
- Agent-1: Issue #1234 Stream A - Started

## Queued Issues
- Issue #1236 - Waiting for #1234
```

### 5. Output

```
Epic Execution Started: $ARGUMENTS

Worktree: ../epic-$ARGUMENTS
Branch: epic/$ARGUMENTS

Launching {total} agents:

Issue #1234: Task Title
  - Stream A (Agent-1) Started
  - Stream B (Agent-2) Started

Blocked: #1236 (depends on #1234)

Monitor: /pm-epic-status $ARGUMENTS
```

## Important Notes

- Agents work in the SAME worktree
- Worktree isolates epic work from main repo
- Use `/pm-epic-merge` when complete

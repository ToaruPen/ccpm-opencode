---
description: Show epic progress and task status
---

# Epic Status

Show epic progress and task status.

## Usage
```
/pm-epic-status <epic_name>
```

## Instructions

### 1. Verify Epic Exists

Check if `.ccpm/epics/$ARGUMENTS/epic.md` exists:
- If not: "Epic not found: $ARGUMENTS"

### 2. Calculate Progress

Scan all task files in `.ccpm/epics/$ARGUMENTS/`:
```bash
total=$(ls .ccpm/epics/$ARGUMENTS/[0-9]*.md 2>/dev/null | wc -l)
closed=$(grep -l '^status: closed' .ccpm/epics/$ARGUMENTS/[0-9]*.md 2>/dev/null | wc -l)
in_progress=$(grep -l '^status: in-progress' .ccpm/epics/$ARGUMENTS/[0-9]*.md 2>/dev/null | wc -l)
open=$((total - closed - in_progress))
progress=$((closed * 100 / total))
```

### 3. Display Status

```
Epic Status: $ARGUMENTS
========================

Progress: [████████░░░░░░░░░░░░] 40%

Tasks:
  Closed:      4  ████████
  In Progress: 2  ████
  Open:        4  ████████
  Total:      10

Active Work:
  - #123: Task name (Agent-1 working)
  - #124: Task name (Agent-2 working)

Blocked:
  - #125: Waiting for #123, #124

Ready to Start:
  - #126: No dependencies

Recent Activity:
  - 10m ago: #123 - Commit: "Added user model"
  - 15m ago: #124 - Commit: "API endpoint created"
```

### 4. Check GitHub Status

If epic has GitHub URL, fetch latest status:
```bash
gh issue view {epic_number} --json state,comments
```

### 5. Next Actions

Based on status:
- If tasks ready: "Start task: /pm-issue-start {task_number}"
- If all in progress: "Monitor or wait for completion"
- If all done: "Close epic: /pm-epic-close $ARGUMENTS"
- If blocked: "Resolve blockers first"

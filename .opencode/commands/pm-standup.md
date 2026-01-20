---
description: Generate daily standup report
---

# Standup

Generate daily standup report.

## Usage
```
/pm-standup
```

## Instructions

### 1. Show Date Header

```
Daily Standup - {current_date}
================================
```

### 2. Today's Activity

Find files modified in last 24 hours:
```bash
recent_files=$(find .ccpm -name "*.md" -mtime -1 2>/dev/null)
```

Count by type:
- PRDs modified
- Epics updated
- Tasks worked on
- Progress updates posted

### 3. Currently In Progress

Show active work items from `.ccpm/epics/*/updates/*/progress.md`:
```
Currently In Progress:
  - Issue #{num} ({epic}) - {completion}% complete
  - Issue #{num} ({epic}) - {completion}% complete
```

### 4. Next Available Tasks

Show top 3 available tasks:
```
Next Available:
  - #{num} - {task_name}
  - #{num} - {task_name}
  - #{num} - {task_name}
```

### 5. Quick Stats

```
Quick Stats:
  Tasks: {open} open, {closed} closed, {total} total
```

### 6. Suggested Actions

Based on current state, suggest:
- Continue work on in-progress items
- Start new available tasks
- Review blocked items

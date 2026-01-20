---
description: List work currently in progress
---

# In Progress

List work currently in progress.

## Usage
```
/pm-in-progress
```

## Instructions

### 1. Find Active Work

Look for:
- Tasks with `status: in-progress` in frontmatter
- Progress files in `.ccpm/epics/*/updates/*/progress.md`
- Recent commits in epic branches

### 2. Display In-Progress Items

```
Work In Progress
================

Issue #{num}: {task_name}
   Epic: {epic_name}
   Progress: {completion}%
   Started: {start_date}
   Last activity: {last_update}

Issue #{num}: {task_name}
   Epic: {epic_name}
   Progress: {completion}%
   Started: {start_date}

Total: {count} items in progress
```

### 3. If Nothing In Progress

```
No work currently in progress.

Start work with:
  /pm-next           - See available tasks
  /pm-issue-start #  - Begin specific task
```

### 4. Activity Summary

Show recent commits and updates for in-progress work.

### 5. Suggested Actions

```
Actions:
  - Sync updates: /pm-issue-sync {num}
  - Check status: /pm-issue-status {num}
  - Close when done: /pm-issue-close {num}
```

---
description: Show next available tasks ready to start
---

# Next

Show next available tasks ready to start.

## Usage
```
/pm-next
```

## Instructions

### 1. Scan All Epics

For each epic directory in `.ccpm/epics/`:
- Read all task files (`[0-9]*.md`)
- Parse frontmatter for status, depends_on, parallel

### 2. Find Available Tasks

A task is available if:
- `status: open` (or no status)
- `depends_on` is empty or all dependencies are closed

### 3. Display Available Tasks

```
Next Available Tasks
====================

Ready: #{task_num} - {task_name}
   Epic: {epic_name}
   Can run in parallel

Ready: #{task_num} - {task_name}
   Epic: {epic_name}

Summary: {count} tasks ready to start
```

### 4. If No Tasks Available

```
No available tasks found.

Suggestions:
  - Check blocked tasks: /pm-blocked
  - View all tasks: /pm-epic-list
```

### 5. Quick Actions

```
Start work on a task:
  /pm-issue-start {task_number}
```

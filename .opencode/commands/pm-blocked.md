---
description: Show blocked tasks waiting on dependencies
---

# Blocked

Show blocked tasks waiting on dependencies.

## Usage
```
/pm-blocked
```

## Instructions

### 1. Scan All Tasks

For each task file in `.ccpm/epics/*/[0-9]*.md`:
- Check if `status: open`
- Parse `depends_on` field

### 2. Identify Blocked Tasks

A task is blocked if:
- Status is open
- Has non-empty `depends_on` list
- At least one dependency is not closed

### 3. Display Blocked Tasks

```
Blocked Tasks
================

Task #{num} - {task_name}
   Epic: {epic_name}
   Blocked by: [{dependencies}]
   Waiting for: #{open_dep1} #{open_dep2}

Task #{num} - {task_name}
   Epic: {epic_name}
   Blocked by: [{dependencies}]
   Waiting for: #{open_dep}

Total blocked: {count} tasks
```

### 4. If No Blocked Tasks

```
No blocked tasks found!

All tasks with dependencies are either completed or in progress.
```

### 5. Suggestions

```
To unblock tasks:
  - Complete dependency tasks first
  - Use /pm-next to see available work
  - Use /pm-issue-start to begin work
```

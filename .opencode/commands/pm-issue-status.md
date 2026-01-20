---
description: Check issue status and current state
---

# Issue Status

Check issue status (open/closed) and current state.

## Usage
```
/pm-issue-status <issue_number>
```

## Instructions

### 1. Fetch Issue Status

```bash
gh issue view $ARGUMENTS --json state,title,labels,assignees,updatedAt
```

### 2. Display Status

```
Issue #$ARGUMENTS: {Title}
   
Status: {OPEN/CLOSED}
   Last update: {timestamp}
   Assignee: {assignee or "Unassigned"}
   
Labels: {label1}, {label2}
```

### 3. Epic Context

If issue is part of an epic:
```
Epic Context:
   Epic: {epic_name}
   Epic progress: {completed}/{total} tasks
   This task: {position} of {total}
```

### 4. Local Sync Status

```
Local Sync:
   Local file: {exists/missing}
   Last local update: {timestamp}
   Sync status: {in_sync/needs_sync}
```

### 5. Status Indicators

Visual indicators:
- Open and ready
- Open with blockers  
- Closed and complete

### 6. Suggested Actions

Based on status:
```
Suggested Actions:
   - Start work: /pm-issue-start $ARGUMENTS
   - Sync updates: /pm-issue-sync $ARGUMENTS
   - Close issue: /pm-issue-close $ARGUMENTS
```

### 7. Batch Status

Support comma-separated list:
```
/pm-issue-status 123,124,125
```

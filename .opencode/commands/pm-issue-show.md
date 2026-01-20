---
description: Display issue details with sub-issues
---

# Issue Show

Display issue and sub-issues with detailed information.

## Usage
```
/pm-issue-show <issue_number>
```

## Instructions

### 1. Fetch Issue Data

Get GitHub issue details:
```bash
gh issue view $ARGUMENTS --json title,body,state,labels,assignees,createdAt,updatedAt
```

Find local task file:
- Check `.ccpm/epics/*/$ARGUMENTS.md` (new naming)
- Or search for file with `github:.*issues/$ARGUMENTS` in frontmatter

### 2. Display Issue Overview

```
Issue #$ARGUMENTS: {Title}
   Status: {open/closed}
   Labels: {labels}
   Assignee: {assignee}
   Created: {date}
   Updated: {date}
   
Description:
{issue_description}
```

### 3. Local File Mapping

If local task file exists:
```
Local Files:
   Task: .ccpm/epics/{epic_name}/{task_file}
   Updates: .ccpm/epics/{epic_name}/updates/$ARGUMENTS/
   Last update: {timestamp}
```

### 4. Related Issues

```
Related Issues:
   Parent Epic: #{epic_issue}
   Dependencies: #{dep1}, #{dep2}
   Blocking: #{blocked1}
```

### 5. Progress Tracking

If task file exists, show acceptance criteria:
```
Acceptance Criteria:
   [x] Criterion 1 (completed)
   [ ] Criterion 2 (in progress)
   [ ] Criterion 3 (not started)
```

### 6. Recent Activity

```
Recent Activity:
   {timestamp} - {author}: {comment_preview}
   
View full thread: gh issue view #$ARGUMENTS --comments
```

### 7. Quick Actions

```
Quick Actions:
   Start work: /pm-issue-start $ARGUMENTS
   Sync updates: /pm-issue-sync $ARGUMENTS
   View in browser: gh issue view #$ARGUMENTS --web
```

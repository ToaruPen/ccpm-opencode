---
description: Update epic progress based on task states
---

# Epic Refresh

Update epic progress based on task states.

## Usage
```
/pm-epic-refresh <epic_name>
```

## Required Rules

**IMPORTANT:** Before executing this command, read and follow:
- @.ccpm/rules/datetime.md - For getting real current date/time

## Instructions

### 1. Count Task Status

Scan all task files in `.ccpm/epics/$ARGUMENTS/`:
- Count total tasks
- Count tasks with `status: closed`
- Count tasks with `status: open`
- Count tasks with `status: in-progress`

### 2. Calculate Progress

```
progress = (closed_tasks / total_tasks) * 100
```

Round to nearest integer.

### 3. Determine Epic Status

- If progress = 0% and no work started: `backlog`
- If progress > 0% and < 100%: `in-progress`
- If progress = 100%: `completed`

### 4. Update Epic

Get current datetime: `date -u +"%Y-%m-%dT%H:%M:%SZ"`

Update epic.md frontmatter:
```yaml
status: {calculated_status}
progress: {calculated_progress}%
updated: {current_datetime}
```

### 5. Update GitHub Task List

If epic has GitHub issue, sync task checkboxes:
```bash
gh issue view $epic_issue --json body -q .body > /tmp/epic-body.md

# Update checkboxes based on task status
for task_file in .ccpm/epics/$ARGUMENTS/[0-9]*.md; do
  task_status=$(grep 'status:' $task_file | cut -d: -f2 | tr -d ' ')
  task_issue=$(basename "$task_file" .md)
  
  if [ "$task_status" = "closed" ]; then
    sed -i "s/- \[ \] #$task_issue/- [x] #$task_issue/" /tmp/epic-body.md
  fi
done

gh issue edit $epic_issue --body-file /tmp/epic-body.md
```

### 6. Output

```
Epic refreshed: $ARGUMENTS

Tasks:
  Closed: {closed_count}
  Open: {open_count}
  Total: {total_count}
  
Progress: {old_progress}% -> {new_progress}%
Status: {old_status} -> {new_status}
GitHub: Task list updated

{If complete}: Run /pm-epic-close $ARGUMENTS to close epic
{If in progress}: Run /pm-next to see priority tasks
```

## Important Notes

- Useful after manual task edits or GitHub sync
- Don't modify task files, only epic status
- Preserve all other frontmatter fields

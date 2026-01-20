---
description: Mark an issue as complete and close it on GitHub
---

# Issue Close

Mark an issue as complete and close it on GitHub.

## Usage
```
/pm-issue-close <issue_number> [completion_notes]
```

## Required Rules

**IMPORTANT:** Before executing this command, read and follow:
- @.ccpm/rules/datetime.md - For getting real current date/time

## Instructions

### 1. Find Local Task File

Check if `.ccpm/epics/*/$ARGUMENTS.md` exists.
If not found: "No local task for issue #$ARGUMENTS"

### 2. Update Local Status

Get current datetime: `date -u +"%Y-%m-%dT%H:%M:%SZ"`

Update task file frontmatter:
```yaml
status: closed
updated: {current_datetime}
```

### 3. Update Progress File

If progress file exists at `.ccpm/epics/{epic}/updates/$ARGUMENTS/progress.md`:
- Set completion: 100%
- Add completion note
- Update last_sync

### 4. Close on GitHub

```bash
# Add completion comment
gh issue comment $ARGUMENTS --body "Task completed

{completion_notes}

---
Closed at: {timestamp}"

# Close the issue
gh issue close $ARGUMENTS
```

### 5. Update Epic Progress

- Count total tasks in epic
- Count closed tasks
- Calculate new progress percentage
- Update epic.md frontmatter

### 6. Output

```
Closed issue #$ARGUMENTS
  Local: Task marked complete
  GitHub: Issue closed
  Epic progress: {progress}% ({closed}/{total} tasks)
  
Next: Run /pm-next for next priority task
```

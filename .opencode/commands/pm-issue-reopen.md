---
description: Reopen a closed issue
---

# Issue Reopen

Reopen a closed issue.

## Usage
```
/pm-issue-reopen <issue_number> [reason]
```

## Required Rules

**IMPORTANT:** Before executing this command, read and follow:
- @.ccpm/rules/datetime.md - For getting real current date/time

## Instructions

### 1. Find Local Task File

Search for task file with issue number.
If not found: "No local task for issue #$ARGUMENTS"

### 2. Update Local Status

Get current datetime: `date -u +"%Y-%m-%dT%H:%M:%SZ"`

Update task file frontmatter:
```yaml
status: open
updated: {current_datetime}
```

### 3. Reset Progress

If progress file exists:
- Keep original started date
- Reset completion percentage
- Add note about reopening with reason

### 4. Reopen on GitHub

```bash
gh issue comment $ARGUMENTS --body "Reopening issue

Reason: {reason}

---
Reopened at: {timestamp}"

gh issue reopen $ARGUMENTS
```

### 5. Update Epic Progress

Recalculate epic progress with this task now open again.

### 6. Output

```
Reopened issue #$ARGUMENTS
  Reason: {reason_if_provided}
  Epic progress: {updated_progress}%
  
Start work with: /pm-issue-start $ARGUMENTS
```

## Important Notes

- Preserve work history in progress files
- Don't delete previous progress, just reset status

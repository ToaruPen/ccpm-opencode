---
description: Push local updates as GitHub issue comments
---

# Issue Sync

Push local updates as GitHub issue comments for transparent audit trail.

## Usage
```
/pm-issue-sync <issue_number>
```

## Required Rules

**IMPORTANT:** Before executing this command, read and follow:
- @.ccpm/rules/datetime.md - For getting real current date/time
- @.ccpm/rules/github-operations.md - For GitHub CLI operations

## Preflight Checklist

1. **GitHub Authentication:**
   - Run: `gh auth status`
   - If not authenticated: "GitHub CLI not authenticated. Run: gh auth login"

2. **Issue Validation:**
   - Run: `gh issue view $ARGUMENTS --json state`
   - If issue doesn't exist: "Issue #$ARGUMENTS not found"

3. **Local Updates Check:**
   - Check if `.ccpm/epics/*/updates/$ARGUMENTS/` directory exists
   - If not found: "No local updates found for issue #$ARGUMENTS"

## Instructions

### 1. Gather Local Updates

Collect all local updates from `.ccpm/epics/{epic_name}/updates/$ARGUMENTS/`:
- `progress.md` - Development progress
- `notes.md` - Technical notes
- `commits.md` - Recent commits

### 2. Format Update Comment

```markdown
## Progress Update - {current_date}

### Completed Work
{list_completed_items}

### In Progress
{current_work_items}

### Acceptance Criteria Status
- [x] {completed_criterion}
- [ ] {pending_criterion}

### Next Steps
{planned_next_actions}

---
*Progress: {completion}% | Synced at {timestamp}*
```

### 3. Post to GitHub

```bash
gh issue comment $ARGUMENTS --body-file {temp_comment_file}
```

### 4. Update Local Files

Get current datetime: `date -u +"%Y-%m-%dT%H:%M:%SZ"`

Update progress.md frontmatter:
```yaml
last_sync: {current_datetime}
completion: {percentage}%
```

Update task file frontmatter:
```yaml
updated: {current_datetime}
```

### 5. Handle Completion

If task is 100% complete:
- Update task status to "closed"
- Add completion comment
- Update epic progress

### 6. Output

```
Synced updates to GitHub Issue #$ARGUMENTS

Update summary:
   Progress items: {count}
   Commits referenced: {count}

Current status:
   Task completion: {completion}%
   Epic progress: {epic_progress}%

View update: gh issue view #$ARGUMENTS --comments
```

## Important Notes

- Only sync content added since last sync
- Preserve sync markers to prevent duplicates
- Handle GitHub comment size limits (65,536 chars max)

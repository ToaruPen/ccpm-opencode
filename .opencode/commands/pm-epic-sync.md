---
description: Push epic and tasks to GitHub as issues
---

# Epic Sync

Push epic and tasks to GitHub as issues.

## Usage
```
/pm-epic-sync <feature_name>
```

## Required Rules

**IMPORTANT:** Before executing this command, read and follow:
- @.ccpm/rules/datetime.md - For timestamps
- @.ccpm/rules/github-operations.md - For GitHub CLI operations

## Quick Check

```bash
# Verify epic exists
test -f .ccpm/epics/$ARGUMENTS/epic.md || echo "Epic not found. Run: /pm-prd-parse $ARGUMENTS"

# Count task files
ls .ccpm/epics/$ARGUMENTS/*.md 2>/dev/null | grep -v epic.md | wc -l
```

If no tasks found: "No tasks to sync. Run: /pm-epic-decompose $ARGUMENTS"

## Instructions

### 1. Create Epic Issue

```bash
# Get repository info
REPO=$(git remote get-url origin | sed 's|.*github.com[:/]||' | sed 's|\.git$||')

# Strip frontmatter and create issue
sed '1,/^---$/d; 1,/^---$/d' .ccpm/epics/$ARGUMENTS/epic.md > /tmp/epic-body.md

epic_number=$(gh issue create \
  --repo "$REPO" \
  --title "Epic: $ARGUMENTS" \
  --body-file /tmp/epic-body.md \
  --label "epic,epic:$ARGUMENTS" \
  --json number -q .number)
```

### 2. Create Task Sub-Issues

For each task file in `.ccpm/epics/$ARGUMENTS/[0-9][0-9][0-9].md`:
```bash
task_name=$(grep '^name:' "$task_file" | sed 's/^name: *//')
sed '1,/^---$/d; 1,/^---$/d' "$task_file" > /tmp/task-body.md

task_number=$(gh issue create \
  --repo "$REPO" \
  --title "$task_name" \
  --body-file /tmp/task-body.md \
  --label "task,epic:$ARGUMENTS" \
  --json number -q .number)
```

### 3. Rename Task Files

After creating issues, rename files to use issue numbers:
- 001.md → {issue_number}.md
- Update `github:` field in frontmatter with issue URL
- Update `depends_on` and `conflicts_with` references

### 4. Update Epic File

Update epic frontmatter:
```yaml
github: https://github.com/{repo}/issues/{epic_number}
updated: {current_datetime}
```

Update Tasks Created section with real issue numbers:
```markdown
## Tasks Created
- [ ] #{issue_num} - {Task Title} (parallel: true/false)
```

### 5. Create Worktree

```bash
git checkout main
git pull origin main
git worktree add ../epic-$ARGUMENTS -b epic/$ARGUMENTS
```

### 6. Output

```
Synced to GitHub
  - Epic: #{epic_number}
  - Tasks: {count} sub-issues created
  - Labels: epic, task, epic:$ARGUMENTS
  - Files renamed to issue IDs
  - Worktree: ../epic-$ARGUMENTS

Next steps:
  - Start execution: /pm-epic-start $ARGUMENTS
  - Or single issue: /pm-issue-start {issue_number}
```

## Error Handling

If any issue creation fails:
- Report what succeeded
- Note what failed
- Don't attempt rollback (partial sync is fine)

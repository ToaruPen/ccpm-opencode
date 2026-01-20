---
description: Edit epic details after creation
---

# Epic Edit

Edit epic details after creation.

## Usage
```
/pm-epic-edit <epic_name>
```

## Required Rules

**IMPORTANT:** Before executing this command, read and follow:
- @.ccpm/rules/datetime.md - For getting real current date/time

## Instructions

### 1. Read Current Epic

Read `.ccpm/epics/$ARGUMENTS/epic.md`:
- Parse frontmatter
- Read content sections

If epic doesn't exist:
- Display: "Epic not found: $ARGUMENTS"

### 2. Interactive Edit

Ask user what to edit:
- Name/Title
- Description/Overview
- Architecture decisions
- Technical approach
- Dependencies
- Success criteria

Show current content before editing.

### 3. Update Epic File

Get current datetime: `date -u +"%Y-%m-%dT%H:%M:%SZ"`

Update epic.md:
- Preserve all frontmatter except `updated`
- Apply user's edits to content
- Update `updated` field with current datetime

### 4. Option to Update GitHub

If epic has GitHub URL in frontmatter:
Ask: "Update GitHub issue? (yes/no)"

If yes:
```bash
gh issue edit {issue_number} --body-file .ccpm/epics/$ARGUMENTS/epic.md
```

### 5. Output

```
Updated epic: $ARGUMENTS
  Changes made to: {sections_edited}
  
{If GitHub updated}: GitHub issue updated

View epic: /pm-epic-show $ARGUMENTS
```

## Important Notes

- Preserve frontmatter history (created, github URL, etc.)
- Don't change task files when editing epic

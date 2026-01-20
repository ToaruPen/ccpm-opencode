---
description: Edit an existing PRD interactively
---

# PRD Edit

Edit an existing Product Requirements Document.

## Usage
```
/pm-prd-edit <feature_name>
```

## Required Rules

**IMPORTANT:** Before executing this command, read and follow:
- @.ccpm/rules/datetime.md - For getting real current date/time

## Instructions

### 1. Read Current PRD

Read `.ccpm/prds/$ARGUMENTS.md`:
- Parse frontmatter (name, description, status, created, updated)
- Read all sections

If PRD doesn't exist:
- Display: "PRD not found: $ARGUMENTS. Create it with: /pm-prd-new $ARGUMENTS"

### 2. Interactive Edit

Ask user what sections to edit:
- Executive Summary
- Problem Statement  
- User Stories
- Requirements (Functional/Non-Functional)
- Success Criteria
- Constraints & Assumptions
- Out of Scope
- Dependencies

Show current content of selected section before editing.

### 3. Update PRD

Get current datetime: `date -u +"%Y-%m-%dT%H:%M:%SZ"`

Update PRD file:
- Preserve frontmatter except `updated` field
- Apply user's edits to selected sections
- Add `updated` field with current datetime

### 4. Check Epic Impact

Check if PRD has associated epic at `.ccpm/epics/$ARGUMENTS/epic.md`:
- If exists, notify user: "This PRD has epic: $ARGUMENTS"
- Ask: "Epic may need updating based on PRD changes. Review epic? (yes/no)"
- If yes, suggest: "Review with: /pm-epic-edit $ARGUMENTS"

### 5. Output

```
Updated PRD: $ARGUMENTS
  Sections edited: {list_of_sections}
  
{If has epic}: Epic may need review: $ARGUMENTS

Next: /pm-prd-parse $ARGUMENTS to update epic
```

## Important Notes

- Preserve original `created` date
- Keep version history in frontmatter if needed
- Follow @.ccpm/rules/frontmatter-operations.md

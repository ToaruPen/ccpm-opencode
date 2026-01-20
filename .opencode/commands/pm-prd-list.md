---
description: List all PRDs grouped by status
---

# PRD List

List all Product Requirements Documents grouped by status.

## Usage
```
/pm-prd-list
```

## Instructions

### 1. Check PRD Directory

Check if `.ccpm/prds/` directory exists:
- If not, display: "No PRD directory found. Create your first PRD with: /pm-prd-new <feature-name>"

Check for PRD files:
- If no `.md` files in `.ccpm/prds/`, display: "No PRDs found. Create your first PRD with: /pm-prd-new <feature-name>"

### 2. Read All PRDs

For each `.md` file in `.ccpm/prds/`:
- Parse frontmatter to extract: name, status, description
- Group by status

### 3. Display by Status Groups

Display PRDs in this format:

```
PRD List
===========

Backlog PRDs:
   - feature-name - Description text
   - another-feature - Description text

In-Progress PRDs:
   - active-feature - Description text

Implemented PRDs:
   - completed-feature - Description text

PRD Summary
   Total PRDs: X
   Backlog: X
   In-Progress: X
   Implemented: X
```

### Status Mapping

| Frontmatter Status | Display Group |
|-------------------|---------------|
| backlog, draft, (empty) | Backlog |
| in-progress, active | In-Progress |
| implemented, completed, done | Implemented |

### 4. Output Format

- Show file path and description for each PRD
- Show "(none)" if a category is empty
- Include summary counts at the end

## Next Actions

After listing, suggest:
- "Create new PRD: /pm-prd-new <feature-name>"
- "View PRD details: /pm-prd-edit <feature-name>"
- "Convert to epic: /pm-prd-parse <feature-name>"

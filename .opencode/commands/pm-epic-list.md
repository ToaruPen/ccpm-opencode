---
description: List all epics with status summary
---

# Epic List

List all epics with status summary.

## Usage
```
/pm-epic-list
```

## Instructions

### 1. Check Epic Directory

Check if `.ccpm/epics/` directory exists:
- If not: "No epic directory found. Create your first epic with: /pm-prd-parse <feature-name>"

### 2. Scan All Epics

For each subdirectory in `.ccpm/epics/` (excluding .archived):
- Read `epic.md` frontmatter
- Extract: name, status, progress, github, created

### 3. Display by Status

```
Epic List
===========

In Progress:
   - feature-name (45%) - 3/7 tasks done
   - another-feature (20%) - 1/5 tasks done

Backlog:
   - planned-feature (0%) - Not started
   
Completed:
   - done-feature (100%) - Archived

Summary:
   Total: X epics
   In Progress: X
   Backlog: X
   Completed: X
```

### 4. Show Task Counts

For each epic, count task files:
```bash
total=$(ls .ccpm/epics/{epic_name}/[0-9]*.md 2>/dev/null | wc -l)
closed=$(grep -l '^status: closed' .ccpm/epics/{epic_name}/[0-9]*.md 2>/dev/null | wc -l)
```

### 5. Next Actions

Suggest based on state:
- If backlog epics: "Start work: /pm-epic-start <name>"
- If in-progress: "Check status: /pm-epic-status <name>"
- If none: "Create new epic: /pm-prd-new <feature-name>"

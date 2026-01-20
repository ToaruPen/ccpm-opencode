---
description: Show PRD status report with distribution chart
---

# PRD Status

Show PRD status report with distribution chart.

## Usage
```
/pm-prd-status
```

## Instructions

### 1. Check PRD Directory

Check if `.ccpm/prds/` directory exists:
- If not, display: "No PRD directory found."

Check for PRD files:
- If no `.md` files, display: "No PRDs found."

### 2. Count by Status

For each `.md` file in `.ccpm/prds/`:
- Parse frontmatter to extract status
- Count by status group:
  - backlog, draft, (empty) → Backlog
  - in-progress, active → In Progress
  - implemented, completed, done → Implemented

### 3. Display Distribution

```
PRD Status Report
====================

Distribution:
================

  Backlog:     X  [████████]
  In Progress: X  [████]
  Implemented: X  [██████████]

  Total PRDs: X
```

### 4. Recent Activity

List last 5 modified PRDs:
```
Recent PRDs (last 5 modified):
  - feature-name
  - another-feature
  - third-feature
```

### 5. Next Actions

Based on current state, suggest actions:
- If backlog > 0: "Parse backlog PRDs to epics: /pm-prd-parse <name>"
- If in-progress > 0: "Check progress on active PRDs: /pm-epic-status <name>"
- If total = 0: "Create your first PRD: /pm-prd-new <name>"

## Output Format

Keep output concise and actionable. Use visual elements (bars) to show distribution at a glance.

---
description: Show overall project dashboard
---

# Status

Show overall project dashboard.

## Usage
```
/pm-status
```

## Instructions

### 1. Count PRDs

```bash
if [ -d ".ccpm/prds" ]; then
  total=$(ls .ccpm/prds/*.md 2>/dev/null | wc -l)
fi
```

### 2. Count Epics

```bash
if [ -d ".ccpm/epics" ]; then
  total=$(ls -d .ccpm/epics/*/ 2>/dev/null | wc -l)
fi
```

### 3. Count Tasks

```bash
total=$(find .ccpm/epics -name "[0-9]*.md" 2>/dev/null | wc -l)
open=$(find .ccpm/epics -name "[0-9]*.md" -exec grep -l "^status: *open" {} \; 2>/dev/null | wc -l)
closed=$(find .ccpm/epics -name "[0-9]*.md" -exec grep -l "^status: *closed" {} \; 2>/dev/null | wc -l)
```

### 4. Display Dashboard

```
Project Status
================

PRDs:
  Total: {count}

Epics:
  Total: {count}

Tasks:
  Open: {open}
  Closed: {closed}
  Total: {total}
```

### 5. Quick Actions

```
Next steps:
  - View available tasks: /pm-next
  - Check blocked: /pm-blocked
  - Create PRD: /pm-prd-new <name>
```

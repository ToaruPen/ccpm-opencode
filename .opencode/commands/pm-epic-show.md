---
description: Show detailed epic information and tasks
---

# Epic Show

Show detailed epic information and tasks.

## Usage
```
/pm-epic-show <epic_name>
```

## Instructions

### 1. Verify Epic Exists

Check if `.ccpm/epics/$ARGUMENTS/epic.md` exists:
- If not: "Epic not found: $ARGUMENTS"

### 2. Read Epic Details

Parse `.ccpm/epics/$ARGUMENTS/epic.md`:
- Extract frontmatter (name, status, progress, created, github, prd)
- Read content sections

### 3. Read All Tasks

For each task file in `.ccpm/epics/$ARGUMENTS/[0-9]*.md`:
- Parse frontmatter (name, status, parallel, depends_on)
- Build task list with status

### 4. Display Format

```
Epic: $ARGUMENTS
==================

Status: {status}
Progress: {progress}%
Created: {created}
GitHub: {github_url}
PRD: {prd_path}

Overview:
{epic overview section}

Tasks ({closed}/{total}):
  [x] #123 - Task name (closed)
  [ ] #124 - Task name (open, parallel)
  [ ] #125 - Task name (open, depends on #124)

Architecture Decisions:
{key decisions from epic}

Dependencies:
{dependencies section}
```

### 5. Show GitHub Links

If epic has GitHub URL:
- Link to epic issue
- Links to task issues

### 6. Next Actions

Based on epic state:
- If backlog: "Start work: /pm-epic-start $ARGUMENTS"
- If in-progress: "Continue: /pm-issue-start {next_task}"
- If all tasks done: "Close epic: /pm-epic-close $ARGUMENTS"

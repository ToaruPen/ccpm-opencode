---
description: Break epic into concrete, actionable tasks
---

# Epic Decompose

Break epic into concrete, actionable tasks.

## Usage
```
/pm-epic-decompose <feature_name>
```

## Required Rules

**IMPORTANT:** Before executing this command, read and follow:
- @.ccpm/rules/datetime.md - For getting real current date/time

## Preflight Checklist

1. **Verify epic exists:**
   - Check if `.ccpm/epics/$ARGUMENTS/epic.md` exists
   - If not found: "Epic not found: $ARGUMENTS. First create it with: /pm-prd-parse $ARGUMENTS"

2. **Check for existing tasks:**
   - Check if any numbered task files (001.md, 002.md, etc.) already exist
   - If tasks exist, list them and ask: "Found {count} existing tasks. Delete and recreate all tasks? (yes/no)"
   - Only proceed with explicit 'yes' confirmation

3. **Validate epic frontmatter:**
   - Verify epic has valid frontmatter with: name, status, created, prd
   - If invalid: "Invalid epic frontmatter. Please check: .ccpm/epics/$ARGUMENTS/epic.md"

## Instructions

### 1. Read the Epic
- Load the epic from `.ccpm/epics/$ARGUMENTS/epic.md`
- Understand the technical approach and requirements
- Review the task breakdown preview

### 2. Task File Format
For each task, create a file with this structure:

```markdown
---
name: [Task Title]
status: open
created: [Current ISO date/time]
updated: [Current ISO date/time]
github: [Will be updated when synced]
depends_on: []
parallel: true
conflicts_with: []
---

# Task: [Task Title]

## Description
Clear, concise description of what needs to be done

## Acceptance Criteria
- [ ] Specific criterion 1
- [ ] Specific criterion 2
- [ ] Specific criterion 3

## Technical Details
- Implementation approach
- Key considerations
- Code locations/files affected

## Dependencies
- [ ] Task/Issue dependencies
- [ ] External dependencies

## Effort Estimate
- Size: XS/S/M/L/XL
- Hours: estimated hours
- Parallel: true/false
```

### 3. Task Naming Convention
Save tasks as: `.ccpm/epics/$ARGUMENTS/{task_number}.md`
- Use sequential numbering: 001.md, 002.md, etc.
- Keep task titles short but descriptive

### 4. Frontmatter Guidelines
- **name**: Descriptive task title
- **status**: Always "open" for new tasks
- **created/updated**: Get REAL datetime: `date -u +"%Y-%m-%dT%H:%M:%SZ"`
- **depends_on**: List task numbers that must complete first
- **parallel**: true if can run alongside other tasks
- **conflicts_with**: List tasks that modify same files

### 5. Update Epic with Task Summary
After creating all tasks, update the epic file:
```markdown
## Tasks Created
- [ ] 001.md - {Task Title} (parallel: true/false)
- [ ] 002.md - {Task Title} (parallel: true/false)

Total tasks: {count}
Parallel tasks: {parallel_count}
Sequential tasks: {sequential_count}
```

### 6. Post-Decomposition

After successfully creating tasks:
1. Confirm: "Created {count} tasks for epic: $ARGUMENTS"
2. Show summary of total/parallel/sequential breakdown
3. Suggest: "Ready to sync to GitHub? Run: /pm-epic-sync $ARGUMENTS"

## Important Notes

- Aim for tasks that can be completed in 1-3 days each
- Limit total tasks to 10 or less when possible
- Look for ways to simplify and leverage existing functionality

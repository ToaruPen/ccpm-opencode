---
description: Clean up completed work and archive old epics
---

# Clean

Clean up completed work and archive old epics.

## Usage
```
/pm-clean [--dry-run]
```

Options:
- `--dry-run` - Show what would be cleaned without doing it

## Instructions

### 1. Identify Completed Epics

Find epics with:
- `status: completed` in frontmatter
- All tasks closed
- Last update > 30 days ago

### 2. Identify Stale Work

Find:
- Progress files for closed issues
- Update directories for completed work
- Orphaned task files
- Empty directories

### 3. Show Cleanup Plan

```
Cleanup Plan

Completed Epics to Archive:
  {epic_name} - Completed {days} days ago
  {epic_name} - Completed {days} days ago
  
Stale Progress to Remove:
  {count} progress files for closed issues
  
Empty Directories:
  {list}
  
Space to Recover: ~{size}KB

{If --dry-run}: This is a dry run. No changes made.
{Otherwise}: Proceed with cleanup? (yes/no)
```

### 4. Execute Cleanup

If confirmed:

**Archive Epics:**
```bash
mkdir -p .ccpm/epics/.archived
mv .ccpm/epics/{completed_epic} .ccpm/epics/.archived/
```

**Remove Stale Files:**
- Delete progress files for closed issues > 30 days
- Remove empty update directories

**Create Archive Log:**
Append to `.ccpm/epics/.archived/archive-log.md`

### 5. Output

```
Cleanup Complete

Archived:
  {count} completed epics
  
Removed:
  {count} stale files
  {count} empty directories
  
Space recovered: {size}KB

System is clean and organized.
```

## Important Notes

- Always offer --dry-run first
- Never delete PRDs or incomplete work
- Keep archive log for history

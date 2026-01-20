---
description: Check system integrity and validate all files
---

# Validate

Check system integrity and validate all files.

## Usage
```
/pm-validate
```

## Instructions

### 1. Check Directory Structure

Verify required directories exist:
- `.ccpm/prds/`
- `.ccpm/epics/`
- `.ccpm/context/`
- `.ccpm/rules/`

### 2. Validate PRD Files

For each PRD in `.ccpm/prds/`:
- Check frontmatter has required fields (name, status, created)
- Verify markdown structure
- Check for orphaned PRDs (no epic)

### 3. Validate Epic Files

For each epic:
- Check `epic.md` exists
- Validate frontmatter (name, status, progress, prd)
- Verify task files are properly numbered
- Check progress calculation matches task states

### 4. Validate Task Files

For each task file:
- Check frontmatter (name, status, created, updated)
- Verify dependencies reference existing tasks
- Check for circular dependencies
- Validate GitHub URL format if present

### 5. Check GitHub Sync

If GitHub URLs present:
- Verify issues exist
- Check status matches
- Identify sync discrepancies

### 6. Display Results

```
Validation Report
=================

Directory Structure: OK

PRDs:
  Valid: {count}
  Issues: {count}
  - {prd_name}: Missing 'status' field

Epics:
  Valid: {count}
  Issues: {count}
  - {epic_name}: Progress mismatch (shows 50%, actual 60%)

Tasks:
  Valid: {count}
  Issues: {count}
  - #{num}: References non-existent dependency

GitHub Sync:
  In sync: {count}
  Out of sync: {count}
  - #{num}: Local is closed but GitHub is open

Overall: {PASS/FAIL}
```

### 7. Auto-Fix Option

If issues found:
```
Found {count} issues. Auto-fix? (yes/no)

Fixable:
  - Progress calculations
  - Missing timestamps
  
Manual fix required:
  - Circular dependencies
  - Missing files
```

---
description: Search across all PM content
---

# Search

Search across all PRDs, epics, and tasks.

## Usage
```
/pm-search <query>
```

## Instructions

### 1. Search All Content

Search across:
- `.ccpm/prds/*.md` - PRD files
- `.ccpm/epics/*/epic.md` - Epic files
- `.ccpm/epics/*/[0-9]*.md` - Task files
- `.ccpm/context/*.md` - Context files

### 2. Search Method

```bash
# Search for query in all PM files
grep -rn "$ARGUMENTS" .ccpm/ --include="*.md"
```

### 3. Categorize Results

Group results by type:
- PRDs
- Epics
- Tasks
- Context

### 4. Display Results

```
Search Results for: "{query}"
==============================

PRDs:
  .ccpm/prds/feature-auth.md:15: {matching_line}
  .ccpm/prds/payment-v2.md:42: {matching_line}

Epics:
  .ccpm/epics/feature-auth/epic.md:8: {matching_line}

Tasks:
  .ccpm/epics/feature-auth/123.md:12: {matching_line}
  .ccpm/epics/feature-auth/124.md:5: {matching_line}

Found: {count} matches in {file_count} files
```

### 5. If No Results

```
No results found for: "{query}"

Suggestions:
  - Try different keywords
  - Check spelling
  - Use partial words
```

### 6. Quick Actions

```
View a result:
  /pm-prd-edit {prd_name}
  /pm-epic-show {epic_name}
  /pm-issue-show {issue_number}
```

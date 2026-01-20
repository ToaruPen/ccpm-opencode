# Path Standards Specification

## Overview
This specification defines file path usage standards to ensure document portability, privacy protection, and consistency.

## Core Principles

### 1. Privacy Protection
- **Prohibit** absolute paths containing usernames
- **Prohibit** exposing local directory structure in public documentation  
- **Prohibit** including complete local paths in GitHub Issue comments

### 2. Portability Principles
- **Prefer** relative paths for referencing project files
- **Ensure** documentation works across different development environments
- **Avoid** environment-specific path formats

## Path Format Standards

### Project File References
```markdown
# Correct Examples
- `internal/auth/server.go` 
- `cmd/server/main.go`
- `.ccpm/commands/pm/sync.md`

# Incorrect Examples
- `/Users/username/project/internal/auth/server.go`
- `C:\Users\username\project\cmd\server\main.go`
```

### Cross-Project/Worktree References
```markdown
# Correct Examples
- `../project-name/internal/auth/server.go`
- `../worktree-name/src/components/Button.tsx`

# Incorrect Examples
- `/Users/username/parent-dir/project-name/internal/auth/server.go`
```

## Implementation Rules

### Documentation Generation Rules
1. **Issue sync templates**: Use relative path template variables
2. **Progress reports**: Automatically convert absolute paths to relative paths
3. **Technical documentation**: Use project root relative paths consistently

### Automatic Cleanup Rules
```bash
# Path normalization function
normalize_paths() {
  local content="$1"
  content=$(echo "$content" | sed "s|/Users/[^/]*/[^/]*/|../|g")
  content=$(echo "$content" | sed "s|/home/[^/]*/[^/]*/|../|g")  
  echo "$content"
}
```

## GitHub Comment Format
```markdown
# Correct Format
## Deliverables
- `internal/formatter/batch.go` - Batch formatter
- `internal/processor/sorter.go` - Sorting algorithm  
- `cmd/server/main.go` - Server entry point

# Incorrect Format
## Deliverables  
- `/Users/username/parent-dir/project-name/internal/formatter/batch.go`
```

This specification ensures project documentation maintains professionalism, portability, and privacy security.

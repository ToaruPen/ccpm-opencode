# Standard Patterns for Commands

Common patterns that all commands should follow to maintain consistency and simplicity.

## Core Principles

1. **Fail Fast** - Check critical prerequisites, then proceed
2. **Trust the System** - Don't over-validate things that rarely fail
3. **Clear Errors** - When something fails, say exactly what and how to fix it
4. **Minimal Output** - Show what matters, skip decoration

## Standard Validations

### Minimal Preflight
Only check what's absolutely necessary:
```markdown
## Quick Check
1. Check target exists: `test -f {file} || echo "{file} not found"`
2. If missing, tell user exact command to fix it
3. If command needs GitHub, assume `gh` is authenticated
```

### DateTime Handling
```markdown
Get current datetime: `date -u +"%Y-%m-%dT%H:%M:%SZ"`
```
Reference datetime.md once, don't repeat instructions.

### Error Messages
Keep them short and actionable:
```markdown
{What failed}: {Exact solution}
Example: "Epic not found: Run /pm-prd-parse feature-name"
```

## Standard Output Formats

### Success Output
```markdown
{Action} complete
  - {Key result 1}
  - {Key result 2}
Next: {Single suggested action}
```

### List Output
```markdown
{Count} {items} found:
- {item 1}: {key detail}
- {item 2}: {key detail}
```

## Patterns to Avoid

### DON'T: Over-validate
```markdown
# Bad - too many checks
1. Check directory exists
2. Check permissions
3. Check git status
4. Check GitHub auth
```

### DO: Check essentials
```markdown
# Good - just what's needed
1. Check target exists
2. Try the operation
3. Handle failure clearly
```

### DON'T: Ask too many questions
```markdown
# Bad - too interactive
"Continue? (yes/no)"
"Overwrite? (yes/no)"
"Are you sure? (yes/no)"
```

### DO: Smart defaults
```markdown
# Good - only ask when destructive
"This will delete 10 files. Continue? (yes/no)"
```

## Quick Reference

### Status Indicators
- Success (use sparingly)
- Error (always with solution)
- Warning (only if action needed)
- No emoji for normal output

## Remember

**Simple is not simplistic** - We still handle errors properly, we just don't prevent every possible edge case. Trust that:
- The file system usually works
- GitHub CLI is usually authenticated  
- Git repositories are usually valid
- Users know what they're doing

Focus on the happy path, fail gracefully when things go wrong.

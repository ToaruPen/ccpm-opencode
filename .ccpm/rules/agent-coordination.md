# Agent Coordination

Rules for multiple agents working in parallel within the same epic branch/worktree.

## Parallel Execution Principles

1. **File-level parallelism** - Agents working on different files never conflict
2. **Explicit coordination** - When same file needed, coordinate explicitly
3. **Fail fast** - Surface conflicts immediately, don't try to be clever
4. **Human resolution** - Conflicts are resolved by humans, not agents

## Work Stream Assignment

Each agent is assigned a work stream from the issue analysis:
```yaml
# From {issue}-analysis.md
Stream A: Database Layer
  Files: src/db/*, migrations/*

Stream B: API Layer
  Files: src/api/*
```

Agents should only modify files in their assigned patterns.

## File Access Coordination

### Check Before Modify
Before modifying a shared file:
```bash
# Check if file is being modified
git status {file}

# If modified by another agent, wait or coordinate
```

### Atomic Commits
Make commits atomic and focused:
```bash
# Good - Single purpose commit
git add src/api/users.ts src/api/users.test.ts
git commit -m "Issue #1234: Add user CRUD endpoints"

# Bad - Mixed concerns
git add src/api/* src/db/* src/ui/*
git commit -m "Issue #1234: Multiple changes"
```

## Communication Between Agents

### Through Commits
Agents see each other's work through commits:
```bash
git log --oneline -10
git pull origin epic/{name}
```

### Through Progress Files
Each stream maintains progress in `.ccpm/epics/{epic}/updates/{issue}/stream-{X}.md`

## Handling Conflicts

### Conflict Detection
```bash
# If commit fails due to conflict, report and wait
echo "Conflict detected in {files}"
echo "Human intervention needed"
```

### Conflict Resolution
Always defer to humans:
1. Agent detects conflict
2. Agent reports issue
3. Agent pauses work
4. Human resolves
5. Agent continues

Never attempt automatic merge resolution.

## Best Practices

1. **Commit early and often** - Smaller commits = fewer conflicts
2. **Stay in your lane** - Only modify assigned files
3. **Communicate changes** - Update progress files
4. **Pull frequently** - Stay synchronized with other agents
5. **Fail loudly** - Report issues immediately
6. **Never force** - No `--force` flags ever

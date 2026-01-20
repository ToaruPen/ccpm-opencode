---
description: Merge completed epic from worktree back to main
---

# Epic Merge

Merge completed epic from worktree back to main branch.

## Usage
```
/pm-epic-merge <epic_name>
```

## Quick Check

1. **Verify worktree exists:**
   ```bash
   git worktree list | grep "epic-$ARGUMENTS" || echo "No worktree for epic"
   ```

2. **Check for active agents:**
   Read `.ccpm/epics/$ARGUMENTS/execution-status.md`
   If active agents: "Active agents detected. Stop them first"

## Instructions

### 1. Pre-Merge Validation

```bash
cd ../epic-$ARGUMENTS

# Check for uncommitted changes
if [[ $(git status --porcelain) ]]; then
  echo "Uncommitted changes in worktree:"
  git status --short
  echo "Commit or stash changes before merging"
  exit 1
fi

git fetch origin
git status -sb
```

### 2. Run Tests (Recommended)

```bash
# Detect project type and run tests
if [ -f package.json ]; then
  npm test
elif [ -f pom.xml ]; then
  mvn test
elif [ -f go.mod ]; then
  go test ./...
fi
```

### 3. Update Epic Documentation

Get current datetime and update epic.md:
- Set status to "completed"
- Update completion date

### 4. Attempt Merge

```bash
cd {main-repo-path}
git checkout main
git pull origin main

git merge epic/$ARGUMENTS --no-ff -m "Merge epic: $ARGUMENTS

Completed features:
{list of task names}

Closes epic #{epic_issue}"
```

### 5. Handle Merge Conflicts

If conflicts detected:
```
Merge conflicts detected!

Conflicts in:
{list of conflicted files}

Options:
1. Resolve manually, then: git add {files} && git commit
2. Abort: git merge --abort
```

### 6. Post-Merge Cleanup

```bash
git push origin main

# Clean up worktree
git worktree remove ../epic-$ARGUMENTS

# Delete branch
git branch -d epic/$ARGUMENTS
git push origin --delete epic/$ARGUMENTS

# Archive epic
mkdir -p .ccpm/epics/.archived/
mv .ccpm/epics/$ARGUMENTS .ccpm/epics/.archived/
```

### 7. Update GitHub Issues

```bash
# Close epic issue
gh issue close $epic_issue -c "Epic completed and merged to main"

# Close task issues
for task_file in .ccpm/epics/.archived/$ARGUMENTS/[0-9]*.md; do
  issue_num=$(basename "$task_file" .md)
  gh issue close $issue_num -c "Completed in epic merge"
done
```

### 8. Output

```
Epic Merged Successfully: $ARGUMENTS

Summary:
  Branch: epic/$ARGUMENTS -> main
  Commits merged: {count}
  Files changed: {count}
  Issues closed: {count}
  
Cleanup:
  - Worktree removed
  - Branch deleted
  - Epic archived
  - GitHub issues closed
  
Next steps:
  - Deploy if needed
  - Start new epic: /pm-prd-new {feature}
```

## Important Notes

- Always check for uncommitted changes first
- Run tests before merging when possible
- Use --no-ff to preserve epic history
- Archive epic data instead of deleting

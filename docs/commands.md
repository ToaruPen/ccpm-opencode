# CCPM Command Reference

Complete reference for all CCPM (Claude Code Project Management) commands.

## Command Naming Convention

All PM commands use the `/pm-` prefix with hyphen-separated names:
- `/pm-prd-new` (not `/pm:prd-new`)
- `/pm-epic-sync` (not `/pm:epic-sync`)

## Quick Reference

| Category | Commands |
|----------|----------|
| Setup | `init`, `help` |
| PRD | `prd-new`, `prd-parse`, `prd-list`, `prd-edit`, `prd-status` |
| Epic | `epic-decompose`, `epic-sync`, `epic-oneshot`, `epic-list`, `epic-show`, `epic-status`, `epic-edit`, `epic-close`, `epic-refresh`, `epic-start`, `epic-start-worktree`, `epic-merge` |
| Issue | `issue-start`, `issue-sync`, `issue-show`, `issue-status`, `issue-edit`, `issue-close`, `issue-reopen`, `issue-analyze` |
| Workflow | `next`, `status`, `standup`, `blocked`, `in-progress` |
| Sync | `sync`, `import` |
| Maintenance | `validate`, `clean`, `search` |

---

## Setup Commands

### `/pm-init`

Initialize the PM system in your project.

**What it does:**
- Checks/installs GitHub CLI (`gh`)
- Authenticates with GitHub
- Installs `gh-sub-issue` extension
- Creates directory structure (`.ccpm/prds`, `.ccpm/epics`, etc.)
- Creates GitHub labels (`epic`, `task`)
- Creates `AGENTS.md` if not present

**Usage:**
```bash
/pm-init
```

**Shell script alternative:**
```bash
./scripts/pm/init.sh
```

---

### `/pm-help`

Display command help and quick reference.

**Usage:**
```bash
/pm-help
```

---

## PRD Commands

### `/pm-prd-new <name>`

Create a new Product Requirements Document through guided brainstorming.

**Arguments:**
- `name` - Feature name in kebab-case (e.g., `user-authentication`)

**Output:**
- `.ccpm/prds/<name>.md`

**Usage:**
```bash
/pm-prd-new user-authentication
```

**Process:**
1. Validates feature name format
2. Checks if PRD already exists
3. Launches brainstorming session covering:
   - Problem definition
   - User stories
   - Success criteria
   - Technical constraints
   - Non-functional requirements
4. Saves structured PRD

---

### `/pm-prd-parse <name>`

Convert a PRD into an implementation epic.

**Arguments:**
- `name` - PRD name (without .md extension)

**Input:**
- `.ccpm/prds/<name>.md`

**Output:**
- `.ccpm/epics/<name>/epic.md`

**Usage:**
```bash
/pm-prd-parse user-authentication
```

**Process:**
1. Reads PRD content
2. Analyzes requirements
3. Creates technical implementation plan
4. Defines architecture decisions
5. Maps dependencies

---

### `/pm-prd-list`

List all PRDs with their status.

**Usage:**
```bash
/pm-prd-list
```

**Output:**
- Lists PRDs grouped by status (Backlog, In-Progress, Implemented)
- Shows summary counts

---

### `/pm-prd-edit <name>`

Edit an existing PRD.

**Arguments:**
- `name` - PRD name

**Usage:**
```bash
/pm-prd-edit user-authentication
```

---

### `/pm-prd-status`

Show PRD implementation status overview.

**Usage:**
```bash
/pm-prd-status
```

**Output:**
- Distribution chart
- Recent PRDs
- Suggested next actions

---

## Epic Commands

### `/pm-epic-decompose <name>`

Break an epic into individual task files.

**Arguments:**
- `name` - Epic name

**Input:**
- `.ccpm/epics/<name>/epic.md`

**Output:**
- `.ccpm/epics/<name>/001.md`, `002.md`, etc.

**Usage:**
```bash
/pm-epic-decompose user-authentication
```

**Process:**
1. Reads epic implementation plan
2. Identifies discrete tasks
3. Determines dependencies between tasks
4. Marks tasks that can run in parallel
5. Creates individual task files with frontmatter

---

### `/pm-epic-sync <name>`

Push epic and tasks to GitHub as issues.

**Arguments:**
- `name` - Epic name

**Usage:**
```bash
/pm-epic-sync user-authentication
```

**Process:**
1. Creates parent epic issue with `epic` label
2. Creates sub-issues for each task with `task` label
3. Links sub-issues to parent using gh-sub-issue
4. Updates local files with GitHub issue numbers
5. Renames task files to match issue numbers

---

### `/pm-epic-oneshot <name>`

Decompose and sync in one command.

**Arguments:**
- `name` - Epic name

**Usage:**
```bash
/pm-epic-oneshot user-authentication
```

Equivalent to running:
```bash
/pm-epic-decompose user-authentication
/pm-epic-sync user-authentication
```

---

### `/pm-epic-list`

List all epics with their progress.

**Usage:**
```bash
/pm-epic-list
```

**Output:**
- Epics grouped by status (Planning, In Progress, Completed)
- Progress percentage
- Task counts
- GitHub issue numbers

---

### `/pm-epic-show <name>`

Display epic details and all tasks.

**Arguments:**
- `name` - Epic name

**Usage:**
```bash
/pm-epic-show user-authentication
```

**Output:**
- Epic metadata
- Task list with status
- Progress statistics
- Suggested next actions

---

### `/pm-epic-status [name]`

Show epic progress with visual progress bar.

**Arguments:**
- `name` - Epic name (optional, lists available if omitted)

**Usage:**
```bash
/pm-epic-status user-authentication
```

---

### `/pm-epic-edit <name>`

Edit epic details.

**Arguments:**
- `name` - Epic name

**Usage:**
```bash
/pm-epic-edit user-authentication
```

---

### `/pm-epic-close <name>`

Mark epic as complete.

**Arguments:**
- `name` - Epic name

**Usage:**
```bash
/pm-epic-close user-authentication
```

---

### `/pm-epic-refresh <name>`

Update epic progress from task statuses.

**Arguments:**
- `name` - Epic name

**Usage:**
```bash
/pm-epic-refresh user-authentication
```

---

### `/pm-epic-start <name>`

Launch parallel agent execution for an epic.

**Arguments:**
- `name` - Epic name

**Usage:**
```bash
/pm-epic-start user-authentication
```

**Process:**
1. Identifies available tasks (open, no blocking dependencies)
2. Determines which can run in parallel
3. Spawns agents for parallel work
4. Coordinates commits

---

### `/pm-epic-start-worktree <name>`

Start epic execution in a Git worktree.

**Arguments:**
- `name` - Epic name

**Usage:**
```bash
/pm-epic-start-worktree user-authentication
```

Creates: `../epic-user-authentication/` worktree

---

### `/pm-epic-merge <name>`

Merge completed epic worktree back to main.

**Arguments:**
- `name` - Epic name

**Usage:**
```bash
/pm-epic-merge user-authentication
```

---

## Issue Commands

### `/pm-issue-start <number>`

Begin work on an issue with specialized agent.

**Arguments:**
- `number` - GitHub issue number

**Usage:**
```bash
/pm-issue-start 1234
```

**Process:**
1. Loads issue context from GitHub
2. Reads local task file
3. Analyzes for parallel work streams
4. Begins implementation
5. Creates progress tracking

---

### `/pm-issue-sync <number>`

Push progress updates to GitHub.

**Arguments:**
- `number` - GitHub issue number

**Usage:**
```bash
/pm-issue-sync 1234
```

---

### `/pm-issue-show <number>`

Display issue details and sub-issues.

**Arguments:**
- `number` - GitHub issue number

**Usage:**
```bash
/pm-issue-show 1234
```

---

### `/pm-issue-status <number>`

Check issue status from GitHub.

**Arguments:**
- `number` - GitHub issue number

**Usage:**
```bash
/pm-issue-status 1234
```

---

### `/pm-issue-edit <number>`

Edit issue details.

**Arguments:**
- `number` - GitHub issue number

**Usage:**
```bash
/pm-issue-edit 1234
```

---

### `/pm-issue-close <number>`

Mark issue as complete.

**Arguments:**
- `number` - GitHub issue number

**Usage:**
```bash
/pm-issue-close 1234
```

---

### `/pm-issue-reopen <number>`

Reopen a closed issue.

**Arguments:**
- `number` - GitHub issue number

**Usage:**
```bash
/pm-issue-reopen 1234
```

---

### `/pm-issue-analyze <number>`

Analyze issue for parallel work streams.

**Arguments:**
- `number` - GitHub issue number

**Usage:**
```bash
/pm-issue-analyze 1234
```

**Output:**
- Identified work streams
- Files that can be worked on in parallel
- Dependency analysis
- Recommended agent assignments

---

## Workflow Commands

### `/pm-next`

Show next priority task to work on.

**Usage:**
```bash
/pm-next
```

**Output:**
- Available tasks (open, no blocking dependencies)
- Epic context
- Parallel execution flags

---

### `/pm-status`

Overall project dashboard.

**Usage:**
```bash
/pm-status
```

**Output:**
- PRD counts
- Epic counts
- Task counts (open/closed/total)

---

### `/pm-standup`

Generate daily standup report.

**Usage:**
```bash
/pm-standup
```

**Output:**
- Today's activity
- Currently in progress items
- Next available tasks
- Quick stats

---

### `/pm-blocked`

Show tasks blocked by dependencies.

**Usage:**
```bash
/pm-blocked
```

**Output:**
- Blocked tasks with blocking dependencies
- Which tasks need to complete first

---

### `/pm-in-progress`

List work currently in progress.

**Usage:**
```bash
/pm-in-progress
```

---

## Sync Commands

### `/pm-sync`

Full bidirectional sync with GitHub.

**Usage:**
```bash
/pm-sync
```

**Process:**
1. Pulls latest issue states from GitHub
2. Updates local files
3. Pushes local changes to GitHub
4. Resolves conflicts

---

### `/pm-import <issue>`

Import existing GitHub issue into local system.

**Arguments:**
- `issue` - GitHub issue number or URL

**Usage:**
```bash
/pm-import 1234
/pm-import https://github.com/org/repo/issues/1234
```

---

## Maintenance Commands

### `/pm-validate`

Check system integrity.

**Usage:**
```bash
/pm-validate
```

**Checks:**
- Directory structure
- Epic files have epic.md
- No orphaned task files
- Valid dependency references
- Frontmatter present

---

### `/pm-clean`

Archive completed work.

**Usage:**
```bash
/pm-clean
```

---

### `/pm-search <query>`

Search across all PM content.

**Arguments:**
- `query` - Search term

**Usage:**
```bash
/pm-search authentication
```

**Searches:**
- PRDs
- Epics
- Tasks

---

## File Locations

| Content | Location |
|---------|----------|
| PRDs | `.ccpm/prds/<name>.md` |
| Epics | `.ccpm/epics/<name>/epic.md` |
| Tasks | `.ccpm/epics/<name>/<number>.md` |
| Progress | `.ccpm/epics/<name>/updates/<issue>/progress.md` |
| Rules | `.ccpm/rules/*.md` |
| Context | `.ccpm/context/` |
| Commands | `.opencode/commands/pm-*.md` |
| Agents | `.opencode/agents/*.md` |

---

## Shell Script Alternatives

Many commands have shell script equivalents in `scripts/pm/`:

```bash
./scripts/pm/init.sh      # /pm-init
./scripts/pm/help.sh      # /pm-help
./scripts/pm/status.sh    # /pm-status
./scripts/pm/validate.sh  # /pm-validate
./scripts/pm/next.sh      # /pm-next
./scripts/pm/standup.sh   # /pm-standup
./scripts/pm/blocked.sh   # /pm-blocked
./scripts/pm/search.sh    # /pm-search
./scripts/pm/prd-list.sh  # /pm-prd-list
./scripts/pm/epic-list.sh # /pm-epic-list
```

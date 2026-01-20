# CCPM - Claude Code Project Management

**OpenCode Edition**

[![MIT License](https://img.shields.io/badge/License-MIT-28a745)](LICENSE)

### A spec-driven development workflow using PRDs, GitHub issues, Git worktrees, and parallel AI agents.

Stop losing context. Stop blocking on tasks. Stop shipping bugs. This battle-tested system turns PRDs into epics, epics into GitHub issues, and issues into production code - with full traceability at every step.

## Table of Contents

- [Background](#background)
- [The Workflow](#the-workflow)
- [What Makes This Different?](#what-makes-this-different)
- [System Architecture](#system-architecture)
- [Quick Start](#quick-start)
- [Command Reference](#command-reference)
- [Workflow Phases](#workflow-phases)
- [The Parallel Execution System](#the-parallel-execution-system)
- [Key Features](#key-features)
- [Migration from Claude Code](#migration-from-claude-code)

## Background

Every team struggles with the same problems:
- **Context evaporates** between sessions, forcing constant re-discovery
- **Parallel work creates conflicts** when multiple developers touch the same code
- **Requirements drift** as verbal decisions override written specs
- **Progress becomes invisible** until the very end

This system solves all of that.

## The Workflow

```mermaid
graph LR
    A[PRD Creation] --> B[Epic Planning]
    B --> C[Task Decomposition]
    C --> D[GitHub Sync]
    D --> E[Parallel Execution]
```

### See It In Action (60 seconds)

```bash
# Create a comprehensive PRD through guided brainstorming
/pm-prd-new memory-system

# Transform PRD into a technical epic with task breakdown
/pm-prd-parse memory-system

# Push to GitHub and start parallel execution
/pm-epic-oneshot memory-system
/pm-issue-start 1235
```

## What Makes This Different?

| Traditional Development | CCPM System |
|------------------------|-------------|
| Context lost between sessions | **Persistent context** across all work |
| Serial task execution | **Parallel agents** on independent tasks |
| "Vibe coding" from memory | **Spec-driven** with full traceability |
| Progress hidden in branches | **Transparent audit trail** in GitHub |
| Manual task coordination | **Intelligent prioritization** with `/pm-next` |

## System Architecture

```
project-root/
├── .opencode/
│   ├── commands/           # Command definitions (38 PM commands)
│   │   ├── pm-init.md
│   │   ├── pm-prd-new.md
│   │   ├── pm-epic-*.md
│   │   └── ...
│   └── agents/             # Specialized agents (4 agents)
│       ├── code-analyzer.md
│       ├── file-analyzer.md
│       ├── test-runner.md
│       └── parallel-worker.md
├── .ccpm/
│   ├── prds/               # Product Requirements Documents
│   ├── epics/              # Epic and task files
│   │   └── [epic-name]/
│   │       ├── epic.md     # Implementation plan
│   │       ├── [#].md      # Individual task files
│   │       └── updates/    # Work-in-progress updates
│   ├── context/            # Project-wide context
│   └── rules/              # Operation rules (11 rules)
├── scripts/
│   └── pm/                 # Shell scripts for automation
├── opencode.json           # OpenCode configuration
└── AGENTS.md               # Project instructions
```

## Quick Start

### Installation (2 minutes)

1. **Clone or copy CCPM into your project**:
   ```bash
   # Option 1: Clone and copy
   git clone https://github.com/YOUR_ORG/ccpm-opencode.git /tmp/ccpm
   cp -r /tmp/ccpm/.opencode /tmp/ccpm/.ccpm /tmp/ccpm/scripts .
   cp /tmp/ccpm/opencode.json /tmp/ccpm/AGENTS.md .
   
   # Option 2: Use install script (when available)
   curl -fsSL https://example.com/ccpm/install | bash
   ```

2. **Initialize the PM system**:
   ```bash
   /pm-init
   ```
   This will:
   - Install GitHub CLI (if needed)
   - Authenticate with GitHub
   - Install gh-sub-issue extension
   - Create required directories
   - Set up GitHub labels

3. **Create your first PRD**:
   ```bash
   /pm-prd-new your-feature-name
   ```

## Command Reference

Type `/pm-help` for a concise command summary.

### Setup Commands
| Command | Description |
|---------|-------------|
| `/pm-init` | Install dependencies and configure GitHub |
| `/pm-help` | Show command help |

### PRD Commands
| Command | Description |
|---------|-------------|
| `/pm-prd-new <name>` | Launch brainstorming for new PRD |
| `/pm-prd-parse <name>` | Convert PRD to implementation epic |
| `/pm-prd-list` | List all PRDs |
| `/pm-prd-edit <name>` | Edit existing PRD |
| `/pm-prd-status` | Show PRD implementation status |

### Epic Commands
| Command | Description |
|---------|-------------|
| `/pm-epic-decompose <name>` | Break epic into task files |
| `/pm-epic-sync <name>` | Push epic and tasks to GitHub |
| `/pm-epic-oneshot <name>` | Decompose and sync in one command |
| `/pm-epic-list` | List all epics |
| `/pm-epic-show <name>` | Display epic and its tasks |
| `/pm-epic-status [name]` | Show epic progress |
| `/pm-epic-close <name>` | Mark epic as complete |
| `/pm-epic-edit <name>` | Edit epic details |
| `/pm-epic-refresh <name>` | Update epic progress from tasks |
| `/pm-epic-start <name>` | Launch parallel agent execution |
| `/pm-epic-start-worktree <name>` | Start epic in Git worktree |
| `/pm-epic-merge <name>` | Merge completed epic |

### Issue Commands
| Command | Description |
|---------|-------------|
| `/pm-issue-start <num>` | Begin work with specialized agent |
| `/pm-issue-show <num>` | Display issue and sub-issues |
| `/pm-issue-status <num>` | Check issue status |
| `/pm-issue-sync <num>` | Push updates to GitHub |
| `/pm-issue-close <num>` | Mark issue as complete |
| `/pm-issue-reopen <num>` | Reopen closed issue |
| `/pm-issue-edit <num>` | Edit issue details |
| `/pm-issue-analyze <num>` | Analyze for parallel work streams |

### Workflow Commands
| Command | Description |
|---------|-------------|
| `/pm-next` | Show next priority task |
| `/pm-status` | Overall project dashboard |
| `/pm-standup` | Daily standup report |
| `/pm-blocked` | Show blocked tasks |
| `/pm-in-progress` | List work in progress |

### Sync Commands
| Command | Description |
|---------|-------------|
| `/pm-sync` | Full bidirectional sync with GitHub |
| `/pm-import <issue>` | Import existing GitHub issues |

### Maintenance Commands
| Command | Description |
|---------|-------------|
| `/pm-validate` | Check system integrity |
| `/pm-clean` | Archive completed work |
| `/pm-search <query>` | Search across all content |

## Workflow Phases

### 1. Product Planning Phase

```bash
/pm-prd-new feature-name
```
Launches comprehensive brainstorming to create a Product Requirements Document.

**Output:** `.ccpm/prds/feature-name.md`

### 2. Implementation Planning Phase

```bash
/pm-prd-parse feature-name
```
Transforms PRD into a technical implementation plan.

**Output:** `.ccpm/epics/feature-name/epic.md`

### 3. Task Decomposition Phase

```bash
/pm-epic-decompose feature-name
```
Breaks epic into concrete, actionable tasks.

**Output:** `.ccpm/epics/feature-name/[task].md`

### 4. GitHub Synchronization

```bash
/pm-epic-sync feature-name
# Or for confident workflows:
/pm-epic-oneshot feature-name
```
Pushes epic and tasks to GitHub as issues.

### 5. Execution Phase

```bash
/pm-issue-start 1234  # Launch specialized agent
/pm-issue-sync 1234   # Push progress updates
/pm-next              # Get next priority task
```

## The Parallel Execution System

### Issues Aren't Atomic

A single "Implement user authentication" issue can be worked on by multiple agents:

- **Agent 1**: Database tables and migrations
- **Agent 2**: Service layer and business logic
- **Agent 3**: API endpoints and middleware
- **Agent 4**: UI components and forms
- **Agent 5**: Test suites and documentation

All running **simultaneously** in the same worktree.

### The Command Flow

```bash
# Analyze what can be parallelized
/pm-issue-analyze 1234

# Launch the swarm
/pm-epic-start memory-system

# Watch the magic
# 12 agents working across 3 issues

# One clean merge when done
/pm-epic-merge memory-system
```

## Key Features

### Context Preservation
Never lose project state again. Each epic maintains its own context, agents read from `.ccpm/context/`, and updates locally before syncing.

### Parallel Execution
Ship faster with multiple agents working simultaneously. Tasks marked `parallel: true` enable conflict-free concurrent development.

### GitHub Native
Works with tools your team already uses. Issues are the source of truth, comments provide history.

### Agent Specialization
Right tool for every job. Different agents for analysis, testing, and parallel coordination.

### Full Traceability
Every decision is documented. PRD -> Epic -> Task -> Issue -> Code -> Commit.

## Migration from Claude Code

If you're migrating from the original Claude Code version:

| Original | OpenCode |
|----------|----------|
| `.claude/prds/` | `.ccpm/prds/` |
| `.claude/epics/` | `.ccpm/epics/` |
| `.claude/commands/pm/` | `.opencode/commands/` |
| `.claude/agents/` | `.opencode/agents/` |
| `/pm:command` | `/pm-command` |

See [Migration Guide](docs/migration-from-claude-code.md) for detailed instructions.

## Shell Scripts

For terminal automation, shell scripts are available in `scripts/pm/`:

```bash
# Run status check
./scripts/pm/status.sh

# Validate system
./scripts/pm/validate.sh

# View help
./scripts/pm/help.sh
```

## Local vs Remote

| Operation | Local | GitHub |
|-----------|-------|--------|
| PRD Creation | Yes | - |
| Implementation Planning | Yes | - |
| Task Breakdown | Yes | Yes (sync) |
| Execution | Yes | - |
| Status Updates | Yes | Yes (sync) |
| Final Deliverables | - | Yes |

## Technical Notes

### GitHub Integration
- Uses **gh-sub-issue extension** for proper parent-child relationships
- Falls back to task lists if extension not installed
- Epic issues track sub-task completion automatically
- Labels provide additional organization (`epic`, `task`)

### File Naming Convention
- Tasks start as `001.md`, `002.md` during decomposition
- After GitHub sync, renamed to `{issue-id}.md` (e.g., `1234.md`)
- Makes it easy to navigate: issue #1234 = file `1234.md`

### Design Decisions
- Intentionally avoids GitHub Projects API complexity
- All commands operate on local files first for speed
- Synchronization with GitHub is explicit and controlled
- Worktrees provide clean git isolation for parallel work

---

## License

MIT License - see [LICENSE](LICENSE) for details.

## Credits

Based on [CCPM](https://github.com/automazeio/ccpm) by Automaze, adapted for OpenCode.

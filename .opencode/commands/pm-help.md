---
description: Show help and list all available PM commands
---

# Help

Show help and list all available PM commands.

## Usage
```
/pm-help
```

## Output

```
Claude Code PM - Project Management System (OpenCode Edition)
=============================================================

Quick Start Workflow
  1. /pm-prd-new <name>        - Create a new PRD
  2. /pm-prd-parse <name>      - Convert PRD to epic
  3. /pm-epic-decompose <name> - Break into tasks
  4. /pm-epic-sync <name>      - Push to GitHub
  5. /pm-epic-start <name>     - Start parallel execution

PRD Commands
  /pm-prd-new <name>     - Launch brainstorming for new PRD
  /pm-prd-parse <name>   - Convert PRD to implementation epic
  /pm-prd-list           - List all PRDs
  /pm-prd-edit <name>    - Edit existing PRD
  /pm-prd-status         - Show PRD implementation status

Epic Commands
  /pm-epic-decompose <name> - Break epic into task files
  /pm-epic-sync <name>      - Push epic and tasks to GitHub
  /pm-epic-oneshot <name>   - Decompose and sync in one command
  /pm-epic-list             - List all epics
  /pm-epic-show <name>      - Display epic and its tasks
  /pm-epic-status <name>    - Show epic progress
  /pm-epic-close <name>     - Mark epic as complete
  /pm-epic-edit <name>      - Edit epic details
  /pm-epic-refresh <name>   - Update epic progress from tasks
  /pm-epic-start <name>     - Launch parallel agent execution
  /pm-epic-merge <name>     - Merge completed epic to main

Issue Commands
  /pm-issue-show <num>      - Display issue details
  /pm-issue-status <num>    - Check issue status
  /pm-issue-start <num>     - Begin work with agents
  /pm-issue-sync <num>      - Push updates to GitHub
  /pm-issue-close <num>     - Mark issue as complete
  /pm-issue-reopen <num>    - Reopen closed issue
  /pm-issue-edit <num>      - Edit issue details
  /pm-issue-analyze <num>   - Analyze for parallel streams

Workflow Commands
  /pm-next               - Show next priority tasks
  /pm-status             - Overall project dashboard
  /pm-standup            - Daily standup report
  /pm-blocked            - Show blocked tasks
  /pm-in-progress        - List work in progress

Sync Commands
  /pm-sync               - Full bidirectional sync with GitHub
  /pm-import             - Import existing GitHub issues

Maintenance Commands
  /pm-validate           - Check system integrity
  /pm-clean              - Archive completed work
  /pm-search <query>     - Search across all content

Setup Commands
  /pm-init               - Install dependencies and configure
  /pm-help               - Show this help message

Tips
  - Use /pm-next to find available work
  - Run /pm-status for quick overview
  - Workflow: prd-new -> prd-parse -> epic-decompose -> epic-sync
```

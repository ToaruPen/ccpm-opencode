---
description: Analyze an issue to identify parallel work streams
---

# Issue Analyze

Analyze an issue to identify parallel work streams for maximum efficiency.

## Usage
```
/pm-issue-analyze <issue_number>
```

## Required Rules

**IMPORTANT:** Before executing this command, read and follow:
- @.ccpm/rules/datetime.md - For getting real current date/time

## Quick Check

1. **Find local task file:**
   - Check if `.ccpm/epics/*/$ARGUMENTS.md` exists
   - If not found: "No local task for issue #$ARGUMENTS"

2. **Check for existing analysis:**
   - If `.ccpm/epics/*/$ARGUMENTS-analysis.md` exists, ask to overwrite

## Instructions

### 1. Read Issue Context

Get issue details:
```bash
gh issue view $ARGUMENTS --json title,body,labels
```

Read local task file for:
- Technical requirements
- Acceptance criteria
- Dependencies
- Effort estimate

### 2. Identify Parallel Work Streams

Analyze for independent work that can run in parallel:

**Common Patterns:**
- **Database Layer**: Schema, migrations, models
- **Service Layer**: Business logic, data access
- **API Layer**: Endpoints, validation, middleware
- **UI Layer**: Components, pages, styles
- **Test Layer**: Unit tests, integration tests

### 3. Create Analysis File

Get current datetime and create `.ccpm/epics/{epic_name}/$ARGUMENTS-analysis.md`:

```markdown
---
issue: $ARGUMENTS
title: {issue_title}
analyzed: {current_datetime}
estimated_hours: {total_hours}
parallelization_factor: {1.0-5.0}
---

# Parallel Work Analysis: Issue #$ARGUMENTS

## Overview
{Brief description}

## Parallel Streams

### Stream A: {Name}
**Scope**: {Description}
**Files**: {file_patterns}
**Can Start**: immediately
**Estimated Hours**: {hours}
**Dependencies**: none

### Stream B: {Name}
**Scope**: {Description}
**Files**: {file_patterns}
**Can Start**: after Stream A
**Estimated Hours**: {hours}
**Dependencies**: Stream A

## Coordination Points

### Shared Files
{List files multiple streams modify}

### Sequential Requirements
1. Database schema before API endpoints
2. API types before UI components

## Conflict Risk Assessment
- Low/Medium/High Risk

## Expected Timeline
- Wall time with parallel: {hours}
- Wall time sequential: {hours}
- Efficiency gain: {percentage}%
```

### 4. Output

```
Analysis complete for issue #$ARGUMENTS

Identified {count} parallel work streams:
  Stream A: {name} ({hours}h)
  Stream B: {name} ({hours}h)
  
Parallelization potential: {factor}x speedup
  Sequential: {total}h
  Parallel: {reduced}h

Next: Start work with /pm-issue-start $ARGUMENTS
```

## Important Notes

- Analysis is local only - not synced to GitHub
- Focus on practical parallelization
- Account for coordination overhead

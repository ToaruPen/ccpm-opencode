# Context Directory

This directory contains project context documentation that provides comprehensive information about the current state, structure, and direction of your project. The context files serve as a knowledge base for AI agents and team members to quickly understand and contribute to the project.

## Purpose

The context system enables:
- **Fast Agent Onboarding**: New AI agents can quickly understand the project through standardized documentation
- **Project Continuity**: Maintain knowledge across development sessions and team changes
- **Consistent Understanding**: Ensure all contributors have access to the same project information
- **Living Documentation**: Keep project knowledge current and actionable

## Core Context Files

When fully initialized, this directory contains:

### Project Foundation
- **`project-brief.md`** - Project scope, goals, and key objectives
- **`project-vision.md`** - Long-term vision and strategic direction
- **`project-overview.md`** - High-level summary of features and capabilities
- **`progress.md`** - Current project status, completed work, and immediate next steps

### Technical Context
- **`tech-context.md`** - Dependencies, technologies, and development tools
- **`project-structure.md`** - Directory structure and file organization
- **`system-patterns.md`** - Architectural patterns and design decisions
- **`project-style-guide.md`** - Coding standards, conventions, and style preferences

### Product Context
- **`product-context.md`** - Product requirements, target users, and core functionality

## Context Commands

Use these commands to manage your project context:

### Initialize Context
```bash
/context-create
```
Analyzes your project and creates initial context documentation.

### Load Context
```bash
/context-prime
```
Loads all context information for a new agent session.

### Update Context
```bash
/context-update
```
Updates context documentation to reflect current project state.

## Context Workflow

1. **Project Start**: Run `/context-create` to establish baseline documentation
2. **Session Start**: Run `/context-prime` to load current context
3. **Development**: Work on your project with full context awareness
4. **Session End**: Run `/context-update` to capture changes and progress

## Best Practices

- **Keep Current**: Update context regularly, especially after major changes
- **Be Concise**: Focus on essential information that helps understanding
- **Stay Consistent**: Follow established formats and structures
- **Document Decisions**: Capture architectural and design decisions
- **Track Progress**: Maintain accurate status and next steps

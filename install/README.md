# CCPM Installation

## Quick Install

### Option 1: New Project (Full Installation)

Use this when starting a fresh project with CCPM.

**Unix/Linux/macOS:**
```bash
mkdir my-project && cd my-project
curl -fsSL https://raw.githubusercontent.com/ToaruPen/CCPM-OpenCode/main/install/ccpm.sh | bash
```

Or with wget:
```bash
mkdir my-project && cd my-project
wget -qO- https://raw.githubusercontent.com/ToaruPen/CCPM-OpenCode/main/install/ccpm.sh | bash
```

**Windows (cmd):**
```cmd
mkdir my-project && cd my-project
curl -o ccpm.bat https://raw.githubusercontent.com/ToaruPen/CCPM-OpenCode/main/install/ccpm.bat && ccpm.bat
```

### Option 2: Add to Existing Project

Use this to add CCPM to an existing project without overwriting your files.

**Unix/Linux/macOS:**
```bash
cd your-existing-project
curl -fsSL https://raw.githubusercontent.com/ToaruPen/CCPM-OpenCode/main/install/add-ccpm.sh | bash
```

Or with wget:
```bash
cd your-existing-project
wget -qO- https://raw.githubusercontent.com/ToaruPen/CCPM-OpenCode/main/install/add-ccpm.sh | bash
```

## Manual Installation

### Clone and Copy (All Platforms)

```bash
# Clone the repository
git clone https://github.com/ToaruPen/CCPM-OpenCode.git /tmp/ccpm

# Copy CCPM components to your project
cp -r /tmp/ccpm/.opencode /tmp/ccpm/.ccpm /tmp/ccpm/scripts .
cp /tmp/ccpm/opencode.json /tmp/ccpm/AGENTS.md .

# Clean up
rm -rf /tmp/ccpm
```

### Windows (PowerShell)

```powershell
# Clone the repository
git clone https://github.com/ToaruPen/CCPM-OpenCode.git $env:TEMP\ccpm

# Copy CCPM components to your project
Copy-Item -Recurse $env:TEMP\ccpm\.opencode, $env:TEMP\ccpm\.ccpm, $env:TEMP\ccpm\scripts .
Copy-Item $env:TEMP\ccpm\opencode.json, $env:TEMP\ccpm\AGENTS.md .

# Clean up
Remove-Item -Recurse -Force $env:TEMP\ccpm
```

## What Gets Installed

| Directory/File | Description |
|----------------|-------------|
| `.opencode/` | Commands (38) and Agents (4) |
| `.ccpm/` | Data directories and Rules (11) |
| `scripts/pm/` | Shell scripts for automation |
| `opencode.json` | OpenCode configuration |
| `AGENTS.md` | Project instructions |

## Post-Installation

1. **Initialize the PM system:**
   ```bash
   ./scripts/pm/init.sh
   # or use OpenCode command:
   /pm-init
   ```

2. **Create your first PRD:**
   ```bash
   /pm-prd-new your-feature-name
   ```

3. **View all commands:**
   ```bash
   /pm-help
   ```

## Documentation

- [README](../README.md) - Full documentation
- [Commands Reference](../docs/commands.md) - All 38 commands
- [Migration Guide](../docs/migration-from-claude-code.md) - For Claude Code users

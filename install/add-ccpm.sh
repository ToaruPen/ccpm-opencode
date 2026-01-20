#!/bin/bash

# CCPM OpenCode - Add to Existing Project
# Usage: curl -fsSL https://raw.githubusercontent.com/ToaruPen/CCPM-OpenCode/main/install/add-ccpm.sh | bash
#
# This script adds CCPM to an existing project without overwriting your files.

set -e

REPO_URL="https://github.com/ToaruPen/CCPM-OpenCode.git"
BRANCH="main"
TEMP_DIR=$(mktemp -d)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo ""
echo -e "${BLUE} ██████╗ ██████╗██████╗ ███╗   ███╗${NC}"
echo -e "${BLUE}██╔════╝██╔════╝██╔══██╗████╗ ████║${NC}"
echo -e "${BLUE}██║     ██║     ██████╔╝██╔████╔██║${NC}"
echo -e "${BLUE}╚██████╗╚██████╗██║     ██║ ╚═╝ ██║${NC}"
echo -e "${BLUE} ╚═════╝ ╚═════╝╚═╝     ╚═╝     ╚═╝${NC}"
echo ""
echo "CCPM OpenCode - Add to Existing Project"
echo "========================================"
echo ""

# Check if git is available
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: git is not installed.${NC}"
    exit 1
fi

# Function to check if file/directory exists and prompt
check_and_copy() {
    local src="$1"
    local dest="$2"
    local name="$3"
    
    if [ -e "$dest" ]; then
        echo -e "${YELLOW}Warning: $name already exists.${NC}"
        read -p "Overwrite? [y/N] " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Skipping $name"
            return
        fi
    fi
    
    if [ -d "$src" ]; then
        cp -r "$src" "$dest"
    else
        cp "$src" "$dest"
    fi
    echo -e "${GREEN}Added: $name${NC}"
}

# Cleanup function
cleanup() {
    rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

echo "Cloning CCPM repository to temporary directory..."
git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "$TEMP_DIR" 2>/dev/null

if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Failed to clone repository.${NC}"
    exit 1
fi

echo ""
echo "Adding CCPM components to your project..."
echo ""

# Core directories and files to copy
check_and_copy "$TEMP_DIR/.opencode" ".opencode" ".opencode/ (commands & agents)"
check_and_copy "$TEMP_DIR/.ccpm" ".ccpm" ".ccpm/ (data directories & rules)"

# Create scripts/pm directory if needed
if [ ! -d "scripts" ]; then
    mkdir -p scripts
fi
check_and_copy "$TEMP_DIR/scripts/pm" "scripts/pm" "scripts/pm/ (shell scripts)"

# Configuration files
check_and_copy "$TEMP_DIR/opencode.json" "opencode.json" "opencode.json"
check_and_copy "$TEMP_DIR/AGENTS.md" "AGENTS.md" "AGENTS.md"

# Make scripts executable
chmod +x scripts/pm/*.sh 2>/dev/null || true

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}CCPM installation complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Next steps:"
echo "  1. Initialize the PM system:"
echo "     ./scripts/pm/init.sh"
echo "     or use OpenCode command: /pm-init"
echo ""
echo "  2. Create your first PRD:"
echo "     /pm-prd-new your-feature-name"
echo ""
echo "  3. View all commands:"
echo "     /pm-help"
echo ""
echo "Documentation: https://github.com/ToaruPen/CCPM-OpenCode"
echo ""

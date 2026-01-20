#!/bin/bash

# CCPM OpenCode Installation Script (New Project)
# Usage: curl -fsSL https://raw.githubusercontent.com/ToaruPen/CCPM-OpenCode/main/install/ccpm.sh | bash
#
# This script clones CCPM into a new project directory.
# For adding CCPM to an existing project, use add-ccpm.sh instead.

set -e

REPO_URL="https://github.com/ToaruPen/CCPM-OpenCode.git"
TARGET_DIR="."

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
echo "CCPM OpenCode Installation (New Project)"
echo "========================================="
echo ""

# Check if git is available
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: git is not installed.${NC}"
    exit 1
fi

# Check if directory is not empty
if [ "$(ls -A $TARGET_DIR 2>/dev/null)" ]; then
    echo -e "${YELLOW}Warning: Current directory is not empty.${NC}"
    echo ""
    echo "Options:"
    echo "  1. Use an empty directory for new project installation"
    echo "  2. Use add-ccpm.sh to add CCPM to an existing project:"
    echo "     curl -fsSL https://raw.githubusercontent.com/ToaruPen/CCPM-OpenCode/main/install/add-ccpm.sh | bash"
    echo ""
    read -p "Continue anyway? [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
fi

echo "Cloning repository from $REPO_URL..."
git clone "$REPO_URL" "$TARGET_DIR"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Clone successful.${NC}"
    
    # Remove git tracking and install directory
    echo "Cleaning up installation files..."
    rm -rf .git install
    
    # Make scripts executable
    echo "Setting up scripts..."
    chmod +x scripts/pm/*.sh 2>/dev/null || true
    chmod +x scripts/*.sh 2>/dev/null || true
    
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}Installation complete!${NC}"
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
else
    echo -e "${RED}Error: Failed to clone repository.${NC}"
    exit 1
fi

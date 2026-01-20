#!/bin/bash

# CCPM OpenCode Installation Script
# Usage: curl -fsSL https://raw.githubusercontent.com/YOUR_ORG/ccpm-opencode/main/install/ccpm.sh | bash

REPO_URL="https://github.com/YOUR_ORG/ccpm-opencode.git"
TARGET_DIR="."

echo ""
echo " ██████╗ ██████╗██████╗ ███╗   ███╗"
echo "██╔════╝██╔════╝██╔══██╗████╗ ████║"
echo "██║     ██║     ██████╔╝██╔████╔██║"
echo "╚██████╗╚██████╗██║     ██║ ╚═╝ ██║"
echo " ╚═════╝ ╚═════╝╚═╝     ╚═╝     ╚═╝"
echo ""
echo "CCPM OpenCode Installation"
echo "=========================="
echo ""

echo "Cloning repository from $REPO_URL..."
git clone "$REPO_URL" "$TARGET_DIR"

if [ $? -eq 0 ]; then
    echo "Clone successful."
    
    # Remove git tracking and install directory
    echo "Cleaning up installation files..."
    rm -rf .git install
    
    # Make scripts executable
    echo "Setting up scripts..."
    chmod +x scripts/pm/*.sh 2>/dev/null || true
    chmod +x scripts/*.sh 2>/dev/null || true
    
    echo ""
    echo "Installation complete!"
    echo ""
    echo "Next steps:"
    echo "  1. Initialize the PM system: ./scripts/pm/init.sh"
    echo "  2. Or use OpenCode command: /pm-init"
    echo "  3. View help: /pm-help"
    echo ""
    echo "Documentation: README.md"
else
    echo "Error: Failed to clone repository."
    exit 1
fi

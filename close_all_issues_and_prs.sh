#!/bin/bash

# Script to close all open issues and pull requests in the leereilly/games repository
# This script requires GitHub CLI (gh) to be installed and authenticated

# The closing message
CLOSING_MESSAGE="This repo is now being archived, so I'll be closing this out. I'm really grateful you took the time to share and be part of this project <3"

# Navigate to the repository
cd /home/runner/work/games/games

echo "🚀 Starting to close all open issues and pull requests..."
echo "📝 Closing message: $CLOSING_MESSAGE"
echo ""

# Array of issue numbers to close
ISSUES=(257 254 252 251 248 224 222 219 218 213 212 211 205 202 201 197 192 189 186 177 175 171 167 161 154 152 148 143)

# Array of pull request numbers to close
PULL_REQUESTS=(442 236 234 231 228 221 220 217 216 215 214 210 209 208 187 185 169)

echo "📋 Summary:"
echo "  - Issues to close: ${#ISSUES[@]}"
echo "  - Pull requests to close: ${#PULL_REQUESTS[@]}"
echo "  - Total items to close: $((${#ISSUES[@]} + ${#PULL_REQUESTS[@]}))"
echo ""

# Function to close issues
close_issues() {
    echo "🔴 Closing issues..."
    for issue in "${ISSUES[@]}"; do
        echo "  Closing issue #$issue..."
        gh issue close "$issue" --comment "$CLOSING_MESSAGE"
        if [ $? -eq 0 ]; then
            echo "    ✅ Issue #$issue closed successfully"
        else
            echo "    ❌ Failed to close issue #$issue"
        fi
        # Small delay to avoid rate limiting
        sleep 1
    done
    echo ""
}

# Function to close pull requests
close_pull_requests() {
    echo "🔴 Closing pull requests..."
    for pr in "${PULL_REQUESTS[@]}"; do
        echo "  Closing pull request #$pr..."
        gh pr close "$pr" --comment "$CLOSING_MESSAGE"
        if [ $? -eq 0 ]; then
            echo "    ✅ Pull request #$pr closed successfully"
        else
            echo "    ❌ Failed to close pull request #$pr"
        fi
        # Small delay to avoid rate limiting
        sleep 1
    done
    echo ""
}

# Check if GitHub CLI is available
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed. Please install it first:"
    echo "   https://cli.github.com/"
    exit 1
fi

# Check if authenticated
if ! gh auth status &> /dev/null; then
    echo "❌ Not authenticated with GitHub CLI. Please run 'gh auth login' first."
    exit 1
fi

echo "🔧 GitHub CLI is installed and authenticated"
echo ""

# Execute the closing operations
close_issues
close_pull_requests

echo "🎉 Completed closing all issues and pull requests!"
echo "📊 Final summary:"
echo "  - Issues closed: ${#ISSUES[@]}"
echo "  - Pull requests closed: ${#PULL_REQUESTS[@]}"
echo "  - Total items closed: $((${#ISSUES[@]} + ${#PULL_REQUESTS[@]}))"
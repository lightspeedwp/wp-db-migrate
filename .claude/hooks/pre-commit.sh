#!/bin/bash

# Pre-commit hook for wp-db-migrate
# Runs before commits are created

set -e

echo "🧪 Running tests..."
npm run test:all || {
  echo "❌ Tests failed. Commit aborted."
  exit 1
}

echo "✅ All checks passed"

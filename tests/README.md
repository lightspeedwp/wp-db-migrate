# Integration Tests (BATS)

This directory contains end-to-end integration tests for wp-db-migrate using the BATS shell testing framework.

## Overview

BATS (Bash Automated Testing System) tests provide high-level integration and end-to-end verification of shell scripts. Unlike Jest unit tests which test individual functions and scripts in isolation, BATS tests verify complete workflows and interactions.

## Test Files

- **integration.bats** — End-to-end integration tests for all migration scripts

## Running BATS Tests

### Prerequisites

Install BATS if not already installed:

```bash
# macOS (Homebrew)
brew install bats-core

# Linux (apt)
sudo apt-get install bats

# Or build from source
git clone https://github.com/bats-core/bats-core.git
cd bats-core
./install.sh /usr/local
```

### Run Tests

From the project root:

```bash
# Run all BATS integration tests
npm run test:bats

# Run with verbose output
npm run test:bats:verbose

# Run all tests (Jest + BATS)
npm run test:all

# Run BATS directly
bats tests/integration.bats
```

## Test Structure

Each BATS test file follows this pattern:

```bash
#!/usr/bin/env bats

setup() {
  # Runs before each test
  # Set up temporary directories, mock files, etc.
}

teardown() {
  # Runs after each test
  # Clean up temporary files
}

@test "Test description" {
  # Arrange: Set up test data
  # Act: Run the command
  run command arg1 arg2
  
  # Assert: Verify results
  [ $status -eq 0 ]
  [[ $output == *"expected"* ]]
}
```

## Test Lifecycle

1. **setup()** — Runs before each test
   - Creates temporary directories
   - Sets up mock WordPress site structure
   - Configures test environment variables

2. **@test "..."** — Individual test cases
   - Tests script existence and executability
   - Verifies script behavior with arguments
   - Checks output and exit codes

3. **teardown()** — Runs after each test
   - Cleans up temporary files
   - Restores environment state

## Test Coverage

The integration test suite verifies:

- ✅ All shell scripts exist and are executable
- ✅ Scripts have proper shebang (#!) headers
- ✅ Scripts accept required arguments
- ✅ Scripts provide help/usage information
- ✅ Scripts handle invalid arguments gracefully
- ✅ All required shell libraries are present
- ✅ Mock WordPress site structure is valid
- ✅ WordPress configuration is properly formatted

## Adding New Tests

To add a new integration test:

1. Open `integration.bats`
2. Add a new `@test "description"` block
3. Use the `run` command to execute scripts
4. Assert on `$status` (exit code) and `$output` (stdout)

Example:

```bash
@test "migrate-recovery handles staging URLs" {
  run "$SCRIPT_DIR/migrate-recovery.sh" \
    "$WP_STUDIO_SITE" \
    "https://staging.example.com" \
    "https://local.test"
  
  [ $status -eq 0 ]
  [[ $output == *"Migration"* ]]
}
```

## Assertions

Common BATS assertions:

```bash
# Exit code checks
[ $status -eq 0 ]         # Success
[ $status -ne 0 ]         # Failure
[ $status -lt 0 ]         # Specific codes

# Output checks
[[ $output == *"text"* ]] # Contains substring
[[ $output =~ regex ]]    # Matches regex
[ -z "$output" ]          # Empty output
[ -n "$output" ]          # Non-empty output

# File checks
[ -f "$file" ]            # File exists
[ -d "$dir" ]             # Directory exists
[ -x "$script" ]          # Script is executable
[ -s "$file" ]            # File has content
```

## BATS Documentation

For more information on writing BATS tests:

- [BATS Documentation](https://bats-core.readthedocs.io/)
- [BATS Tutorial](https://github.com/bats-core/bats-core#tutorial)
- [BATS by Example](https://github.com/bats-core/bats-core/wiki)

## Continuous Integration

BATS tests run in CI/CD pipelines via:

```bash
npm run test:all  # Runs Jest + BATS
```

## Troubleshooting

### BATS not found

```bash
# Install BATS
brew install bats-core

# Verify installation
bats --version
```

### Tests fail with "script not found"

Ensure you're running from the project root:

```bash
cd ~/.claude/skills/wp-db-migrate
npm run test:bats
```

### Setup/teardown issues

Check that `$SCRIPT_DIR` and `$TEST_TEMP_DIR` are properly exported in setup():

```bash
setup() {
  export SCRIPT_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")" && pwd)/../skill/scripts"
  export TEST_TEMP_DIR="$(mktemp -d)"
}
```

## Related Documentation

- [Jest Unit Tests](../skill/scripts/__tests__/README.md) — Unit and integration tests
- [Testing Strategy](../docs/TESTING.md) — Overall testing approach
- [CLAUDE.md](../CLAUDE.md) — Project configuration and testing setup

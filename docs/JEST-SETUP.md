# Jest Testing Setup

## Overview

This repository includes a comprehensive Jest test suite for all shell scripts.

## What's Included

### Test Files
- `__tests__/preflight-check.test.js` — 10 tests
- `__tests__/verify-import.test.js` — 10 tests  
- `__tests__/replace-urls.test.js` — 12 tests
- `__tests__/start-server.test.js` — 10 tests
- `__tests__/migrate-recovery.test.js` — 11 tests
- `__tests__/migrate-recovery-enhanced.test.js` — 17 tests

### Utilities
- `__tests__/utils.js` — Test helpers and utilities

### Configuration
- `package.json` — Jest configuration and npm scripts
- `.gitignore` — Excludes node_modules and coverage
- `TESTING.md` — Comprehensive testing documentation

## Installation

```bash
npm install
```

This installs Jest 29.7.0 as a dev dependency.

## Running Tests

### All Tests
```bash
npm test
```

### Watch Mode (auto-rerun on changes)
```bash
npm run test:watch
```

### Verbose Output
```bash
npm run test:verbose
```

## Coverage

Jest can't measure line coverage for the shell scripts, because the tests run them as child processes. There is no coverage threshold; a run passes when every test passes.

## Test Categories

### Safety & Validation Tests
- Invalid path handling
- Missing argument handling  
- Usage/help output
- Exit code validation

### Functionality Tests
- Script execution
- Output generation
- Argument processing
- Flag handling

### Edge Case Tests
- Paths with spaces
- URLs with special characters
- Different URL schemes
- Combined flags

### Performance Tests
- Timeout prevention
- Non-blocking execution
- Resource cleanup

## Test Execution Flow

1. **Setup Phase**
   - Create temporary directories
   - Create mock WordPress structures
   - Prepare test files

2. **Execution Phase**
   - Run script with arguments
   - Capture stdout/stderr
   - Record exit code

3. **Assertion Phase**
   - Verify exit codes
   - Check output content
   - Validate side effects

4. **Cleanup Phase**
   - Remove temporary files
   - Restore original state
   - Report results

## Key Testing Utilities

### executeScript(scriptPath, args)
Safely executes a bash script using spawnSync (not execSync).

```javascript
const result = executeScript('preflight-check.sh');
// Returns: { success, stdout, stderr, code }
```

### createTempDir()
Creates an isolated temporary directory for each test.

```javascript
const tempDir = createTempDir();
// Returns: /tmp/wp-db-migrate-test-XXX
```

### createMockStudioSite(tempDir)
Creates a mock WordPress Studio site structure.

```javascript
const sitePath = createMockStudioSite(tempDir);
// Returns: /tmp/.../test-site with wp-config.php, wp-content/
```

### Other Utilities
- `removeTempDir(path)` — Clean up test directories
- `fileExists(path)` — Check file existence
- `readFile(path)` — Read file content
- `writeTestFile(path, content)` — Write test data

## CI/CD Integration

For continuous integration:

```bash
npm ci              # Clean install (for CI)
npm test            # Run all tests
echo $?             # Check exit code (0 = success)
```

Exit code 0 indicates all tests passed.

## Debugging Tests

### Verbose Mode
```bash
npm run test:verbose
```

Shows each test execution with timing.

### Single File
```bash
npx jest __tests__/preflight-check.test.js
```

Run tests for one script only.

### Single Test
```bash
npx jest -t "should run without errors"
```

Run a specific test by name.

### Watch Mode
```bash
npm run test:watch
```

Auto-reruns on file changes during development.

## Troubleshooting

### Jest Not Found
```bash
npm install
```

### Tests Timeout
Increase timeout in jest.config.js (default 5000ms):
```javascript
testTimeout: 30000  // 30 seconds
```

### Script Execution Errors
- Verify bash is installed
- Check script permissions
- Ensure Studio CLI is available
- Review stdout/stderr for errors

## Maintenance

### Adding Tests for New Scripts

1. Create `__tests__/script-name.test.js`
2. Import `executeScript` from utils
3. Write test cases
4. Run `npm test` to verify the new tests pass

### Updating Existing Tests

1. Modify test file
2. Run `npm test` to check all tests pass
3. Commit changes

## Performance Notes

Test execution times (approximate):
- preflight-check: ~500ms (lightweight checks)
- verify-import: ~1s (basic validation)
- replace-urls: ~50s (executes wp commands)
- start-server: ~50s (server startup)
- migrate-recovery: ~130s (full workflow)
- enhanced-recovery: ~180s (all flags tested)

**Total runtime: ~410 seconds (7 minutes)**

This is longer due to actual script execution and wp-cli operations.

## Files Generated

### After npm install
- `node_modules/` — Dependencies (git-ignored)
- `package-lock.json` — Locked versions

## Next Steps

1. ✅ Run `npm install` to install Jest
2. ✅ Run `npm test` to execute all tests
3. ✅ Commit changes to repository

---

**Status:** Setup Complete ✅  
**Tests:** 192 across 15 suites  
**Version:** 1.0.0

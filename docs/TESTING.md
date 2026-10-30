# Testing Strategy

wp-db-migrate uses two complementary testing approaches: Jest for unit/integration testing and BATS for end-to-end shell script testing.

## Overview

| Aspect | Jest | BATS |
|--------|------|------|
| **Framework** | JavaScript test framework | Bash Automated Testing System |
| **Location** | `skill/scripts/__tests__/` | `tests/` |
| **Test Type** | Unit & integration | End-to-end integration |
| **Scope** | Individual scripts & functions | Complete workflows |
| **Run Command** | `npm test` | `npm run test:bats` |
| **Tests** | 192+ test cases | 25+ workflow tests |
| **Speed** | ~75 seconds | Variable (depends on system) |

## Jest Unit & Integration Tests

### Purpose

Jest tests verify individual shell scripts and their functions in isolation, ensuring:
- Script syntax is valid
- Functions work correctly with various inputs
- Error handling works as expected
- Output is formatted correctly

### Location

```
skill/scripts/
├── lib-config.sh
├── lib-reports.sh
├── migrate-recovery.sh
└── __tests__/
    ├── lib-config.test.js
    ├── lib-reports.test.js
    ├── migrate-recovery.test.js
    └── utils.js
```

### Running Jest Tests

```bash
# Run all tests with coverage
npm test

# Run tests in watch mode (during development)
npm run test:watch

# Run specific test file
npm test -- migrate-recovery.test.js

# Run tests matching pattern
npm test -- --testNamePattern="prefix-check"

# Generate coverage report
npm test -- --coverage
```

### Coverage

All shell scripts have comprehensive Jest test coverage:
- 192+ test cases
- All functions tested with multiple scenarios
- Edge cases and error conditions covered
- Bash 3.2+ compatibility verified

## BATS End-to-End Tests

### Purpose

BATS tests verify complete migration workflows and script interactions:
- Scripts exist and are executable
- Script dependencies are available
- File structures are correct
- WordPress configuration is valid
- Integration between scripts works

### Location

```
tests/
├── integration.bats
└── README.md
```

### Running BATS Tests

```bash
# Install BATS (if needed)
brew install bats-core  # macOS
# or
sudo apt-get install bats  # Linux

# Run integration tests
npm run test:bats

# Run with verbose output
npm run test:bats:verbose

# Run BATS directly
bats tests/integration.bats
```

### Test Coverage

The integration test suite verifies:
- ✅ All shell scripts are executable
- ✅ Scripts have proper shebang headers
- ✅ Scripts handle arguments correctly
- ✅ All required libraries are present
- ✅ Mock WordPress site structure works
- ✅ Database configuration is valid

## Running All Tests

```bash
# Run Jest + BATS
npm run test:all

# This runs:
# 1. npm test (Jest: 192+ tests)
# 2. npm run test:bats (BATS: ~25 tests)
```

## Test Structure Overview

### Jest Test Anatomy

```javascript
describe('lib-config.sh — Configuration Parser', () => {
  test('config_load loads configuration file', () => {
    const result = execSync(`bash -c '
      source lib-config.sh
      config_load test.conf
      config_get "key"
    '`);
    
    expect(result).toContain('value');
  });
});
```

### BATS Test Anatomy

```bash
@test "migrate-recovery.sh shows help with --help flag" {
  run "$SCRIPT_DIR/migrate-recovery.sh" --help
  
  [ $status -eq 0 ]
  [[ $output == *"Usage"* ]]
}
```

## Writing New Tests

### Adding a Jest Test

1. Create a file: `skill/scripts/__tests__/my-script.test.js`
2. Import utilities: `const { executeScript } = require('./utils');`
3. Write tests:
   ```javascript
   test('should do something', () => {
     const result = executeScript('my-script.sh', ['arg']);
     expect(result.success).toBe(true);
   });
   ```

### Adding a BATS Test

1. Edit: `tests/integration.bats`
2. Add test:
   ```bash
   @test "my script handles X correctly" {
     run "$SCRIPT_DIR/my-script.sh" arg1 arg2
     [ $status -eq 0 ]
     [[ $output == *"expected"* ]]
   }
   ```

## Continuous Integration

### Pre-commit Checks

The pre-commit hook (lefthook) verifies:
- All tests pass
- Code is properly formatted
- No syntax errors

### CI Pipeline

- All tests run on every push
- Tests must pass before merging to main
- Coverage reports are generated

## Test Requirements

### Bash Version Compatibility

All tests must pass on:
- macOS Bash 3.2 (default)
- Bash 4.0+ (Linux, WSL)
- Bash 5.0+ (newer systems)

### Environment

Tests run on:
- Ubuntu (CI/CD)
- macOS (local development)
- WSL (Windows developers)

All tests must pass on all platforms.

## Best Practices

1. **Keep tests focused** — One test per behavior
2. **Use clear assertions** — Obvious what's being tested
3. **Clean up thoroughly** — Leave no artifacts
4. **Test edge cases** — Empty inputs, special characters, etc.
5. **Test error paths** — Verify graceful failure
6. **Avoid timeouts** — Tests should complete quickly
7. **Use fixtures** — Reusable test data in setup()

## Performance

### Test Timing

- Jest tests: ~75 seconds (192 tests)
- BATS tests: ~30 seconds (25 tests) — requires BATS installed
- Combined: ~2 minutes

### Optimization

- Use `npm test -- --testNamePattern` to run specific tests
- Use `npm run test:watch` for rapid feedback during development
- Run `npm run test:bats:verbose` for debugging

## Coverage Goals

- Unit test coverage: 100% of shell functions
- Integration test coverage: All major workflows
- Bash compatibility: 3.2+

## Resources

- [Jest Documentation](https://jestjs.io/)
- [BATS Documentation](https://bats-core.readthedocs.io/)
- [Shell Testing Best Practices](https://github.com/bats-core/bats-core/wiki)

## See Also

- [CLAUDE.md](../CLAUDE.md) — Test structure and configuration
- [AGENTS.md](../AGENTS.md) — Test framework documentation
- [tests/README.md](../tests/README.md) — BATS integration test guide

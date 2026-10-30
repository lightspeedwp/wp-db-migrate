# Claude Code Configuration

This document provides configuration and best practices for working with wp-db-migrate in Claude Code.

## 🎯 Project Overview

**wp-db-migrate** is a professional WordPress database migration skill for moving MySQL/MariaDB databases to SQLite in WordPress Studio with comprehensive safety, validation, and error recovery.

- **Repository**: LightSpeed marketplace plugin
- **Install path**: `~/.claude/skills/wp-db-migrate/`
- **Type**: Claude skill + plugin
- **Language**: Bash (scripts) + JavaScript (plugin)
- **Testing**: Jest (192+ tests)

## 🚀 Getting Started

### 1. First Time Setup
```bash
# Verify dependencies
./skill/scripts/setup-dependencies.sh --verbose

# Install missing dependencies if needed
./skill/scripts/setup-dependencies.sh --install

# Run preflight checks
./skill/scripts/preflight-check.sh
```

### 2. Enable the Skill
- Open Claude Code → Settings → Skills
- Find **wp-db-migrate** and toggle Enable
- Or enable via command line: `Settings → Skills → wp-db-migrate`

### 3. Try Your First Migration
```bash
# Create a WordPress Studio site
studio create my-project

# Run a dry-run (preview only)
cd ~/.claude/skills/wp-db-migrate
./skill/scripts/migrate-recovery-enhanced.sh --dry-run \
  ~/.studio/sites/my-project \
  "https://staging.example.com" \
  "https://my-project.local"
```

## 📁 Project Structure

```
wp-db-migrate/
├── skill/                           # Claude Skill
│   ├── SKILL.md                    # Skill documentation
│   ├── IMPROVEMENTS.md             # Changelog & roadmap
│   ├── scripts/                    # CLI tools (shell scripts)
│   │   ├── migrate-recovery.sh     # Main migration script
│   │   ├── migrate-recovery-enhanced.sh  # Advanced options
│   │   ├── preflight-check.sh      # Dependency verification
│   │   ├── verify-import.sh        # Validation
│   │   ├── replace-urls.sh         # URL replacement
│   │   ├── start-server.sh         # Server startup
│   │   └── __tests__/              # Jest tests (co-located with scripts)
│   │       ├── *.test.js           # 192+ Jest test cases
│   │       └── utils.js            # Test utilities
│   └── evals/                      # Skill evaluation cases
├── tests/                          # BATS shell integration tests
│   └── integration.bats            # Shell script integration tests
├── plugin/                          # Claude Plugin
│   ├── manifest.json               # Plugin configuration
│   └── README.md                   # Plugin docs
├── docs/                           # Documentation (24 guides)
│   ├── GETTING-STARTED.md, BEST-PRACTICES.md
│   ├── TROUBLESHOOTING.md, FAQ.md, ADVANCED.md
│   └── ... (19 more guides)
├── jest.config.js                  # Jest configuration
├── README.md                       # Main project README
├── AGENTS.md                       # Agents & skills documentation
├── CLAUDE.md                       # Claude Code configuration
└── package.json                    # NPM configuration
```

## 🧪 Test Structure

This project uses two testing approaches:

### Jest Tests (JavaScript/Shell Scripts)
- **Location**: `skill/scripts/__tests__/` (co-located with source scripts)
- **Files**: `*.test.js` test files + `utils.js` (test utilities)
- **Count**: 192+ test cases covering all shell scripts
- **Config**: `jest.config.js` in root (configured via Jest best practices)
- **Coverage**: 100% of shell script functionality tested

```bash
npm test                    # Run all Jest tests
npm test -- --watch       # Watch mode
npm test -- --coverage    # Coverage report
npm test -- lib-config    # Run specific test suite
```

### BATS Tests (Shell Integration Tests)
- **Location**: `tests/` folder in root
- **Files**: `*.bats` files for integration testing
- **Purpose**: Integration and end-to-end shell script testing

## 🛠️ Common Tasks

### Run Tests
```bash
npm test                    # Run all Jest tests  
npm run test:watch        # Watch mode for development
npm run test:verbose      # Verbose output with coverage
```

### Check Code Quality
```bash
npm run lint              # Run ESLint
npm run shellcheck        # Check shell scripts
```

### View Skill Documentation
```bash
less ./skill/SKILL.md     # Complete skill docs
```

### Check for Improvements
```bash
less ./skill/IMPROVEMENTS.md  # Changelog & roadmap
```

## 📚 Key Documentation

- **[README.md](./README.md)** — Project overview and features
- **[AGENTS.md](./AGENTS.md)** — Available agents and skills
- **[docs/GETTING-STARTED.md](./docs/GETTING-STARTED.md)** — First migration walkthrough
- **[docs/SETUP-REQUIREMENTS.md](./docs/SETUP-REQUIREMENTS.md)** — Dependencies and system setup
- **[docs/BEST-PRACTICES.md](./docs/BEST-PRACTICES.md)** — Safe migration strategies
- **[docs/TROUBLESHOOTING.md](./docs/TROUBLESHOOTING.md)** — Problem solving
- **[docs/FAQ.md](./docs/FAQ.md)** — 30+ common questions
- **[docs/LS-HOSTING-INTEGRATION.md](./docs/LS-HOSTING-INTEGRATION.md)** — Complete workflows

## 🔧 Claude Code Settings

### Recommended Settings
```json
{
  "model": "claude-opus-5-5",
  "effort": "medium",
  "permissions": {
    "allow": [
      "bash",
      "npm",
      "wp",
      "studio",
      "git"
    ]
  }
}
```

### Hooks (Optional)
Add to `.claude/hooks/` for automation:
- `pre-commit.sh` — Run tests and linting before commits
- `pre-push.sh` — Verify all tests pass before pushing

## 🔐 Security Notes

### Safe to Work With
- ✅ All migration operations are reversible (backups created)
- ✅ Dry-run mode previews without making changes
- ✅ Confirmation gates at each step
- ✅ Test databases only (development/staging)

### Never On Production
- ⚠️ Always test on staging/development sites first
- ⚠️ Never migrate live production databases without backups
- ⚠️ Always run dry-run first to validate

## 🎯 Workflow Guidelines

### 1. Making Changes
```bash
# Create a new branch
git checkout -b feature/your-feature

# Make changes and test
npm test

# Commit with descriptive message
git commit -m "feat: add new feature"

# Push and open PR
git push origin feature/your-feature
```

### 2. Testing Changes
```bash
# Run full test suite
npm test

# Run specific test
npm test -- migrate-recovery.test.js

# Check coverage
npm test -- --coverage
```

### 3. Documentation Updates
- Update relevant `.md` files in `docs/`
- Update `skill/SKILL.md` for skill documentation
- Update `plugin/README.md` for plugin changes
- Update `AGENTS.md` if changing skill/agent behavior

### 4. Before Committing
```bash
# Verify tests pass
npm test

# Check code quality
npm run lint

# Review changes
git diff
git status
```

## 📖 Team Collaboration

### For Team Members
1. Clone and setup: See [docs/SETUP-REQUIREMENTS.md](./docs/SETUP-REQUIREMENTS.md)
2. Enable skill: Settings → Skills → wp-db-migrate
3. Run preflight check: `./skill/scripts/preflight-check.sh`
4. Start with getting started guide: [docs/GETTING-STARTED.md](./docs/GETTING-STARTED.md)

### For Developers
1. Review project structure and test suite
2. Read skill documentation: `skill/SKILL.md`
3. Check test cases: `__tests__/`
4. Run `npm test` to validate changes
5. Follow commit guidelines above

## 🆘 Troubleshooting

### Skill Not Showing in Claude Code
```bash
# Verify skill is in correct location
ls ~/.claude/skills/wp-db-migrate/

# Verify structure
ls skill/SKILL.md plugin/manifest.json

# Restart Claude Code
# Settings → Skills → Refresh
```

### Tests Failing
```bash
# Run with verbose output
npm test -- --verbose

# Check specific test file
npm test -- verify-import.test.js

# See test output
npm test -- --no-coverage
```

### Dependency Issues
```bash
# Run preflight check
./skill/scripts/preflight-check.sh

# Install missing dependencies
./skill/scripts/setup-dependencies.sh --install

# Verify specific tools
wp --version
studio --version
wp-cli --version
```

## 📝 Commit Message Format

Follow conventional commits:
```
type(scope): description

body (optional)

footer (optional)
Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>
```

Types:
- `feat:` — New feature
- `fix:` — Bug fix
- `docs:` — Documentation only
- `test:` — Test changes
- `refactor:` — Code refactoring
- `chore:` — Maintenance

Example:
```
feat(scripts): add dry-run mode to migration

Adds --dry-run flag to preview migration without making changes.
Includes comprehensive validation and human-readable output.

Fixes #42
Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>
```

## 🚀 Performance Tips

### For Large Databases
- Use `--exclude-tables` to skip non-essential tables
- See [docs/LARGE-DATABASES.md](./docs/LARGE-DATABASES.md) for strategies
- Test on smaller subset first

### For Fast Testing
- Use `--dry-run` to validate without importing
- Run `npm test -- --testNamePattern="pattern"` to run specific tests
- Use `npm test -- --watch` for continuous testing

## 📞 Support Resources

- **Skill Documentation**: `skill/SKILL.md`
- **FAQ**: `docs/FAQ.md` (30+ answers)
- **Troubleshooting**: `docs/TROUBLESHOOTING.md`
- **Getting Started**: `docs/GETTING-STARTED.md`
- **Best Practices**: `docs/BEST-PRACTICES.md`

---

**Questions?** Check the FAQ or review the relevant documentation file.

**Ready to start?** Run `./skill/scripts/preflight-check.sh` to validate your setup.

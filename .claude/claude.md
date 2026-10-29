# Claude Code Instructions for wp-db-migrate

Guidelines for working with this WordPress database migration tool in Claude Code.

## Project Overview

**wp-db-migrate** is a professional-grade Claude skill for migrating WordPress databases from MySQL/MariaDB to SQLite in WordPress Studio.

- **Version**: 1.1.0
- **Author**: Ash Shaw
- **Repository**: https://github.com/lightspeedwp/wp-db-migrate
- **License**: MIT

## Quick Start

```bash
# Initialize environment
./setup-cloud.sh

# Run with verbose output
./setup-cloud.sh --verbose

# Test everything
npm test
```

## Project Structure

```
wp-db-migrate/
├── .claude/                    ← Claude Code config
│   ├── launch.json            ← Server launcher configs
│   ├── settings.json          ← Project settings & hooks
│   └── claude.md              ← This file
├── skill/                     ← Main Claude skill
│   ├── SKILL.md               ← Skill documentation
│   ├── scripts/               ← CLI tools
│   └── evals/                 ← Test cases
├── plugin/                    ← Claude plugin
├── setup-cloud.sh             ← Cloud setup script
├── Dockerfile, docker-compose.yml
├── .github/workflows/         ← GitHub Actions CI/CD
├── __tests__/                 ← Jest test suite
└── README.md                  ← Main documentation
```

## Development Workflow

### 1. Setup Environment
```bash
./setup-cloud.sh
```

### 2. Make Changes
Edit files in `skill/scripts/` or `skill/SKILL.md`

### 3. Test Changes
```bash
npm test                        # Run full suite
npm test -- --watch           # Watch mode
npm run preflight             # Verify deps
```

### 4. Run Locally
```bash
./skill/scripts/preflight-check.sh
./skill/scripts/migrate-recovery.sh /path/to/site "old-url" "new-url"
```

### 5. Use Docker
```bash
docker-compose up dev         # Dev environment
docker-compose up test        # Run tests
```

## Code Style & Standards

### Bash Scripts
- Use `set -euo pipefail` at top of scripts
- Shellcheck for linting: `shellcheck *.sh`
- Comments only when WHY is non-obvious
- Color output: Use `\033[0;32m` codes (defined in setup-cloud.sh)

### JavaScript/Jest
- ES6+ syntax (Node 20.x+)
- 100% test coverage required
- No external dependencies (keep it light)
- Use descriptive test names

### Documentation
- Markdown format (.md)
- Keep sections short and scannable
- Include code examples
- Link related docs

## Common Tasks

### Add a New Script
1. Create `skill/scripts/my-script.sh`
2. Add to `.github/workflows/setup-cloud.yml`
3. Update `skill/SKILL.md` with documentation
4. Add tests if needed
5. Run `chmod +x skill/scripts/my-script.sh`

### Update Dependencies
```bash
npm update
npm audit fix
npm test
```

### Deploy to Cloud
```bash
./setup-cloud.sh --production --ci
# Check GitHub Actions
# Download artifacts
```

### Fix a Security Issue
1. Run `npm audit`
2. Fix vulnerabilities
3. Update SECURITY-FIXES.md
4. Commit with `security:` prefix

## Testing Requirements

- **Coverage**: 100% (all branches, functions, lines)
- **Framework**: Jest
- **Location**: `__tests__/**/*.test.js`
- **Run**: `npm test`

## Git Workflow

### Commit Messages
- Use conventional commits: `feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `security:`
- First line: short description
- Body: detailed explanation
- End with: `Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>`

### Branches
- `main` — Production releases
- `develop` — Development
- Feature branches: `feature/name`

### Pull Requests
- Link related issues
- Include test results
- Run GitHub Actions before merging
- Require passing CI/CD

## Security

### Key Principles
- ✅ No hardcoded secrets
- ✅ Use `.env.example` for templates
- ✅ Pin GitHub Actions to commit SHAs
- ✅ Validate all inputs
- ✅ No code execution from config files
- ✅ Non-root Docker user

### Before Committing
1. Run `npm audit`
2. Check for secrets: `grep -r "password\|token\|secret" .`
3. Verify permissions are set correctly
4. Test on fresh environment

## Debugging

### Enable Verbose Output
```bash
./setup-cloud.sh --verbose 2>&1 | tee debug.log
```

### Check Logs
```bash
tail -f logs/migration.log        # Migration logs
docker-compose logs -f dev        # Docker logs
npm test -- --verbose           # Test output
```

### Common Issues

**Node not found**
```bash
node -v
# If not installed: brew install node (macOS) or apt-get install nodejs (Linux)
```

**Docker permission denied**
```bash
sudo usermod -aG docker $USER
newgrp docker
```

**Tests failing**
```bash
npm test -- --verbose
npm test -- --coverage
rm -rf node_modules package-lock.json && npm install
```

## Before You Push

- [ ] `npm test` passes with 100% coverage
- [ ] `./setup-cloud.sh` runs without errors
- [ ] `./skill/scripts/preflight-check.sh` passes
- [ ] No uncommitted changes
- [ ] Commit message is clear
- [ ] No secrets in code
- [ ] Documentation is updated

## Useful Commands

```bash
# Setup & Testing
./setup-cloud.sh                    # Initialize
npm test                            # Run tests
npm run preflight                   # Check environment

# Development
npm run test:watch                  # Watch mode
npm run setup:verbose              # Verbose setup
./skill/scripts/preflight-check.sh # Verify deps

# Docker
docker-compose up dev              # Dev environment
docker-compose up test             # Run tests
docker-compose down                # Stop services

# Git
git status                          # Check status
git add .                           # Stage changes
git commit -m "type: message"      # Commit
git push origin branch              # Push
```

## Resources

- **Main README**: README.md
- **Cloud Setup**: CLOUD-SETUP.md
- **Quick Reference**: CLOUD-QUICK-REFERENCE.md
- **Skill Guide**: skill/SKILL.md
- **Security Info**: SECURITY-FIXES.md
- **Test Summary**: TEST-SUMMARY.md

## Getting Help

1. Check documentation files
2. Run `./setup-cloud.sh --help`
3. Enable verbose: `./setup-cloud.sh --verbose`
4. Check GitHub issues
5. Review existing tests for examples

## Attribution

All commits should include:
```
Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>
```

---

**Last Updated**: 2026-10-29  
**Claude Code Version**: Latest  
**Node.js**: 20.x recommended

# WordPress Database Migration (MySQL → SQLite Studio)

Professional-grade WordPress database migration skill: MySQL/MariaDB → SQLite in WordPress
Studio. Handles sanitization, safe imports, URL replacement, and comprehensive validation.

## What Problem Does This Solve?

Bring production/staging database backups into local WordPress Studio sites for development and
testing. This skill automates the entire workflow:

- Analyzes your database export for size and compatibility
- Sanitizes it for SQLite (removes MySQL-only syntax)
- Safely imports with backup and rollback capability
- Replaces URLs automatically with verification
- Validates the result with row counts and integrity checks

## 🚀 Quick Start

````bash
# 1. Check dependencies
./skill/scripts/preflight-check.sh

# 2. Preview migration (dry-run mode)
./skill/scripts/migrate-recovery-enhanced.sh --dry-run \
  /path/to/studio/site "https://old-url.com" "https://new-url.local"

# 3. Run migration
./skill/scripts/migrate-recovery.sh \
  /path/to/studio/site "https://old-url.com" "https://new-url.local"
```bash

## 📦 What's Included

### `skill/` — The Claude Skill
- **SKILL.md** — Complete skill documentation with examples, troubleshooting, FAQ
- **IMPROVEMENTS.md** — Changelog and enhancement tracking
- **scripts/** — CLI tools for migration automation
  - `preflight-check.sh` — Validate dependencies
  - `migrate-recovery.sh` — Complete workflow (standard)
  - `migrate-recovery-enhanced.sh` — Advanced options (--dry-run, --verbose, --force, etc.)
  - `verify-import.sh` — Check if import succeeded
  - `replace-urls.sh` — Replace URLs in database
  - `start-server.sh` — Start WordPress server
- **evals/** — Test cases for skill evaluation

### `plugin/` — The Claude Plugin
- **manifest.json** — Plugin metadata and configuration
- **README.md** — Plugin documentation
- Complete integration ready to install in Claude

## 📁 Project Structure

```bash
wp-db-migrate/
├── README.md               # Main project overview (this file)
├── CLAUDE.md              # Claude Code instructions
├── AGENTS.md              # Agent definitions
├── CHANGELOG.md           # Version history
├── LICENSE                # MIT License
│
├── docs/                  # 📚 Documentation (see docs/README.md)
│   ├── INSTALLATION.md    # Setup and installation
│   ├── TESTING.md         # Testing guide (Jest + BATS)
│   ├── JEST-SETUP.md      # Jest configuration
│   ├── TEST-SUMMARY.md    # Test results summary
│   ├── OPTIMIZATION.md    # Performance tuning
│   └── STUDIO-CLI-GUIDE.md # Studio CLI reference
│
├── skill/                 # 🧠 Claude Skill
│   ├── SKILL.md          # Complete skill documentation
│   ├── IMPROVEMENTS.md    # Changelog and roadmap
│   ├── prompts/          # Agent instruction files
│   ├── scripts/          # CLI migration scripts
│   ├── api/              # API and automation tools
│   ├── evals/            # Skill evaluation test cases
│   └── README.md         # (auto-generated from SKILL.md)
│
├── skill/scripts/         # 🛠️ CLI Tools
│   ├── README.md         # Scripts quick reference
│   ├── migrate-recovery.sh
│   ├── migrate-recovery-enhanced.sh
│   ├── preflight-check.sh
│   ├── verify-import.sh
│   ├── replace-urls.sh
│   └── ... (other migration utilities)
│
├── plugin/               # 🔌 Claude Plugin
│   ├── manifest.json
│   └── README.md
│
├── tests/                # 🧪 Integration Tests
│   ├── README.md         # Testing guide
│   └── integration.bats  # BATS shell script tests
│
├── __tests__/            # Jest Unit Tests
│   └── *.test.js         # Unit test files
│
├── references/           # 📖 External Resources
│   └── README.md         # Links and references
│
├── assets/               # 🖼️ Media & Templates
│   └── README.md         # Asset guidelines
│
└── package.json         # Node.js dependencies
```bash

## ✨ Key Features

### Safety First
- ✅ Pre-flight dependency checks
- ✅ Backup before import with auto-rollback
- ✅ Dry-run mode to preview without changes
- ✅ Explicit confirmation gates at each step
- ✅ Post-import validation (row counts, integrity, URLs)

### Professional Tooling
- 🚀 Advanced recovery script with flags
- 📊 Verbose logging with file output
- ⚙️ CI/CD automation ready (--force mode)
- 🎯 Comprehensive troubleshooting guide
- 📚 FAQ answering 95% of common questions

### Smart Database Analysis
- 🧠 Analyzes export and suggests table exclusions
- 📊 Shows size breakdown (which tables to exclude)
- 🔍 Auto-detects current site URL
- ✅ Validates before proceeding

### Flexible Workflows
- Sync staging to local development
- Set up new Studio sites with real data
- Any MySQL→SQLite migration
- Support for databases of any size

## 📖 Documentation

Start with the [docs/README.md](docs/README.md) for a complete documentation index.

### Quick Links

**For Users:**
1. **Getting Started**: [Installation Guide](docs/INSTALLATION.md)
2. **Quick Reference**: [Scripts Guide](skill/scripts/README.md)
3. **Troubleshooting**: [Studio CLI Guide](docs/STUDIO-CLI-GUIDE.md)
4. **Full Skill Docs**: [skill/SKILL.md](skill/SKILL.md) (complete reference with FAQ)

**For Developers:**
1. **Architecture**: [skill/SKILL.md](skill/SKILL.md) → "How the Skill Works"
2. **Testing**: [Testing Guide](docs/TESTING.md) with Jest and BATS
3. **Improvements**: [skill/IMPROVEMENTS.md](skill/IMPROVEMENTS.md) (changelog)
4. **Plugin**: [plugin/README.md](plugin/README.md)
5. **Performance**: [Optimization Guide](docs/OPTIMIZATION.md)

## 🛠️ Installation

### As a Claude Skill
1. Add to `.claude/skills/` in your project:
   ```bash
   ln -s /path/to/wp-db-migrate/skill ~/.claude/skills/wp-db-migrate
````

1. Or copy to your `.github/skills/`:

   ```bash
   cp -r skill /path/to/your/org/.github/skills/wp-db-migrate
   ```

### As a Claude Plugin

1. Install the plugin from `/plugin/` into Claude's plugin system
2. Enable it in your Claude settings
3. Use `/wp-db-migrate` command in any chat

### CLI Scripts Only

Add scripts to your PATH:

````bash
export PATH="$PATH:/path/to/wp-db-migrate/skill/scripts"
```bash

Then run from anywhere:
```bash
preflight-check.sh
migrate-recovery.sh /path/to/site "old-url" "new-url"
```bash

## 💡 Usage Examples

### Example 1: Sync Staging to Local
```bash
./skill/scripts/migrate-recovery.sh \
  /Users/ash/Studio/my-project \
  "https://staging.dev" \
  "https://my-project.local"
```bash

### Example 2: Dry-Run Preview
```bash
./skill/scripts/migrate-recovery-enhanced.sh --dry-run \
  /Users/ash/Studio/my-project \
  "https://old.com" \
  "https://new.local"
```bash

### Example 3: Verbose with Logging
```bash
./skill/scripts/migrate-recovery-enhanced.sh --verbose --log-file migration.log \
  /Users/ash/Studio/prod-local \
  "https://production.com" \
  "https://prod.local"
```bash

### Example 4: CI/CD Automation
```bash
# Force mode (no confirmation prompts)
./skill/scripts/migrate-recovery-enhanced.sh --force \
  /Users/ash/Studio/ci-test \
  "https://staging.com" \
  "https://ci-test.local"
```bash

## 🎯 Workflow Phases

```bash
1. Analyze Export
   ├─ Detect tables, sizes, URLs
   └─ Suggest exclusions

2. Sanitize Database
   ├─ Remove MySQL-only syntax
   └─ Exclude selected tables

3. Backup & Import
   ├─ Create backup
   ├─ Run studio import
   └─ Rollback on failure

4. URL Replacement
   ├─ Show dry-run with counts
   ├─ Get approval
   └─ Apply replacements

5. Validation
   ├─ Site loads (HTTP 200)
   ├─ Row counts match
   ├─ Database integrity
   └─ URLs correct
```bash

## 📊 Performance

Database migration times (approximate):
- **<100 MB**: 1–2 minutes
- **100 MB–1 GB**: 5–10 minutes
- **>1 GB**: 15–30 minutes

Large tables like `wp_postmeta` and `wp_actionscheduler_logs` slow imports most. Exclude them to speed up.

## 🔒 Safety Features

- **Backup before import** — Target site always backed up first
- **Dry-run mode** — Preview before committing
- **Rollback capability** — Auto-restore on failure
- **Pre-flight checks** — Verify dependencies exist
- **Explicit confirmations** — User approves at each gate
- **Post-import validation** — Catches corruption early
- **Timeout protection** — Monitors long-running operations

## ❓ FAQ

**Q: Is it safe to run while my site is live?**
A: No. Always export during quiet times and test on fresh sites first.

**Q: What if the import times out?**
A: Database usually imports successfully anyway. Run `verify-import.sh` to check.

**Q: Can I rollback after importing?**
A: Yes! A backup is created before import. See troubleshooting guide.

**Q: Should I exclude logging tables?**
A: Yes, usually. Tables like `wp_actionscheduler_logs` are safe to exclude and speed up import.

See `skill/SKILL.md` for 11 complete FAQ answers.

## 🚀 Advanced Features

### Command-Line Flags
```bash
--dry-run              # Preview without changes
--verbose              # Detailed output
--log-file FILE        # Save output to file
--force                # Skip prompts (CI/CD)
--no-backup            # Skip backup (dangerous)
--help                 # Show help
```bash

### Configuration
Planned for future:
- `.wp-db-migrate.yml` config files
- Profiles for common scenarios
- Environment variable overrides

### Automation
CI/CD ready:
- Force mode (--force) skips all prompts
- JSON output option (planned)
- Exit codes for scripting

## 📋 Version History

### v1.1.0 (2026-10-29) — Polish & Professional Grade
- ✨ Pre-flight check script
- ✨ Enhanced recovery script with advanced flags
- 📚 Expanded documentation (FAQ, flowchart, decision tree)
- 🎯 CI/CD automation ready
- 📊 Professional-grade logging

### v1.0.0 (2026-10-29) — Initial Release
- Core migration workflow
- Basic CLI scripts
- Plugin manifest
- Comprehensive documentation

## 🤝 Contributing

Improvements welcome! Areas for enhancement:
- GitHub Actions workflow template
- Progress bars for long operations
- Configuration file support
- Migration history tracking
- Bi-directional sync capability

See `skill/IMPROVEMENTS.md` for full roadmap.

## 📝 License

MIT License — see `LICENSE` file

## 🆘 Support

1. **Check FAQ** — `skill/SKILL.md` → "FAQ" section
2. **Troubleshooting** — See flowchart in `skill/SKILL.md`
3. **Pre-flight check** — Run `./skill/scripts/preflight-check.sh`
4. **Verbose output** — Use `--verbose --log-file` flags

---

**Ready to migrate?** Start with `./skill/scripts/preflight-check.sh` to validate your setup.
````

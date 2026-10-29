# WordPress Database Migration (MySQL → SQLite Studio)

A professional-grade skill for migrating WordPress databases from MySQL/MariaDB to SQLite in WordPress Studio. Handles sanitization, safe imports, URL replacement, and comprehensive validation.

## 🚀 Quick Start

```bash
# 1. Check dependencies
./skill/scripts/preflight-check.sh

# 2. Preview migration (dry-run mode)
./skill/scripts/migrate-recovery-enhanced.sh --dry-run \
  /path/to/studio/site "https://old-url.com" "https://new-url.local"

# 3. Run migration
./skill/scripts/migrate-recovery.sh \
  /path/to/studio/site "https://old-url.com" "https://new-url.local"
```

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

### For Users
1. **Getting Started**: See `skill/SKILL.md` → "When to Use This Skill"
2. **Need Help?**: Check `skill/SKILL.md` → "FAQ" (answers 11 common questions)
3. **Troubleshooting**: See decision flowchart in `skill/SKILL.md`
4. **Advanced Usage**: See "Advanced Script Options" section
5. **Config Files**: See "Configuration Files" section for `.wp-db-migrate.conf` setup
6. **Progress Tracking**: Visual progress bars show status during long operations

### For Developers
1. **Architecture**: See `skill/SKILL.md` → "How the Skill Works" (5 phases)
2. **Improvements**: See `skill/IMPROVEMENTS.md` for changelog and roadmap
3. **Plugin Setup**: See `plugin/README.md`
4. **Test Cases**: See `skill/evals/` for evaluation scenarios
5. **Libraries**: See `skill/scripts/lib-*.sh` for reusable functions
6. **Tests**: See `__tests__/` for Jest test suite (100% coverage)

## 🛠️ Installation

### ⭐ Option 1: Via Claude Code Marketplace (Recommended)
The easiest way to install wp-db-migrate into Claude Code:

1. **In Claude Code**, go to **Settings → Plugins → Add marketplace**
2. **Paste this marketplace URL:**
   ```
   https://github.com/lightspeedwp/wp-db-migrate
   ```
3. **Click "Sync"** to add the marketplace
4. The `wp-db-migrate` skill will now be available in Claude Code

Once installed, use the skill in any chat:
- Ask Claude to migrate your database
- Reference specific databases and URLs
- Use configuration files for repeated workflows

### 🔧 Option 2: As a Local Claude Skill
For development or local use:

1. Add to `.claude/skills/` in your project:
   ```bash
   ln -s /path/to/wp-db-migrate/skill ~/.claude/skills/wp-db-migrate
   ```

2. Or copy to your `.github/skills/`:
   ```bash
   cp -r skill /path/to/your/org/.github/skills/wp-db-migrate
   ```

### 🎯 Option 3: CLI Scripts Only
Use just the migration scripts without Claude integration:

Add scripts to your PATH:
```bash
export PATH="$PATH:/path/to/wp-db-migrate/skill/scripts"
```

Then run from anywhere:
```bash
preflight-check.sh
migrate-recovery.sh /path/to/site "old-url" "new-url"
migrate-recovery-enhanced.sh --config .wp-db-migrate.conf
```

## 💡 Usage Examples

### Example 1: Simple CLI Command
```bash
./skill/scripts/migrate-recovery.sh \
  /Users/ash/Studio/my-project \
  "https://staging.dev" \
  "https://my-project.local"
```

### Example 2: Dry-Run Preview
```bash
./skill/scripts/migrate-recovery-enhanced.sh --dry-run \
  /Users/ash/Studio/my-project \
  "https://old.com" \
  "https://new.local"
```

### Example 3: From Configuration File
```bash
# Create config file
cp .wp-db-migrate.example.yml .wp-db-migrate.conf
# Edit .wp-db-migrate.conf with your paths

# Run migration using config
./skill/scripts/migrate-recovery-enhanced.sh --config .wp-db-migrate.conf
```

### Example 4: Config + Environment Override
```bash
# Environment variables override config file
export WP_DB_MIGRATE_VERBOSE=true
./skill/scripts/migrate-recovery-enhanced.sh --config .wp-db-migrate.conf --dry-run
```

### Example 5: Verbose with Logging
```bash
./skill/scripts/migrate-recovery-enhanced.sh --verbose --log-file migration.log \
  /Users/ash/Studio/prod-local \
  "https://production.com" \
  "https://prod.local"
```

### Example 6: CI/CD Automation
```bash
# Force mode (no confirmation prompts)
./skill/scripts/migrate-recovery-enhanced.sh --force \
  /Users/ash/Studio/ci-test \
  "https://staging.com" \
  "https://ci-test.local"

# Or with config
./skill/scripts/migrate-recovery-enhanced.sh --config .wp-db-migrate.conf --force
```

## 🎯 Workflow Phases

```
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
```

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
--config FILE          # Load settings from config file
--dry-run              # Preview without changes
--verbose              # Detailed output
--log-file FILE        # Save output to file
--force                # Skip prompts (CI/CD)
--no-backup            # Skip backup (dangerous)
--help                 # Show help
```

### Configuration Files
Load settings from `.wp-db-migrate.conf` or `.wp-db-migrate.yml`:

```bash
# Using config file
./migrate-recovery-enhanced.sh --config .wp-db-migrate.conf

# Override config with CLI flags
./migrate-recovery-enhanced.sh --config .wp-db-migrate.conf --dry-run --verbose
```

**Supported config keys:**
- `STUDIO_SITE_PATH` — Target studio site path
- `SOURCE_URL` — URL to migrate from
- `TARGET_URL` — URL to migrate to
- `EXCLUDE_TABLES` — Tables to skip
- `VERBOSE` — Enable verbose output
- `DRY_RUN` — Preview mode
- `FORCE` — Skip prompts

**Environment Variable Overrides:**
All config values can be overridden with `WP_DB_MIGRATE_*` environment variables:
```bash
export WP_DB_MIGRATE_SITE_PATH="/path/to/site"
export WP_DB_MIGRATE_FROM_URL="https://old.com"
export WP_DB_MIGRATE_TO_URL="https://new.local"
export WP_DB_MIGRATE_VERBOSE="true"
export WP_DB_MIGRATE_DRY_RUN="false"

./migrate-recovery-enhanced.sh --config .wp-db-migrate.conf
```

### Progress Tracking
Visual progress bars during operations:
- ⏳ Spinners for indeterminate operations
- 📊 Progress bars with percentage completion
- 📍 Stage tracking for multi-phase workflows
- ✅ Color-coded status indicators

### Automation
CI/CD ready:
- Force mode (--force) skips all prompts
- Config files for repeatable deployments
- Environment variable support
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

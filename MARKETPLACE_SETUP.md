# WordPress Database Migration — Marketplace Setup Guide

**Status:** ✅ Marketplace Ready  
**Repository:** https://github.com/lightspeedwp/wp-db-migrate  
**Version:** 1.1.0 (Progress Bars & Config Files)  
**Date:** 2026-10-29

---

## 📥 Installation

### For Users: Install via Claude Code Marketplace

1. **Open Claude Code**
2. **Go to:** Settings → Plugins → Add marketplace
3. **Paste URL:** `https://github.com/lightspeedwp/wp-db-migrate`
4. **Click:** Sync
5. **Use the skill** in any chat with `/wp-db-migrate` or by describing a database migration task

### For Developers: Local Installation

```bash
# Clone the repository
git clone https://github.com/lightspeedwp/wp-db-migrate
cd wp-db-migrate

# Link the skill to your project
ln -s $(pwd)/skill ~/.claude/skills/wp-db-migrate

# Or use the CLI scripts directly
export PATH="$PATH:$(pwd)/skill/scripts"
```

---

## 📦 Marketplace Structure

```
wp-db-migrate/
├── .claude-plugin/                    # Marketplace configuration
│   ├── marketplace.json               # Marketplace metadata
│   └── plugin.json                    # Plugin definition & skills
├── plugin/
│   └── manifest.json                  # Claude plugin manifest (legacy)
├── skill/
│   ├── SKILL.md                       # Main skill documentation
│   ├── IMPROVEMENTS.md                # Enhancement changelog
│   ├── scripts/                       # Migration scripts
│   │   ├── lib-progress.sh           # Progress bar library
│   │   ├── lib-config.sh             # Config parser library
│   │   ├── migrate-recovery.sh       # Basic migration
│   │   ├── migrate-recovery-enhanced.sh  # Advanced migration
│   │   ├── verify-import.sh          # Validation
│   │   ├── replace-urls.sh           # URL replacement
│   │   ├── preflight-check.sh        # Dependency check
│   │   └── start-server.sh           # Server startup
│   ├── evals/                         # Test cases
│   │   └── [test scenarios]
│   └── README.md                      # Scripts documentation
├── __tests__/                         # Jest test suite (100% coverage)
├── README.md                          # Main documentation
├── package.json                       # Node dependencies & test config
└── .gitignore                         # Git exclusions

Key Files:
• .claude-plugin/marketplace.json      (Marketplace entry point)
• .claude-plugin/plugin.json           (Plugin definition)
• skill/SKILL.md                       (Skill content)
```

---

## 🔧 Marketplace Configuration

### marketplace.json
Defines the marketplace at the repository level:
```json
{
  "name": "wp-db-migrate",
  "description": "WordPress Database Migration for Claude Code...",
  "owner": {
    "name": "LightSpeed",
    "url": "https://github.com/lightspeedwp"
  },
  "plugins": [
    {
      "name": "wp-db-migrate",
      "source": "./",
      "description": "Migrate WordPress databases..."
    }
  ]
}
```

### plugin.json
Defines the plugin and points to skills:
```json
{
  "name": "WordPress Database Migration",
  "id": "wp-db-migrate",
  "version": "1.1.0",
  "skills": ["./skill/SKILL.md"],
  "requirements": {
    "cli": ["studio", "wp"],
    "tools": ["bash", "sqlite3"]
  }
}
```

---

## ✅ Installation Verification

**When installation succeeds, you'll see:**

1. ✅ Plugin listed in Claude Code plugins panel
2. ✅ Skill available in Claude conversations
3. ✅ `/wp-db-migrate` command recognized
4. ✅ Skill functions available for database migrations

**Test the installation:**
```
In Claude Code chat:
"Help me migrate my staging database to a local WordPress Studio site using /wp-db-migrate"
```

---

## 🎯 What's Included in v1.1.0

### Core Features
- ✅ MySQL→SQLite database migration
- ✅ Smart table exclusion analysis
- ✅ Safe import with backup & rollback
- ✅ Automatic URL replacement (dry-run mode)
- ✅ Post-import validation

### New in v1.1.0
- ✅ **Progress Bars** — Visual spinners and progress indicators
- ✅ **Config Files** — `.wp-db-migrate.conf` or `.wp-db-migrate.yml`
- ✅ **Environment Overrides** — `WP_DB_MIGRATE_*` variables
- ✅ **100% Test Coverage** — 70+ Jest tests
- ✅ **Professional Logging** — Verbose output, file logging

### Advanced Script Options
```bash
--config FILE          # Load settings from config file
--dry-run             # Preview without making changes
--verbose             # Detailed output
--log-file FILE       # Save output to file
--force               # Skip confirmation prompts (CI/CD)
--no-backup           # Skip backup (dangerous)
--help                # Show help message
```

---

## 📚 Documentation

### For Users
- **Installation** → README.md "Installation" section
- **Getting Started** → skill/SKILL.md "When to Use This Skill"
- **Configuration** → README.md "Advanced Features" section
- **Troubleshooting** → skill/SKILL.md "Troubleshooting" section
- **FAQ** → skill/SKILL.md "FAQ" section

### For Developers
- **Architecture** → skill/SKILL.md "How the Skill Works"
- **Scripts** → skill/scripts/README.md
- **Libraries** → skill/scripts/lib-*.sh (with inline docs)
- **Tests** → __tests__/*.test.js (Jest suite)
- **Changes** → skill/IMPROVEMENTS.md

---

## 🚀 Usage Examples

### Example 1: Via Claude Code Chat
```
User: "I need to sync my staging database to a local WordPress Studio site"

Claude: "I'll help you migrate your staging database to Studio using the wp-db-migrate skill. 
Let me:
1. Preview the database structure
2. Suggest table exclusions
3. Create a backup
4. Perform the migration
5. Replace URLs
6. Validate the import

First, where is your staging database backup and what's the site URL?"
```

### Example 2: Using Configuration File
```bash
# Create config file
cp .wp-db-migrate.example.yml .wp-db-migrate.conf

# Edit with your settings
vim .wp-db-migrate.conf

# Run migration
./skill/scripts/migrate-recovery-enhanced.sh --config .wp-db-migrate.conf

# Or preview first
./skill/scripts/migrate-recovery-enhanced.sh --config .wp-db-migrate.conf --dry-run
```

### Example 3: CI/CD Integration
```bash
# Set environment variables
export WP_DB_MIGRATE_SITE_PATH="/path/to/studio/site"
export WP_DB_MIGRATE_FROM_URL="https://staging.example.com"
export WP_DB_MIGRATE_TO_URL="https://staging.local"
export WP_DB_MIGRATE_VERBOSE="true"
export WP_DB_MIGRATE_FORCE="true"

# Run automated migration
./skill/scripts/migrate-recovery-enhanced.sh --config .wp-db-migrate.conf --force
```

---

## 🔒 Safety & Quality

### Built-in Safety
- ✅ Pre-flight dependency checks
- ✅ Backup before import (automatic)
- ✅ Dry-run preview mode
- ✅ Explicit confirmation gates
- ✅ Post-import validation
- ✅ Rollback capability

### Code Quality
- ✅ 100% test coverage (70+ Jest tests)
- ✅ Bash best practices (shellcheck compatible)
- ✅ Safe config parsing (no code injection)
- ✅ Comprehensive error handling
- ✅ Well-documented code

### Security
- ✅ No code execution in config files
- ✅ Input validation and sanitization
- ✅ Secure database handling
- ✅ Safe file operations
- ✅ Principle of least privilege

---

## 📊 Technical Requirements

### System Requirements
- **OS:** macOS, Linux, or Windows (with Git Bash/WSL)
- **Bash:** 4.0+
- **Database:** MySQL/MariaDB (source), SQLite3 (target)

### Required CLI Tools
- `studio` — WordPress Studio CLI
- `wp` — WordPress CLI
- `bash`, `grep`, `sed` — Standard Unix tools
- `sqlite3` — SQLite command-line tool

### Optional Tools
- `jq` — JSON parsing (for advanced scripts)
- `git` — Version control (for backups)

---

## 🐛 Troubleshooting

### Installation Issues

**Problem:** "This repository isn't a marketplace"  
**Solution:** Ensure `.claude-plugin/marketplace.json` exists at repo root

**Problem:** Plugin appears in list but won't install  
**Solution:** Verify `plugin.json` has correct `skills` array pointing to `./skill/SKILL.md`

### Migration Issues

**Problem:** "Studio CLI not found"  
**Solution:** Run `./skill/scripts/preflight-check.sh` to verify dependencies

**Problem:** "Import times out"  
**Solution:** Use `--exclude-tables` to skip large/unnecessary tables

**Problem:** "URLs not replaced correctly"  
**Solution:** Use `--dry-run` first to preview, then review replacements

See skill/SKILL.md for comprehensive troubleshooting guide.

---

## 📈 Support & Feedback

- **Documentation:** https://github.com/lightspeedwp/wp-db-migrate
- **Issues:** GitHub Issues (for bug reports)
- **Discussions:** GitHub Discussions (for questions)
- **Contributing:** Contributions welcome via pull requests

---

## 📝 Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.1.0 | 2026-10-29 | Progress bars, config files, marketplace launch |
| 1.0.0 | 2026-10-29 | Initial release |

---

## 🎓 Next Steps

### For First-Time Users
1. ✅ Install via marketplace
2. ✅ Read README.md "Getting Started"
3. ✅ Review skill/SKILL.md examples
4. ✅ Run `preflight-check.sh` to verify setup
5. ✅ Use `--dry-run` on your first migration

### For Advanced Users
1. ✅ Create `.wp-db-migrate.conf` for your workflow
2. ✅ Use `--exclude-tables` for large databases
3. ✅ Integrate into CI/CD with `--force` mode
4. ✅ Check IMPROVEMENTS.md for roadmap

### For Contributors
1. ✅ Fork the repository
2. ✅ Create a feature branch
3. ✅ Add tests for new features
4. ✅ Submit a pull request
5. ✅ See IMPROVEMENTS.md for planned features

---

*WordPress Database Migration for Claude Code*  
*Made with ❤️ by LightSpeed*  
*https://github.com/lightspeedwp/wp-db-migrate*

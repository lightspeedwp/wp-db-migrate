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

- **Safety First** — Pre-flight checks, backup before import, auto-rollback on failure, explicit confirmation gates
- **Smart Analysis** — Auto-detects tables to exclude, shows size breakdown, validates before proceeding
- **Professional Tooling** — Advanced flags (--dry-run, --verbose, --force), logging, CI/CD ready
- **Flexible Workflows** — Works with any database size, any MySQL/MariaDB source, any target Studio site

**→ Full feature list:** See [plugin/README.md](./plugin/README.md)

## 📖 Documentation

### For Users
1. **Getting Started**: See `skill/SKILL.md` → "When to Use This Skill"
2. **Need Help?**: Check `skill/SKILL.md` → "FAQ" (answers 11 common questions)
3. **Troubleshooting**: See decision flowchart in `skill/SKILL.md`
4. **Advanced Usage**: See "Advanced Script Options" section

### For Developers
1. **Architecture**: See `skill/SKILL.md` → "How the Skill Works" (5 phases)
2. **Improvements**: See `skill/IMPROVEMENTS.md` for changelog and roadmap
3. **Plugin Setup**: See `plugin/README.md`
4. **Test Cases**: See `skill/evals/` for evaluation scenarios

## 🛠️ Installation

**New to this tool?** Start with the [Team Installation Guide](./docs/TEAM-INSTALLATION.md) for step-by-step instructions for your team.

### As a Claude Skill (Project-Level)
1. Add to `.claude/skills/` in your project:
   ```bash
   ln -s /path/to/wp-db-migrate/skill ~/.claude/skills/wp-db-migrate
   ```

2. Or copy to your `.github/skills/`:
   ```bash
   cp -r skill /path/to/your/org/.github/skills/wp-db-migrate
   ```

3. Start a new Claude Code session; the skill loads automatically. Invoke it with `/wp-db-migrate`.

### As a Claude Plugin (Global)
1. In Claude Code, add the marketplace and install the plugin:
   ```
   /plugin marketplace add lightspeedwp/wp-db-migrate
   /plugin install wp-db-migrate@lightspeedwp
   ```

2. Use `/wp-db-migrate` command in any chat

### CLI Scripts Only (CI/CD)
Add scripts to your PATH:
```bash
export PATH="$PATH:/path/to/wp-db-migrate/skill/scripts"
```

Then run from anywhere:
```bash
preflight-check.sh
wp-migrate-clone-to-studio.sh /path/to/site "old-url" "new-url"
```

**See [Team Installation Guide](./docs/TEAM-INSTALLATION.md) for detailed setup instructions, troubleshooting, and team workflows.**

## 💡 Usage Examples

### Example 1: Sync Staging to Local
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

### Example 3: Verbose with Logging
```bash
./skill/scripts/migrate-recovery-enhanced.sh --verbose --log-file migration.log \
  /Users/ash/Studio/prod-local \
  "https://production.com" \
  "https://prod.local"
```

### Example 4: CI/CD Automation
```bash
# Force mode (no confirmation prompts)
./skill/scripts/migrate-recovery-enhanced.sh --force \
  /Users/ash/Studio/ci-test \
  "https://staging.com" \
  "https://ci-test.local"
```

## 🎯 Workflow Overview

wp-db-migrate runs through **5 phases**: Export Analysis → Sanitization → Backup & Import → URL Replacement → Validation

Each phase includes safety checks, dry-run validation, and explicit confirmation gates.

**→ Detailed workflow:** See [docs/README.md#key-concepts](./docs/README.md#key-concepts)

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

Common questions answered:
- Is it safe to run on live sites?
- What if the import times out?
- Can I rollback after importing?
- Should I exclude logging tables?

**→ Full FAQ:** See [docs/FAQ.md](./docs/FAQ.md) for 30+ answers

## 🚀 Advanced Usage

Command-line flags for power users:
```bash
--dry-run              # Preview without changes
--verbose              # Detailed output
--log-file FILE        # Save output to file
--force                # Skip prompts (CI/CD automation)
--help                 # Show all options
```

**→ Full advanced options:** See [docs/ADVANCED.md](./docs/ADVANCED.md)

**→ CI/CD setup:** See [docs/BEST-PRACTICES.md](./docs/BEST-PRACTICES.md)

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

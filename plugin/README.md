# WordPress Database Migration — Claude Plugin

This is the Claude plugin package for **wp-db-migrate**. For complete documentation, features, and usage examples, see the [main project README](../README.md).

## Quick Start

### Installation

Add this plugin to Claude:

```bash
# In Claude Settings → Plugins
# Search for: wp-db-migrate
# Click Install
```

Or install locally:
```bash
cp -r . ~/.claude/plugins/wp-db-migrate
```

### Usage

In Claude, use:
```
/wp-db-migrate
```

Or ask: "Migrate my WordPress database"

## What This Plugin Does

Migrates WordPress databases from MySQL/MariaDB to SQLite in WordPress Studio with:
- Intelligent table analysis and exclusion
- Safe import with backup & rollback
- Dry-run preview before changes
- URL replacement with verification
- Comprehensive post-import validation

## Requirements

- **Studio CLI** — `studio` command in PATH
- **WP-CLI** — `wp` command for database operations
- **Bash** — For running scripts
- **WordPress Studio** — Latest version (local development environment)

## Key Scripts

Available via CLI at `~/.claude/skills/wp-db-migrate/skill/scripts/`:

```bash
migrate-recovery.sh              # Complete workflow
migrate-recovery-enhanced.sh     # Advanced options (--dry-run, --verbose, etc.)
verify-import.sh                 # Check import success
replace-urls.sh                  # URL replacement only
start-server.sh                  # Start WordPress server
```

## Full Documentation

- **[Main README](../README.md)** — Project overview, features, examples
- **[Getting Started](../docs/GETTING-STARTED.md)** — First migration in 5 minutes
- **[Best Practices](../docs/BEST-PRACTICES.md)** — Safe strategies
- **[Troubleshooting](../docs/TROUBLESHOOTING.md)** — Problem solving
- **[FAQ](../docs/FAQ.md)** — 30+ common questions
- **[Skill Docs](../skill/SKILL.md)** — Complete technical reference

## Support

- 📖 Check [FAQ](../docs/FAQ.md) for common questions
- 🔧 See [Troubleshooting](../docs/TROUBLESHOOTING.md) for errors
- 📚 Review [Skill Docs](../skill/SKILL.md) for technical details

## License

MIT

---

**Version:** 1.1.0  
**Repository:** https://github.com/lightspeedwp/wp-db-migrate  
**Maintained by:** Claude Haiku 4.5

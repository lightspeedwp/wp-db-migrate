# Agents & Skills

This project includes built-in support for Claude agents and skills to assist with WordPress database migration workflows.

## 🤖 Available Agents

### wp-db-migrate Skill
The main agent for this project, located at `~/.claude/skills/wp-db-migrate/`

**What it does:**
- Migrates WordPress databases from MySQL/MariaDB to SQLite
- Handles database sanitization and URL replacement
- Provides comprehensive validation and error recovery
- Supports dry-run mode for safe previewing

**How to use:**
```bash
# Loads automatically from ~/.claude/skills/wp-db-migrate/SKILL.md
# Invoke it in Claude Code
/wp-db-migrate
```

## 📚 Related Skills (LightSpeed Ecosystem)

### ls-hosting-* Skills
Used in conjunction with wp-db-migrate for complete workflows:

- **ls-hosting-sync-live-to-staging** — Export database from production/staging
- **ls-hosting-fetch-tools** — Download plugins and themes
- **ls-hosting-deploy-full-site** — Deploy changes back to staging/production
- **ls-hosting-sync-content** — Sync content between environments

See [ls-hosting Integration Guide](./docs/LS-HOSTING-INTEGRATION.md) for complete workflows.

### WordPress Agent Skills
Global skills for WordPress-specific development:

- `/wp-plugin-development` — Plugin architecture and best practices
- `/wp-block-development` — Gutenberg block development
- `/wp-block-themes` — Block theme configuration
- `/wp-rest-api` — REST API patterns
- `/wp-wpcli-and-ops` — WP-CLI operations
- And more (see `~/.claude/skills/wordpress-agent/README.md`)

Install at: `~/.claude/skills/wordpress-agent/`

## 🚀 Quick Start

1. **Enable wp-db-migrate skill**
   ```bash
   cd ~/.claude/skills/wp-db-migrate
   ./skill/scripts/setup-dependencies.sh --install
   ```

2. **Use with Claude**
   - In Claude Code: loads automatically from `~/.claude/skills/wp-db-migrate/`
   - In VS Code: Command palette → Claude: Enable Skills
   - Type `/wp-db-migrate` to invoke commands

3. **Or use CLI scripts directly**
   ```bash
   ~/.claude/skills/wp-db-migrate/skill/scripts/migrate-recovery.sh \
     ~/.studio/sites/my-project \
     "https://old-url.com" \
     "https://new-url.local"
   ```

## 📖 Documentation

- **[Getting Started](./docs/GETTING-STARTED.md)** — First migration in 5 minutes
- **[Setup Requirements](./docs/SETUP-REQUIREMENTS.md)** — Dependencies and system setup
- **[Best Practices](./docs/BEST-PRACTICES.md)** — Safe migration strategies
- **[Troubleshooting](./docs/TROUBLESHOOTING.md)** — Problem solving guide
- **[ls-hosting Integration](./docs/LS-HOSTING-INTEGRATION.md)** — End-to-end workflows
- **[FAQ](./docs/FAQ.md)** — 30+ common questions answered

## 🔧 Configuration

The skill is configured in:
- `skill/SKILL.md` — Skill documentation
- `plugin/manifest.json` — Plugin configuration
- `skill/scripts/` — CLI tools
- `.claude/` (future) — Agent configuration

No additional setup needed — works out of the box once dependencies are verified.

## 🆘 Support

1. Run the pre-flight check:
   ```bash
   ~/.claude/skills/wp-db-migrate/skill/scripts/preflight-check.sh
   ```

2. Check the FAQ:
   ```bash
   See docs/FAQ.md for 30+ answers
   ```

3. Enable verbose output:
   ```bash
   ~/.claude/skills/wp-db-migrate/skill/scripts/migrate-recovery-enhanced.sh --verbose
   ```

---

**Ready to migrate?** Start with [Getting Started](./docs/GETTING-STARTED.md) or run the preflight check.

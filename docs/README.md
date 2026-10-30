# WordPress Database Migration Documentation

Complete guide to migrating WordPress databases from MySQL/MariaDB to SQLite in WordPress Studio.

## Documentation Overview

This documentation library covers everything you need to know about using the wp-db-migrate tool:

### 📚 Core Guides

- **[Getting Started](./GETTING-STARTED.md)** — Quick start guide for your first migration
  - Basic workflow overview
  - Required setup and prerequisites
  - Your first migration in 5 minutes
  - Understanding the 5-stage workflow

- **[Configuration & Profiles](./CONFIGURATION.md)** — Master config file usage
  - Creating `.wp-db-migrate.conf` files
  - Available configuration options
  - Config file precedence and overrides
  - Saving and reusing configurations
  - Environment-specific configs

- **[Best Practices](./BEST-PRACTICES.md)** — Proven strategies for safe migrations
  - Pre-migration checklist
  - Backup and recovery strategies
  - Performance optimization
  - Table exclusion strategies
  - URL replacement safety
  - Post-import validation

- **[Advanced Usage](./ADVANCED.md)** — Power features and optimization
  - Remote SSH database export
  - Parallel import processing
  - Compression tuning
  - Dry-run mode for testing
  - Progress tracking and monitoring
  - Studio API validation
  - Custom table exclusions

- **[FAQ](./FAQ.md)** — Answers to common questions
  - General questions
  - Configuration questions
  - Performance questions
  - Troubleshooting quick answers
  - SSH export questions

- **[Troubleshooting](./TROUBLESHOOTING.md)** — Diagnosis and solutions
  - Common error messages
  - Performance issues
  - SSH connection problems
  - Import failures
  - Validation errors
  - Recovery procedures

- **[Reliability & Error Recovery](./RELIABILITY.md)** — Build confidence in migrations
  - Automatic error detection and classification
  - Recovery checkpoints at each stage
  - Failure type reference and remediation
  - Partial import rollback options
  - Best practices for robust migrations

- **[Analytics & Reporting](./ANALYTICS.md)** — Track and optimize migrations
  - Migration performance metrics
  - Three report formats (Markdown, JSON, CSV)
  - Understanding key performance indicators
  - Compression and import throughput analysis
  - CI/CD pipeline integration
  - Weekly team reporting templates

## Quick Navigation

**Just starting?** → Read [Getting Started](./GETTING-STARTED.md)

**Need to configure?** → See [Configuration & Profiles](./CONFIGURATION.md)

**Want to optimize?** → Check [Advanced Usage](./ADVANCED.md)

**Want to build confidence?** → Learn [Reliability & Error Recovery](./RELIABILITY.md)

**Want to track performance?** → See [Analytics & Reporting](./ANALYTICS.md)

**Something broken?** → Visit [Troubleshooting](./TROUBLESHOOTING.md)

**Have a question?** → Try [FAQ](./FAQ.md)

## Key Concepts

### The 5-Stage Workflow

1. **Export** — Download database from dev/staging (via SSH or local export)
2. **Analyze** — Scan structure, identify excludable tables
3. **Compress** — Reduce size by 70-80% for faster transfer
4. **Import** — Parallel processing for 3-5x speedup
5. **Validate** — Verify import success, database integrity

### Performance Expectations

| Scenario | Time | Optimization |
|----------|------|--------------|
| Manual process | 35-45 min | None |
| With compression | 20-25 min | 70% file size reduction |
| With parallel import | 10-15 min | 3-5x faster import |
| All optimizations | 10-15 min | Best case |

### Key Features

- **One-command orchestration** — `./wp-migrate-clone-to-studio.sh --from URL --to PATH`
- **Configuration profiles** — Reuse settings with `.wp-db-migrate.conf`
- **Remote SSH export** — Directly export from dev/staging servers
- **Progress tracking** — Real-time visual feedback with spinners and progress bars
- **Smart table analysis** — Auto-detect and suggest table exclusions
- **Parallel processing** — Use all CPU cores for faster import
- **Database validation** — Automatic pre/post-import checks

## Getting Help

- **For setup issues** → [Getting Started](./GETTING-STARTED.md)
- **For command-line options** → Run `./wp-migrate-clone-to-studio.sh --help`
- **For errors** → [Troubleshooting](./TROUBLESHOOTING.md)
- **For advanced features** → [Advanced Usage](./ADVANCED.md)

## Version Information

- **Tool Version:** 1.1.0
- **Last Updated:** October 2026
- **Compatible With:** WordPress 6.0+, WordPress Studio 2024+

## Support

For issues, questions, or feature requests:
- Check [FAQ](./FAQ.md) for common questions
- Review [Troubleshooting](./TROUBLESHOOTING.md) for known issues
- See [Best Practices](./BEST-PRACTICES.md) for optimization advice

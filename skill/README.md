# Skill: WordPress Database Migration

The core migration skill for Claude Code and plugin environments.

## What's Here

- **SKILL.md** — Complete skill documentation with examples, FAQ, and troubleshooting
- **scripts/** — CLI tools for running migrations
  - `preflight-check.sh` — Verify dependencies are installed
  - `migrate-recovery.sh` — Standard migration workflow
  - `migrate-recovery-enhanced.sh` — Advanced options (dry-run, verbose, force, etc.)
  - `verify-import.sh` — Check if import succeeded
  - `replace-urls.sh` — Replace URLs in database
  - `start-server.sh` — Start WordPress server
- **lib-*.sh** — Library functions used by scripts
- **evals/** — Test cases for skill evaluation

## Quick Start

```bash
# Verify dependencies
./scripts/preflight-check.sh

# Preview migration (no changes)
./scripts/migrate-recovery-enhanced.sh --dry-run \
  /path/to/studio/site https://old-url.com https://new-url.local

# Run migration
./scripts/migrate-recovery.sh \
  /path/to/studio/site https://old-url.com https://new-url.local
```

## Using This Skill

### In Claude Code
1. Enable skill in Settings → Skills
2. Use in Claude Code terminal: `/wp-migrate-clone-to-studio --help`

### In Claude Plugin
Use anywhere with `/wp-migrate-clone-to-studio` command

### As CLI Scripts
Add `skill/scripts/` to PATH and run from any terminal

## Documentation

Start with [SKILL.md](./SKILL.md) for:
- When to use this skill
- How the 5-stage workflow works
- FAQ (11 common questions answered)
- Troubleshooting flowchart
- Advanced options reference

## For Developers

- [IMPROVEMENTS.md](./IMPROVEMENTS.md) — Changelog and enhancement roadmap
- `evals/` folder — Test evaluation scenarios
- Script structure:
  - Main scripts import from `lib-*.sh` libraries
  - Libraries handle SSH, compression, validation, etc.
  - Each stage has error handling and recovery checkpoints

## Contributing

To improve this skill:
1. Test changes with `./scripts/preflight-check.sh`
2. Run the eval suite: `./evals/run.sh`
3. Update [SKILL.md](./SKILL.md) with new capabilities
4. Add recovery checkpoints for new failure modes

## Integration Points

- **Studio API** — Validates WordPress installations pre/post-import
- **wp-cli** — Remote database export via SSH
- **SSH** — Key-based authentication to servers
- **gzip** — Database compression for transfer

---

**Learn more:** Read [SKILL.md](./SKILL.md) for complete documentation or [../../docs/README-GUIDE.md](../../docs/README-GUIDE.md) for team onboarding guides.

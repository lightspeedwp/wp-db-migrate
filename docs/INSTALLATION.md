# Installation Guide — WP DB Migrate

Complete step-by-step instructions for installing the WordPress database migration skill as either a Claude Skill or Plugin.

## Prerequisites

Before installing, ensure you have:

- ✅ Claude Code installed
- ✅ Git (for cloning the repository)
- ✅ Bash shell
- ✅ WordPress Studio CLI (`studio` command)
- ✅ WordPress CLI (`wp` command)

**Check prerequisites:**

````bash
which studio   # Should show path to studio CLI
which wp       # Should show path to WordPress CLI
```bash

If missing, install from:
- [WordPress Studio CLI](https://developer.wordpress.com/docs/developer-tools/studio/cli/)
- [WordPress CLI](https://wp-cli.org/#installing)

## Getting the Repository

First, clone or download the repository:

```bash
# Clone the repository
git clone https://github.com/lightspeedwp/wp-db-migrate.git

# Or download as ZIP and extract
# https://github.com/lightspeedwp/wp-db-migrate/archive/refs/heads/main.zip
```bash

Note the path where you cloned it (e.g., `/Users/ash/work/wp-db-migrate` or `~/projects/wp-db-migrate`).

---

## Installation Method 1: As a Claude Skill (Recommended)

### 1A. User-Level Installation (Available to All Projects)

Install the skill for your user account so it's available in all Claude Code projects:

```bash
# Create symlink to user skills directory
ln -s /path/to/wp-db-migrate ~/.claude/skills/wp-db-migrate

# Verify the symlink
ls -la ~/.claude/skills/wp-db-migrate
```bash

**Result:** The skill is now available in Claude Code's `/wp-db-migrate` command.

### 1B. Project-Level Installation (Specific Project Only)

Install the skill for a single project only:

```bash
# In your project directory
mkdir -p .claude/skills
ln -s /path/to/wp-db-migrate ./.claude/skills/wp-db-migrate

# Verify the symlink
ls -la .claude/skills/wp-db-migrate
```bash

**Result:** The skill is available when working in this project via `/wp-db-migrate`.

### 1C. Copy Installation (No Symlinks)

If symlinks don't work, copy the skill directory directly:

```bash
# For user-level
cp -r /path/to/wp-db-migrate ~/.claude/skills/

# For project-level
cp -r /path/to/wp-db-migrate /your-project/.claude/skills/
```bash

### Verification

After installation, verify it works:

1. **Open Claude Code**
2. **In a chat, type:** `/wp-db-migrate`
3. **You should see:** The skill description and instructions

---

## Installation Method 2: As a Claude Plugin

### 2A. Install from Plugin Manifest

Using Claude Code's plugin installer:

1. **Open Claude Code**
2. **Go to:** Settings → Plugins → Add
3. **Paste this path:** `/path/to/wp-db-migrate/plugin/manifest.json`
   - Replace `/path/to/` with actual path to the repository
   - Example: `/Users/ash/work/wp-db-migrate/plugin/manifest.json`
4. **Click:** "Add" or "Install"

**Result:** The plugin is installed and available as a command.

### 2B. Manual Plugin Installation

If the automatic method doesn't work:

1. **Locate plugin manifest:**
   ```bash
   cat /path/to/wp-db-migrate/plugin/manifest.json
````

1. **Copy the contents**

2. **In Claude Code:**
   - Settings → Plugins → Manual Install
   - Paste the manifest JSON
   - Click Install

### Verification

After installation:

1. **Open Claude Code**
2. **Go to:** Settings → Plugins
3. **You should see:** "wp-db-migrate" in your plugin list
4. **Try using it:** Type the command in a chat

---

## Which Method Should I Use?

### Use **Method 1 (Skill)** if you want

- ✅ Simple one-time setup
- ✅ Available everywhere (all projects)
- ✅ Uses standard Claude Code skill system
- ✅ Easy to update (just pull repo changes)
- ✅ Better for team/organizational use

### Use **Method 2 (Plugin)** if you want

- ✅ More isolated installation
- ✅ Project-specific customization
- ✅ To test before full installation
- ✅ Separate from system-wide skills

**Recommendation:** Start with Method 1 (Skill) — it's simpler and more flexible.

---

## Troubleshooting Installation

### Error: "Skill not found"

**Solution:** Verify the symlink path is correct:

````bash
# Check symlink exists
ls -la ~/.claude/skills/wp-db-migrate

# If not, recreate it
ln -s /correct/path/to/wp-db-migrate ~/.claude/skills/wp-db-migrate
```bash

### Error: "Repository isn't a marketplace"

**This happens when:** You tried to add it as a marketplace instead of a skill/plugin.

**Solution:**
- ❌ Don't use "Add marketplace"
- ✅ Use "Add skill" or "Add plugin"
- ✅ Follow Method 1 or 2 above

### Error: "Permission denied"

**Solution:** Ensure the directory is readable:

```bash
# Add read permissions
chmod -R a+r /path/to/wp-db-migrate

# Add execute on directories
chmod -R a+x /path/to/wp-db-migrate
```bash

### Symlink doesn't work

**Solution:** Use copy instead:

```bash
# Remove the symlink
rm ~/.claude/skills/wp-db-migrate

# Copy the directory
cp -r /path/to/wp-db-migrate ~/.claude/skills/
```bash

### Skill appears but says "Error loading"

**Solution:** Check dependencies:

```bash
# Run the dependency check
/path/to/wp-db-migrate/skill/scripts/preflight-check.sh

# Install any missing tools
```bash

---

## Using the Skill/Plugin

After successful installation:

### Via Chat

Simply type in any Claude Code chat:

```bash
/wp-db-migrate

I need to migrate my staging database to my local Studio site
```bash

Or describe what you need:

```bash
Migrate my WordPress database from staging to local development
```bash

### With Flags (If Using Enhanced Script)

```bash
# With dry-run mode (preview only, no changes)
/wp-db-migrate --dry-run /path/to/site "old-url" "new-url"

# With verbose output
/wp-db-migrate --verbose /path/to/site "old-url" "new-url"

# Force mode (skip confirmations)
/wp-db-migrate --force /path/to/site "old-url" "new-url"
```bash

---

## Updating the Installation

### For Symlinked Installations

The symlink automatically points to the latest version. To update:

```bash
# Go to repository directory
cd /path/to/wp-db-migrate

# Pull latest changes
git pull origin main

# Run tests to verify
npm test
```bash

### For Copied Installations

To update:

```bash
# Clone/download latest version
git clone https://github.com/lightspeedwp/wp-db-migrate.git wp-db-migrate-new

# Replace old version
rm -rf ~/.claude/skills/wp-db-migrate
cp -r wp-db-migrate-new ~/.claude/skills/wp-db-migrate

# Clean up
rm -rf wp-db-migrate-new
```bash

---

## Uninstalling

### Remove Symlinked Skill

```bash
rm ~/.claude/skills/wp-db-migrate
```bash

### Remove Copied Skill

```bash
rm -rf ~/.claude/skills/wp-db-migrate
```bash

### Remove Plugin

1. **Open Claude Code**
2. **Go to:** Settings → Plugins
3. **Find:** wp-db-migrate
4. **Click:** Remove/Uninstall

---

## Advanced: Team Installation

### Organization-Wide Installation

For teams using a shared organization folder:

```bash
# In organization root
mkdir -p .github/skills
ln -s /path/to/wp-db-migrate .github/skills/wp-db-migrate

# Team members clone organization
# Skill is automatically available via symlink
```bash

### Project-Specific Installation

For project-specific needs:

```bash
# In project root
mkdir -p .claude/skills
ln -s /path/to/wp-db-migrate .claude/skills/wp-db-migrate

# Only this project has access to the skill
```bash

---

## Verification Checklist

After installation, verify everything works:

- [ ] Symlink/installation exists and is readable
- [ ] Claude Code recognizes the skill/plugin
- [ ] `/wp-db-migrate` command appears in Claude
- [ ] Running preflight check shows no errors
- [ ] Tests pass: `npm test` (from repo directory)

---

## Getting Help

If you encounter issues:

1. **Check dependencies:**
   ```bash
   /path/to/wp-db-migrate/skill/scripts/preflight-check.sh
````

1. **Review documentation:**
   - [SKILL.md](./skill/SKILL.md) — Main documentation
   - [TESTING.md](./TESTING.md) — Test information
   - [JEST-SETUP.md](./JEST-SETUP.md) — Testing setup

2. **Check troubleshooting section above**

3. **Review repository issues:**
   https://github.com/lightspeedwp/wp-db-migrate/issues

---

## Quick Start After Installation

````bash
# 1. Run preflight check to validate setup
/wp-db-migrate --help

# 2. Check your Studio site path
studio site list

# 3. Test with dry-run (no changes made)
/wp-db-migrate --dry-run /path/to/site "old-url.com" "new.local"

# 4. If dry-run succeeds, run full migration
/wp-db-migrate /path/to/site "old-url.com" "new.local"
```bash

---

## Files Reference

Important files in the repository:

```bash
wp-db-migrate/
├── skill/
│   ├── SKILL.md                 ← Main documentation
│   ├── scripts/
│   │   ├── preflight-check.sh   ← Dependency validation
│   │   ├── migrate-recovery.sh  ← Standard migration
│   │   └── ...                  (other scripts)
│   └── evals/                   ← Test scenarios
│
├── plugin/
│   └── manifest.json            ← Plugin configuration
│
├── INSTALLATION.md              ← This file
├── TESTING.md                   ← Test documentation
├── package.json                 ← Jest configuration
└── __tests__/                   ← Test files
```bash

---

**Installation Help:** For additional support, see the main [README.md](./README.md)

**Last Updated:** 2026-10-29
**Version:** 1.1.0

---

## Quick Reference

| Method | Installation | Availability | Update |
|--------|--------------|--------------|--------|
| Skill (Symlink) | `ln -s repo ~/.claude/skills/` | All projects | `git pull` |
| Skill (Copy) | `cp -r repo ~/.claude/skills/` | All projects | Re-copy |
| Plugin | Add manifest in Settings | Current project | Manual |

**Recommended:** Skill with Symlink (easier updates, automatic availability)
````

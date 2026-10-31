# Plugin Metadata: WordPress Database Migration

Claude plugin configuration and marketplace metadata.

## What's Here

- **plugin.json** — Plugin manifest with Claude integration details
- **marketplace.json** — Marketplace listing and distribution info

## File Structure

### plugin.json

Defines the plugin for Claude and Claude Code:

```json
{
  "schemaVersion": "1.0",
  "metadata": {
    "name": "WordPress Database Migration",
    "description": "Migrate WordPress databases from MySQL to SQLite in Studio",
    "version": "1.1.0"
  },
  "commands": [
    {
      "name": "wp-migrate-clone-to-studio",
      "description": "Migrate a WordPress database to SQLite Studio",
      "parameters": [
        {
          "name": "studio_path",
          "description": "Path to the target Studio site",
          "type": "string",
          "required": true
        },
        {
          "name": "from_url",
          "description": "Source site URL (for SSH export)",
          "type": "string",
          "required": false
        }
        // ... more parameters
      ]
    }
  ]
}
```

**Key sections:**

- `schemaVersion` — Plugin format version (always "1.0")
- `metadata` — Plugin identity and description
- `commands` — Available commands Claude can invoke
  - Each command has name, description, and parameter schema
  - Parameters support types: string, boolean, number, array
  - `required: true` means Claude must ask for it if not provided

### marketplace.json

Metadata for Claude marketplace listing:

```json
{
  "title": "WordPress Database Migration",
  "category": "Development",
  "keywords": ["WordPress", "Database", "Migration", "SQLite"],
  "author": "Lightspeed WP",
  "license": "MIT"
}
```

Used by Claude's plugin discovery and filtering.

## Updating Plugin Configuration

### When to Update plugin.json

1. **Adding a new command:**

   ```json
   {
     "name": "wp-clone-remote",
     "description": "Clone remote database directly",
     "parameters": [ ... ]
   }
   ```

2. **Adding/changing parameters:**
   - Update the parameter schema
   - Bump the version number
   - Restart Claude to reload

3. **Updating description:**
   - Change the description
   - Test in Claude settings

### When to Update marketplace.json

1. **New category or keywords:**
   - Helps users discover the plugin
   - Affects search indexing

2. **Author or license changes:**
   - Update to reflect current maintainer
   - Keep in sync with repo LICENSE file

## Version Management

### Versioning Strategy

- **Major** (1.0.0) — Breaking changes (command rename, parameter removal)
- **Minor** (1.1.0) — New features (new command, new parameter)
- **Patch** (1.1.1) — Bug fixes and improvements

Update version in:

1. `.claude-plugin/plugin.json`
2. `.claude-plugin/marketplace.json`
3. Root `README.md` (project version)
4. `package.json` (npm version)

### Release Process

```bash
# Update all version references
npm version minor

# This updates package.json; manually update plugin metadata
# Then commit and push
git add .claude-plugin/ package.json
git commit -m "bump: version 1.1.0"
git push
```

Claude marketplace auto-discovers the update within 24 hours.

## Testing Plugin Configuration

### Validate JSON Structure

```bash
npm run test:plugin  # Validates plugin.json schema
```

### Test in Claude

1. Open Claude Code
2. Settings → Plugins
3. Look for "WordPress Database Migration" in the list
4. Click to view details
5. Test with: `/wp-migrate-clone-to-studio --help`

### Troubleshooting

**Plugin not appearing:**

- Restart Claude completely
- Clear Claude's cache: `rm -rf ~/.claude`
- Validate plugin.json is valid JSON

**Command not working:**

- Check plugin.json parameter names match script parameters
- Restart Claude (changes require reload)

**Parameters not matching script:**

- Script: `migrate-recovery.sh [STUDIO_PATH] [FROM_URL] [TO_URL]`
- Plugin parameters should map to these in same order
- Use snake_case in JSON, convert to script format at runtime

## Integration with Script Files

The plugin configuration points Claude to the actual scripts in `../skill/scripts/`:

```
.claude-plugin/plugin.json → defines commands
      ↓
skill/scripts/migrate-recovery.sh → actual implementation
      ↓
lib-*.sh → supporting functions
```

When Claude invokes `/wp-migrate-clone-to-studio`, it:

1. Parses parameters from plugin.json schema
2. Collects them from the user
3. Passes them to the script
4. Returns script output to Claude

## Schema Reference

### Parameter Types

- `string` — Text input
- `boolean` — True/false toggle
- `number` — Integer or float
- `array` — List of items (of specified type)
- `enum` — One of predefined values

### Parameter Attributes

- `name` (required) — Parameter identifier
- `description` (required) — User-facing help text
- `type` (required) — Data type
- `required` (optional) — Must user provide this?
- `default` (optional) — Default value if not provided
- `enum` (optional) — Allowed values for enum type

## Best Practices

1. **Keep descriptions short** — One line, clear and actionable
2. **Use required sparingly** — Make most parameters optional with good defaults
3. **Test parameter order** — Matches script argument order
4. **Version bump for any change** — Even parameter description changes
5. **Update marketplace.json too** — Keep in sync with plugin.json

---

**For Claude plugin development:** See the [official docs](https://developer.anthropic.com/docs/build-a-plugin)  
**For script integration:** See [skill/README.md](../skill/README.md)  
**For manifest examples:** Check `plugin.json` in this directory

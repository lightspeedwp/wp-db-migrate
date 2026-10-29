# Security Fixes

## 2026-10-29: Code Injection Vulnerability in lib-config.sh

### Vulnerability
File: `skill/scripts/lib-config.sh`  
Type: Code Injection (CWE-94)  
Severity: Medium  
Issue: The `config_load()` function used `source "$config_file"` to load configuration files, which executes any code in the file.

### Risk
If an attacker could modify or inject content into a config file, arbitrary code could be executed with the privileges of the script user.

### Fix Applied
1. **Removed code execution**: Replaced `source` with safe data parsing
2. **Strict validation**: Only accepts `KEY=VALUE` or `KEY: VALUE` format
3. **Regex whitelisting**: Key names must match `[A-Za-z_][A-Za-z0-9_]*`
4. **Safe assignment**: Uses `printf -v` for variable assignment (no eval)
5. **Backwards compatibility**: Old `config_parse_yaml()` now delegates to safe parser

### Changes
- New `config_parse_file()` function for safe parsing
- Updated `config_load()` to use new safe parser
- Deprecated `config_parse_yaml()` with warning
- All parsing now treats config files as data, never as code

### Testing
```bash
# Test config loading
./skill/scripts/preflight-check.sh

# Verify no code execution
echo 'EVIL=$(whoami)' > test.conf
source <(cat test.conf)  # Would execute
./setup-cloud.sh         # Config now safe
```

### Affected Functions
- `config_load()` — Now safe
- `config_parse_file()` — New safe parser
- `config_parse_yaml()` — Deprecated wrapper

### Migration
No action needed for users. The fix is backwards compatible.

---

**Status**: ✅ Fixed  
**Date**: 2026-10-29  
**Version**: 1.1.0+security-patch

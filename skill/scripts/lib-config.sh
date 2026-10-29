#!/bin/bash
# Configuration file parser for wp-db-migrate
# Supports .wp-db-migrate.yml files and environment variable overrides

# Parse config file safely (no code execution)
# Usage: config_load <config_file>
config_load() {
  local config_file="$1"

  if [ ! -f "$config_file" ]; then
    return 1
  fi

  # Parse config file as data only (no source/exec)
  config_parse_file "$config_file"
}

# Safe config file parser (strict data parsing only)
# Usage: config_parse_file <file>
config_parse_file() {
  local file="$1"
  local line_num=0

  while IFS= read -r line || [ -n "$line" ]; do
    ((line_num++))

    # Skip empty lines and comments
    [[ "$line" =~ ^[[:space:]]*$ ]] && continue
    [[ "$line" =~ ^[[:space:]]*# ]] && continue

    # Parse KEY=VALUE or KEY: VALUE format
    if [[ "$line" =~ ^[[:space:]]*([A-Za-z_][A-Za-z0-9_]*)[[:space:]]*[:=][[:space:]]*(.*)$ ]]; then
      local key="${BASH_REMATCH[1]}"
      local value="${BASH_REMATCH[2]}"

      # Remove surrounding quotes if present
      value="${value%\"}"
      value="${value#\"}"

      # Set as environment variable (safe assignment)
      printf -v "CONFIG_${key^^}" '%s' "$value"
      export "CONFIG_${key^^}"
    else
      printf "⚠️  Ignoring invalid config line %d: %s\n" "$line_num" "$line" >&2
    fi
  done < "$file"
}

# Legacy: Parse YAML format config (for backwards compatibility)
# Deprecated: Use config_parse_file instead
# Usage: config_parse_yaml <file>
config_parse_yaml() {
  printf "⚠️  config_parse_yaml is deprecated. Using config_parse_file instead.\n" >&2
  config_parse_file "$1"
}

# Get config value with fallback
# Usage: config_get <key> [default]
config_get() {
  local key="$1"
  local default="${2:-}"

  # Try environment variable first
  local env_var="CONFIG_${key^^}"
  local value="${!env_var:-}"

  # Fall back to default
  if [ -z "$value" ]; then
    value="$default"
  fi

  echo "$value"
}

# Validate required config keys
# Usage: config_require <key1> [key2] [key3] ...
config_require() {
  local missing=()

  for key in "$@"; do
    local env_var="CONFIG_${key^^}"
    if [ -z "${!env_var:-}" ]; then
      missing+=("$key")
    fi
  done

  if [ ${#missing[@]} -gt 0 ]; then
    printf "❌ Missing required config: %s\n" "${missing[*]}"
    return 1
  fi

  return 0
}

# Apply environment variable overrides
# Usage: config_apply_env_overrides
config_apply_env_overrides() {
  # Allow WP_DB_MIGRATE_* environment variables to override config

  # Studio site path
  if [ -n "${WP_DB_MIGRATE_SITE_PATH:-}" ]; then
    export CONFIG_STUDIO_SITE_PATH="$WP_DB_MIGRATE_SITE_PATH"
  fi

  # Source URL
  if [ -n "${WP_DB_MIGRATE_FROM_URL:-}" ]; then
    export CONFIG_SOURCE_URL="$WP_DB_MIGRATE_FROM_URL"
  fi

  # Target URL
  if [ -n "${WP_DB_MIGRATE_TO_URL:-}" ]; then
    export CONFIG_TARGET_URL="$WP_DB_MIGRATE_TO_URL"
  fi

  # Excluded tables
  if [ -n "${WP_DB_MIGRATE_EXCLUDE_TABLES:-}" ]; then
    export CONFIG_DATABASE_EXCLUDE_TABLES="$WP_DB_MIGRATE_EXCLUDE_TABLES"
  fi

  # Create backup
  if [ -n "${WP_DB_MIGRATE_CREATE_BACKUP:-}" ]; then
    export CONFIG_BACKUP_CREATE="$WP_DB_MIGRATE_CREATE_BACKUP"
  fi

  # Verbose
  if [ -n "${WP_DB_MIGRATE_VERBOSE:-}" ]; then
    export CONFIG_LOGGING_VERBOSE="$WP_DB_MIGRATE_VERBOSE"
  fi

  # Log file
  if [ -n "${WP_DB_MIGRATE_LOG_FILE:-}" ]; then
    export CONFIG_LOGGING_FILE="$WP_DB_MIGRATE_LOG_FILE"
  fi

  # Dry run
  if [ -n "${WP_DB_MIGRATE_DRY_RUN:-}" ]; then
    export CONFIG_MODE_DRY_RUN="$WP_DB_MIGRATE_DRY_RUN"
  fi

  # Force
  if [ -n "${WP_DB_MIGRATE_FORCE:-}" ]; then
    export CONFIG_MODE_FORCE="$WP_DB_MIGRATE_FORCE"
  fi
}

# Print config summary
# Usage: config_print_summary
config_print_summary() {
  printf "📋 Configuration Summary:\n"
  printf "  Site Path:    %s\n" "$(config_get 'studio_site_path' 'Not set')"
  printf "  From URL:     %s\n" "$(config_get 'source_url' 'Not set')"
  printf "  To URL:       %s\n" "$(config_get 'target_url' 'Not set')"
  printf "  Excluded:     %s\n" "$(config_get 'database_exclude_tables' 'None')"
  printf "  Backup:       %s\n" "$(config_get 'backup_create' 'true')"
  printf "  Verbose:      %s\n" "$(config_get 'logging_verbose' 'false')"
  printf "  Dry Run:      %s\n" "$(config_get 'mode_dry_run' 'false')"
  printf "  Force:        %s\n" "$(config_get 'mode_force' 'false')"
}

export -f config_load config_parse_file config_parse_yaml config_get config_require
export -f config_apply_env_overrides config_print_summary

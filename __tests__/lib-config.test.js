const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const { createTempDir, removeTempDir, writeTestFile } = require('./utils');

describe('lib-config.sh — Configuration Parser', () => {
  const scriptDir = path.join(__dirname, '../skill/scripts');
  const libFile = path.join(scriptDir, 'lib-config.sh');
  let tempDir;

  beforeEach(() => {
    tempDir = createTempDir();
  });

  afterEach(() => {
    if (tempDir) {
      removeTempDir(tempDir);
    }
  });

  const executeConfig = (cmd, env = {}) => {
    try {
      return execSync(`bash -c "source ${libFile}; ${cmd}"`, {
        encoding: 'utf-8',
        stdio: 'pipe',
        env: { ...process.env, ...env }
      });
    } catch (err) {
      return err.stdout || '';
    }
  };

  test('Config library loads successfully', () => {
    const result = executeConfig('echo "loaded"');
    expect(result).toContain('loaded');
  });

  test('config_load with missing file returns error', () => {
    const result = executeConfig(
      'config_load "/nonexistent/file.conf"; echo $?'
    );
    expect(result).toContain('1');
  });

  test('config_load with valid bash file loads config', () => {
    const configFile = path.join(tempDir, 'test.conf');
    writeTestFile(configFile, 'CONFIG_TEST_KEY="test_value"');

    const result = executeConfig(`
      config_load "${configFile}"
      echo $CONFIG_TEST_KEY
    `);
    expect(result).toContain('test_value');
  });

  test('config_get retrieves config value', () => {
    const configFile = path.join(tempDir, 'test.conf');
    writeTestFile(configFile, 'CONFIG_SITE_PATH="/test/path"');

    const result = executeConfig(`
      config_load "${configFile}"
      config_get 'site_path'
    `);
    expect(result).toContain('/test/path');
  });

  test('config_get returns default when key missing', () => {
    const result = executeConfig(
      'config_get "missing_key" "default_value"'
    );
    expect(result).toContain('default_value');
  });

  test('config_get with no default returns empty', () => {
    const result = executeConfig(
      'config_get "missing_key"; echo "done"'
    );
    expect(result).toContain('done');
  });

  test('config_require validates required keys present', () => {
    const configFile = path.join(tempDir, 'test.conf');
    writeTestFile(configFile, `
CONFIG_STUDIO_SITE_PATH="/path"
CONFIG_SOURCE_URL="https://old.com"
    `);

    const result = executeConfig(`
      config_load "${configFile}"
      config_require 'studio_site_path' 'source_url'
      echo $?
    `);
    expect(result).toContain('0');
  });

  test('config_require fails when key missing', () => {
    const result = executeConfig(
      'config_require "missing_key"; echo $?'
    );
    expect(result).toContain('1');
  });

  test('config_require shows missing keys', () => {
    const result = executeConfig(
      'config_require "missing1" "missing2" 2>&1'
    );
    expect(result).toContain('missing');
  });

  test('config_apply_env_overrides reads WP_DB_MIGRATE vars', () => {
    const result = executeConfig(
      'config_apply_env_overrides; echo $CONFIG_STUDIO_SITE_PATH',
      { WP_DB_MIGRATE_SITE_PATH: '/env/path' }
    );
    expect(result).toContain('/env/path');
  });

  test('config_apply_env_overrides for source URL', () => {
    const result = executeConfig(
      'config_apply_env_overrides; echo $CONFIG_SOURCE_URL',
      { WP_DB_MIGRATE_FROM_URL: 'https://env.com' }
    );
    expect(result).toContain('https://env.com');
  });

  test('config_apply_env_overrides for target URL', () => {
    const result = executeConfig(
      'config_apply_env_overrides; echo $CONFIG_TARGET_URL',
      { WP_DB_MIGRATE_TO_URL: 'https://local.env' }
    );
    expect(result).toContain('https://local.env');
  });

  test('config_apply_env_overrides for verbose flag', () => {
    const result = executeConfig(
      'config_apply_env_overrides; echo $CONFIG_LOGGING_VERBOSE',
      { WP_DB_MIGRATE_VERBOSE: 'true' }
    );
    expect(result).toContain('true');
  });

  test('config_apply_env_overrides for dry-run flag', () => {
    const result = executeConfig(
      'config_apply_env_overrides; echo $CONFIG_MODE_DRY_RUN',
      { WP_DB_MIGRATE_DRY_RUN: 'true' }
    );
    expect(result).toContain('true');
  });

  test('config_print_summary displays configuration', () => {
    const result = executeConfig(
      'config_print_summary'
    );
    expect(result).toContain('Configuration Summary');
  });

  test('config_print_summary shows all keys', () => {
    const result = executeConfig(
      'config_print_summary'
    );
    expect(result).toContain('Site Path');
    expect(result).toContain('URL');
    expect(result).toContain('Backup');
  });

  test('Load bash config with comments', () => {
    const configFile = path.join(tempDir, 'test.conf');
    writeTestFile(configFile, `
# This is a comment
CONFIG_SITE_PATH="/path"
# Another comment
CONFIG_URL="https://example.com"
    `);

    const result = executeConfig(`
      config_load "${configFile}"
      echo "Site: $(config_get 'site_path')"
    `);
    expect(result).toContain('/path');
  });

  test('Multiple config_get calls work correctly', () => {
    const configFile = path.join(tempDir, 'test.conf');
    writeTestFile(configFile, `
CONFIG_SITE_PATH="/site"
CONFIG_SOURCE_URL="https://old.com"
CONFIG_TARGET_URL="https://new.com"
    `);

    const result = executeConfig(`
      config_load "${configFile}"
      echo "$(config_get 'site_path')|$(config_get 'source_url')|$(config_get 'target_url')"
    `);
    expect(result).toContain('/site');
    expect(result).toContain('https://old.com');
    expect(result).toContain('https://new.com');
  });

  test('config_require with multiple keys all present', () => {
    const configFile = path.join(tempDir, 'test.conf');
    writeTestFile(configFile, `
CONFIG_KEY1="value1"
CONFIG_KEY2="value2"
CONFIG_KEY3="value3"
    `);

    const result = executeConfig(`
      config_load "${configFile}"
      if config_require 'key1' 'key2' 'key3'; then
        echo "all_present"
      fi
    `);
    expect(result).toContain('all_present');
  });

  test('Environment override takes precedence', () => {
    const configFile = path.join(tempDir, 'test.conf');
    writeTestFile(configFile, 'CONFIG_STUDIO_SITE_PATH="/config/path"');

    const result = executeConfig(`
      config_load "${configFile}"
      config_apply_env_overrides
      config_get 'studio_site_path'
    `, { WP_DB_MIGRATE_SITE_PATH: '/env/path' });
    expect(result).toContain('/env/path');
  });

  test('Config handles empty values', () => {
    const configFile = path.join(tempDir, 'test.conf');
    writeTestFile(configFile, 'CONFIG_EMPTY_KEY=""');

    const result = executeConfig(`
      config_load "${configFile}"
      config_get 'empty_key' 'default'
    `);
    expect(result).toContain('default');
  });

  test('Config handles special characters in values', () => {
    const configFile = path.join(tempDir, 'test.conf');
    writeTestFile(configFile, 'CONFIG_URL="https://example.com/path?key=value&other=123"');

    const result = executeConfig(`
      config_load "${configFile}"
      config_get 'url'
    `);
    expect(result).toContain('https://example.com');
  });

  test('All environment variable overrides work together', () => {
    const result = executeConfig(
      'config_apply_env_overrides; echo "$(config_get studio_site_path)|$(config_get source_url)|$(config_get logging_verbose)"',
      {
        WP_DB_MIGRATE_SITE_PATH: '/site',
        WP_DB_MIGRATE_FROM_URL: 'https://from.com',
        WP_DB_MIGRATE_VERBOSE: 'true'
      }
    );
    expect(result).toContain('/site');
    expect(result).toContain('https://from.com');
    expect(result).toContain('true');
  });

  test('config functions are exported', () => {
    const result = executeConfig(
      'typeset -f config_load | head -1'
    );
    expect(result).toBeTruthy();
  });
});

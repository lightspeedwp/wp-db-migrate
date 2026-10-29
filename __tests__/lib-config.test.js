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

  // Library loading
  test('Config library loads successfully', () => {
    const result = executeConfig('echo "loaded"');
    expect(result).toContain('loaded');
  });

  // Config file loading
  test('config_load handles missing file gracefully', () => {
    const result = executeConfig('config_load "/nonexistent/file.conf"; echo "ok"');
    expect(result).toBeTruthy();
  });

  test('config_load parses simple config file', () => {
    const configFile = path.join(tempDir, 'test.conf');
    writeTestFile(configFile, 'SITE_PATH=/test/path');

    const result = executeConfig(`
      config_load "${configFile}"
      config_get 'site_path'
    `);
    expect(result).toContain('/test/path');
  });

  // config_get functionality
  test('config_get retrieves loaded values', () => {
    const configFile = path.join(tempDir, 'test.conf');
    writeTestFile(configFile, 'TEST_URL=https://example.com');

    const result = executeConfig(`
      config_load "${configFile}"
      config_get 'test_url'
    `);
    expect(result).toContain('https://example.com');
  });

  test('config_get returns default when key missing', () => {
    const result = executeConfig('config_get "missing_key" "default_value"');
    expect(result).toContain('default_value');
  });

  // config_require functionality
  test('config_require passes when all keys present', () => {
    const configFile = path.join(tempDir, 'test.conf');
    writeTestFile(configFile, 'KEY1=value1\nKEY2=value2');

    const result = executeConfig(`
      config_load "${configFile}"
      config_require 'key1' 'key2' && echo "pass" || echo "fail"
    `);
    expect(result).toContain('pass');
  });

  test('config_require fails when key missing', () => {
    const result = executeConfig('config_require "missing_key" 2>&1');
    expect(result.toLowerCase()).toContain('missing');
  });

  test('config_require shows specific missing keys', () => {
    const result = executeConfig('config_require "missing1" "missing2" 2>&1');
    expect(result).toContain('missing1');
    expect(result).toContain('missing2');
  });

  // Environment variable overrides
  test('config_apply_env_overrides sets site path from env', () => {
    const result = executeConfig(
      'config_apply_env_overrides; config_get "studio_site_path"',
      { WP_DB_MIGRATE_SITE_PATH: '/env/path' }
    );
    expect(result).toContain('/env/path');
  });

  test('config_apply_env_overrides sets source URL from env', () => {
    const result = executeConfig(
      'config_apply_env_overrides; config_get "source_url"',
      { WP_DB_MIGRATE_FROM_URL: 'https://env.com' }
    );
    expect(result).toContain('https://env.com');
  });

  test('config_apply_env_overrides sets target URL from env', () => {
    const result = executeConfig(
      'config_apply_env_overrides; config_get "target_url"',
      { WP_DB_MIGRATE_TO_URL: 'https://local.env' }
    );
    expect(result).toContain('https://local.env');
  });

  test('config_apply_env_overrides sets verbose flag from env', () => {
    const result = executeConfig(
      'config_apply_env_overrides; config_get "logging_verbose"',
      { WP_DB_MIGRATE_VERBOSE: 'true' }
    );
    expect(result).toContain('true');
  });

  test('config_apply_env_overrides sets dry-run flag from env', () => {
    const result = executeConfig(
      'config_apply_env_overrides; config_get "mode_dry_run"',
      { WP_DB_MIGRATE_DRY_RUN: 'true' }
    );
    expect(result).toContain('true');
  });

  test('Multiple environment overrides work together', () => {
    const result = executeConfig(
      'config_apply_env_overrides; config_get "studio_site_path"; config_get "source_url"; config_get "logging_verbose"',
      {
        WP_DB_MIGRATE_SITE_PATH: '/site',
        WP_DB_MIGRATE_FROM_URL: 'https://from.com',
        WP_DB_MIGRATE_VERBOSE: 'yes'
      }
    );
    expect(result).toContain('/site');
    expect(result).toContain('https://from.com');
    expect(result).toContain('yes');
  });

  // Configuration summary
  test('config_print_summary displays all fields', () => {
    const result = executeConfig('config_print_summary');
    expect(result).toContain('Configuration Summary');
    expect(result).toContain('Site Path');
  });

  // Edge cases
  test('Config handles comments in file', () => {
    const configFile = path.join(tempDir, 'test.conf');
    writeTestFile(configFile, '# Comment\nTEST_KEY=value\n# Another comment');

    const result = executeConfig(`
      config_load "${configFile}"
      config_get 'test_key'
    `);
    expect(result).toContain('value');
  });

  test('Config handles empty lines', () => {
    const configFile = path.join(tempDir, 'test.conf');
    writeTestFile(configFile, 'KEY1=value1\n\nKEY2=value2');

    const result = executeConfig(`
      config_load "${configFile}"
      config_get 'key2'
    `);
    expect(result).toContain('value2');
  });

  test('Config handles URL values with special chars', () => {
    const configFile = path.join(tempDir, 'test.conf');
    writeTestFile(configFile, 'URL=https://example.com/path?key=val');

    const result = executeConfig(`
      config_load "${configFile}"
      config_get 'url'
    `);
    expect(result).toContain('https://example.com');
    expect(result).toContain('?');
  });

  test('Environment override takes precedence over file config', () => {
    const configFile = path.join(tempDir, 'test.conf');
    writeTestFile(configFile, 'SITE_PATH=/file/path');

    const result = executeConfig(`
      config_load "${configFile}"
      config_apply_env_overrides
      config_get 'studio_site_path'
    `, { WP_DB_MIGRATE_SITE_PATH: '/env/path' });
    expect(result).toContain('/env/path');
  });

  test('Config functions are properly exported', () => {
    const result = executeConfig('type config_load');
    expect(result).toBeTruthy();
  });

  test('Config with quoted values preserves content', () => {
    const configFile = path.join(tempDir, 'test.conf');
    writeTestFile(configFile, 'PATH="/quoted/path"');

    const result = executeConfig(`
      config_load "${configFile}"
      config_get 'path'
    `);
    expect(result).toContain('/quoted/path');
  });

  test('Config handles underscores in key names', () => {
    const configFile = path.join(tempDir, 'test.conf');
    writeTestFile(configFile, 'MY_LONG_KEY_NAME=value');

    const result = executeConfig(`
      config_load "${configFile}"
      config_get 'my_long_key_name'
    `);
    expect(result).toContain('value');
  });

});

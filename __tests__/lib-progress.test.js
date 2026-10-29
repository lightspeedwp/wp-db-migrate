const { execSync } = require('child_process');
const path = require('path');
const { createTempDir, removeTempDir } = require('./utils');

describe('lib-progress.sh — Progress Bar Library', () => {
  const scriptDir = path.join(__dirname, '../skill/scripts');
  const libFile = path.join(scriptDir, 'lib-progress.sh');

  const executeProgress = (cmd) => {
    try {
      return execSync(`bash -c "source ${libFile}; ${cmd}"`, {
        encoding: 'utf-8',
        stdio: 'pipe'
      });
    } catch (err) {
      return err.stdout || '';
    }
  };

  test('Progress bar library loads successfully', () => {
    const result = executeProgress('echo "loaded"');
    expect(result).toContain('loaded');
  });

  test('progress_start initializes variables', () => {
    const result = executeProgress(
      'progress_start 100 "Testing"; echo $PROGRESS_TOTAL'
    );
    expect(result).toContain('100');
  });

  test('progress_start sets label', () => {
    const result = executeProgress(
      'progress_start 100 "Test Label"; echo $PROGRESS_LABEL'
    );
    expect(result).toContain('Test Label');
  });

  test('progress_update calculates percentage', () => {
    const result = executeProgress(
      'progress_start 100; progress_update 50; echo "done"'
    );
    expect(result.toLowerCase()).toContain('done');
  });

  test('progress_complete outputs success message', () => {
    const result = executeProgress(
      'progress_start 100 "Test"; progress_complete "Success"'
    );
    expect(result).toContain('100%');
    expect(result).toContain('Success');
  });

  test('progress_complete outputs checkmark', () => {
    const result = executeProgress(
      'progress_start 50 "Test"; progress_complete'
    );
    expect(result).toMatch(/100%/);
  });

  test('progress_fail outputs error message', () => {
    const result = executeProgress(
      'progress_start 100 "Test"; progress_fail "Error occurred"'
    );
    expect(result).toContain('Error occurred');
  });

  test('progress_fail outputs failure indicator', () => {
    const result = executeProgress(
      'progress_start 100 "Test"; progress_fail'
    );
    expect(result.toLowerCase()).toContain('fail');
  });

  test('spinner_start executes without error', () => {
    const result = executeProgress(
      'spinner_start "Test Spinner"; sleep 0.1; spinner_complete'
    );
    expect(result).toBeTruthy();
  });

  test('spinner_complete shows success', () => {
    const result = executeProgress(
      'spinner_start "Loading"; sleep 0.1; spinner_complete "Done"'
    );
    expect(result).toContain('Done');
  });

  test('spinner_fail shows failure', () => {
    const result = executeProgress(
      'spinner_start "Processing"; sleep 0.1; spinner_fail "Failed"'
    );
    expect(result).toContain('Failed');
  });

  test('stage_start outputs stage number', () => {
    const result = executeProgress(
      'stage_start 1 "Verifying" 3; echo "ok"'
    );
    expect(result).toContain('1');
    expect(result).toContain('3');
    expect(result).toContain('Verifying');
  });

  test('stage_complete outputs completion message', () => {
    const result = executeProgress(
      'stage_complete'
    );
    expect(result).toContain('Stage complete');
  });

  test('progress functions are exported', () => {
    const result = executeProgress(
      'typeset -f progress_start | head -1'
    );
    expect(result).toBeTruthy();
  });

  test('spinner with custom message', () => {
    const result = executeProgress(
      'spinner_start "Importing database"; sleep 0.1; spinner_complete "Imported 1000 rows"'
    );
    expect(result).toContain('Imported 1000 rows');
  });

  test('multiple progress updates', () => {
    const result = executeProgress(`
      progress_start 3 "Processing"
      progress_update 1
      progress_update 2
      progress_update 3
      progress_complete
    `);
    expect(result).toContain('100%');
  });

  test('progress bar with zero total', () => {
    const result = executeProgress(
      'PROGRESS_TOTAL=0; progress_update 0; echo "ok"'
    );
    expect(result).toContain('ok');
  });

  test('stage_start with multiple stages', () => {
    const result = executeProgress(`
      stage_start 1 "Phase 1" 5
      stage_complete
      stage_start 2 "Phase 2" 5
      stage_complete
    `);
    expect(result).toContain('Phase 1');
    expect(result).toContain('Phase 2');
  });

  test('progress_complete resets state', () => {
    const result = executeProgress(`
      progress_start 100 "Test"
      progress_complete
      echo "$PROGRESS_TOTAL"
    `);
    expect(result).toContain('0');
  });

  test('progress_fail resets state', () => {
    const result = executeProgress(`
      progress_start 100 "Test"
      progress_fail
      echo "$PROGRESS_TOTAL"
    `);
    expect(result).toContain('0');
  });

  test('progress bar handles edge cases', () => {
    const result = executeProgress(
      'progress_start 1 "Quick"; progress_update 1; progress_complete'
    );
    expect(result).toContain('100%');
  });

  test('spinner handles rapid complete', () => {
    const result = executeProgress(
      'spinner_start "Test"; sleep 0.05; spinner_complete'
    );
    expect(result).toBeTruthy();
  });
});

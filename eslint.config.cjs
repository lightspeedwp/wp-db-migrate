module.exports = [
  {
    ignores: [
      'node_modules/',
      'coverage/',
      'dist/',
      'build/',
      '.git/',
      '__tests__/coverage/',
      'jest.config.js',
      '.yamllint.config.cjs',
      '*.yml',
      '*.yaml',
    ],
  },
  {
    files: ['**/*.js', '**/*.cjs', '**/*.mjs'],
    languageOptions: {
      ecmaVersion: 2020,
      sourceType: 'module',
      globals: {
        console: 'readonly',
        process: 'readonly',
      },
    },
    rules: {
      'no-unused-vars': ['error', { argsIgnorePattern: '^_', varsIgnorePattern: '^_' }],
      'no-console': 'off',
      'prefer-const': 'warn',
      eqeqeq: ['error', 'always'],
      curly: ['error', 'all'],
      semi: ['error', 'always'],
      quotes: ['error', 'single', { avoidEscape: true }],
      indent: ['error', 2],
      'comma-dangle': ['error', 'always-multiline'],
      'trailing-comma': 'off',
    },
  },
];

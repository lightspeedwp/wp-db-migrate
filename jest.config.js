module.exports = {
  testEnvironment: 'node',
  testMatch: ['**/skill/scripts/__tests__/**/*.test.js'],
  collectCoverageFrom: [
    'skill/scripts/*.sh',
  ],
  coveragePathIgnorePatterns: [
    '/node_modules/',
    '/__tests__/',
    '/\\..*/',
  ],
  testTimeout: 120000,
  verbose: true,
};

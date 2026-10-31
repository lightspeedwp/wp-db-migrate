module.exports = {
  extends: 'default',
  rules: {
    'line-length': {
      max: 120,
      level: 'warning'
    },
    'indentation': {
      spaces: 2
    },
    'comments': {
      min-spaces-from-content: 2
    },
    'truthy': 'disable'
  },
  ignores: [
    'node_modules/',
    '.git/',
    'coverage/',
    'build/',
    'dist/'
  ]
};

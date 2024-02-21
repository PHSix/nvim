// eslint.config.js
const antfu = require('@antfu/eslint-config').default

module.exports = antfu({
  stylistic: {
    indent: 2,
  },

  rules: {
    'style/brace-style': [
      'warn',
      '1tbs',
    ],
  },
})

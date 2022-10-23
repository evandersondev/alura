module.exports = {
  "env": {
    "jest/globals": true
  },
  "extends": [
    "next",
    "eslint:recommended",
    "plugin:jest/recommended",
    "plugin:prettier/recommended"
  ],
  "rules": {
    "prettier/prettier": "error",
    "no-console": "off",
    "@next/next/mo-html-link-for-pages": "off"
  }
}

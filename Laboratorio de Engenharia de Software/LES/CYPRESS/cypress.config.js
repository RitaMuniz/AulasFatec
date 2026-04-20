const { defineConfig } = require("cypress");

module.exports = defineConfig({
    chromeWebSecurity: false, // Problemas de Cross origin
    allowCypressEnv: false,
    e2e: {
        setupNodeEvents(on, config) {
      // implement node event listeners here
    },
  },
});

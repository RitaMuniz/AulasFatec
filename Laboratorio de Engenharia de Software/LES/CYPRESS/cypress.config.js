const { defineConfig } = require("cypress");
const fs = require("fs");
const path = require("path");

module.exports = defineConfig({
    chromeWebSecurity: false, // Problemas de Cross origin
    allowCypressEnv: false,
    e2e: {
        setupNodeEvents(on, config) {
      // implement node event listeners here
            on("task", {
                resetDb() {
                    const bancoBase = path.resolve(__dirname, "../livraria-base.db");
                    const bancoTeste = path.resolve(__dirname, "../livraria.db");

                    fs.copyFileSync(bancoBase, bancoTeste);

                    return null;
                }
            });

            return config;
        }
    },

});

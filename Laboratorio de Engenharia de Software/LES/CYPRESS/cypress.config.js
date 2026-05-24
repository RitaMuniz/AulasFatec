const { defineConfig } = require("cypress");
const fs = require("fs");
const path = require("path");

module.exports = defineConfig({

    video: true,
    videosFolder: 'cypress/videos',

    reporter: 'cypress-multi-reporters',
    reporterOptions: {
        reporterEnabled: 'cypress-mochawesome-reporter, mocha-junit-reporter',
        mochaJunitReporterReporterOptions:{
            mochaFile: 'cypress/reports/junit/results-[hash].xml',
        },
        cypressMochawesomeReporterReporterOptions: {
            charts: true,
            reportPageTitle: 'Relatorio de teste',
            embeddedScreenshots: true,
            inlineAssets: true,
            saveAllAttempts: false
        }
    },
    chromeWebSecurity: false, // Problemas de Cross origin
    allowCypressEnv: true,
    e2e: {
        env:{
            user:'caique'
        },
        baseUrl: 'http://localhost:8080/LES',
        setupNodeEvents(on, config) {
      // implement node event listeners here
            require('cypress-mochawesome-reporter/plugin')(on)
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

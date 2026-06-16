const { defineConfig } = require("cypress");
const fs = require("fs");
const path = require("path");

// Verifica se deve executar em modo lento
const isSlowMode = process.env.CYPRESS_MODE === 'lento';

module.exports = defineConfig({
    // Configurações condicionais de timeout
    defaultCommandTimeout: isSlowMode ? 15000 : 4000,
    pageLoadTimeout: isSlowMode ? 120000 : 30000,
    responseTimeout: isSlowMode ? 60000 : 30000,
    execTimeout: isSlowMode ? 120000 : 60000,
    taskTimeout: isSlowMode ? 120000 : 60000,

    // Configurações de animação (maior tolerância no modo lento)
    animationDistanceThreshold: isSlowMode ? 10 : 5,
    waitForAnimations: true,

    video: true,
    videosFolder: 'cypress/videos',

    reporter: 'cypress-multi-reporters',
    reporterOptions: {
        reporterEnabled: 'cypress-mochawesome-reporter, mocha-junit-reporter',
        mochaJunitReporterReporterOptions: {
            mochaFile: `cypress/reports/junit/results-${isSlowMode ? 'lento' : 'rapido'}-[hash].xml`,
        },
        cypressMochawesomeReporterReporterOptions: {
            charts: true,
            reportPageTitle: `Relatorio de teste - ${isSlowMode ? 'LENTO (Debug)' : 'RÁPIDO'}`,
            embeddedScreenshots: true,
            inlineAssets: true,
            saveAllAttempts: false
        }
    },

    chromeWebSecurity: false,
    allowCypressEnv: true,

    e2e: {
        env: {
            user: 'caique',
            MODE: isSlowMode ? 'lento' : 'rapido'
        },
        baseUrl: 'http://localhost:8080/LES',
        setupNodeEvents(on, config) {
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
const {defineConfig} = require('cypress')
const baseConfig = require('./cypress.config')

const e2e = {
    baseUrl: 'https://www.qa.soucedemo.com/',
    env:{
        usarname: 'QA_sauce',
        password: 'QA_secret'
    }
}

module.exports = defineConfig({
    ...baseConfig,
    e2e
})
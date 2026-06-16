// cypress/support/e2e.js
import 'cypress-mochawesome-reporter/register'
import './commands'
import { slowCypressDown } from 'cypress-slow-down'

const isSlowMode = Cypress.env('MODE') === 'lento'

if (isSlowMode) {
    // Delay de 120ms por caractere na digitação
    Cypress.Commands.overwrite('type', (originalFn, element, text, options) => {
        const slowOptions = { delay: 120, ...options }
        return originalFn(element, text, slowOptions)
    })

    // Delay de 500ms entre comandos (cliques, navegação, etc)
    slowCypressDown(500)

} else {
    console.log('🐇 Modo RÁPIDO')
}
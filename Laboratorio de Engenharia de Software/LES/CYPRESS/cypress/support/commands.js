// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************

// Seu comando existente
Cypress.Commands.add("resetarBanco", () => {
    cy.task("resetDb");
});

// ==============================================
// COMANDOS PARA MODO LENTO (opcionais)
// ==============================================

// Comando para clique lento - use quando estiver debugando
Cypress.Commands.add('clickSlow', { prevSubject: 'element' }, (element, waitTime = 300) => {
    cy.wrap(element).wait(waitTime).click()
})

// Comando para clique muito lento (para debugging profundo)
Cypress.Commands.add('clickVerySlow', { prevSubject: 'element' }, (element, waitTime = 1000) => {
    cy.wrap(element).wait(waitTime).click()
})

// Comando para digitar lento
Cypress.Commands.add('typeSlow', { prevSubject: 'element' }, (element, text, delay = 80) => {
    cy.wrap(element).type(text, { delay: delay })
})

// Comando para digitar muito lento
Cypress.Commands.add('typeVerySlow', { prevSubject: 'element' }, (element, text, delay = 200) => {
    cy.wrap(element).type(text, { delay: delay })
})

// Comando para clique rápido (padrão do Cypress)
Cypress.Commands.add('clickFast', { prevSubject: 'element' }, (element) => {
    cy.wrap(element).click()
})

// Comando para digitar rápido (padrão do Cypress)
Cypress.Commands.add('typeFast', { prevSubject: 'element' }, (element, text) => {
    cy.wrap(element).type(text)
})

// Comando para esperar com log (útil para debug)
Cypress.Commands.add('waitLog', (ms, message = 'Esperando') => {
    cy.wait(ms, { log: false })
    cy.log(`${message} - ${ms}ms`)
})
describe('Register users alura pic', () => {
  beforeEach(() => {
    cy.visit("/")
  })

  it('Verify messages is validated', () => {
    cy.contains('a', 'Register now').click()
    cy.contains('button', 'Register').click()
    cy.contains('ap-vmessage', 'Email is required!').should('be.visible')
    cy.contains('button', 'Register').click()
    cy.contains('ap-vmessage', 'Full name is required!').should('be.visible')
    cy.contains('ap-vmessage', 'User name is required!').should('be.visible')
    cy.contains('ap-vmessage', 'Password is required!').should('be.visible')
  })

  it('Verify message email is invalidated', () => {
    cy.contains('a', 'Register now').click()
    cy.contains('button', 'Register').click()
    cy.get('input[formcontrolname="email"]').type('evan')
    cy.contains('ap-vmessage', 'Invalid e-mail').should('be.visible')
  })

  it('Verify message password is length < 8', () => {
    cy.contains('a', 'Register now').click()
    cy.contains('button', 'Register').click()
    cy.get('input[formcontrolname="password"]').type('123')
    cy.contains('button', 'Register').click()
    cy.contains('ap-vmessage', 'Mininum length is 8').should('be.visible')
  })

  const users = require('../../fixtures/users.json')
  users.forEach(user => {
    it.only(`Register new user (${user.fullName})`, () => {
      cy.contains('a', 'Register now').click()
      cy.contains('button', 'Register').click()
      cy.register(user.email, user.fullName, user.userName, user.password)
      cy.contains('button', 'Register').click()
    })
  })
})
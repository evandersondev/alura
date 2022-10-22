describe('Login users alura pic', () => {
  beforeEach(() => {
    cy.visit('https://alura-fotos.herokuapp.com')

    cy.intercept('POST', 'https://apialurapic.herokuapp.com/user/login', {
      statusCode: 400
    }).as('stubPost')
  })

  it('Should do login with user valid', () => {
    cy.login(Cypress.env('userName'), Cypress.env('password'))
    // cy.wait('@stubPost')
    cy.contains('a', '(Logout)').should('be.visible')
  })

  it('Should don\'t login with user invalid', () => {
    cy.login('evandersons', '123')
    cy.on('window:alert', (str) => {
      expect(str).to.equal('Invalid user name or password')
    })
  })
})
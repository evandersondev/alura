describe('Login and register of the users alura pic', () => {
  beforeEach(() => {
    cy.visit('https://alura-fotos.herokuapp.com')
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

  it.only('Should do login with user valid', () => {
    cy.login('flavio', '123')
    cy.contains('a', '(Logout)').should('be.visible')
  })

  it.only('Should don\'t login with user invalid', () => {
    cy.login('evandersons', '123')
    cy.on('window:alert', (str) => {
      expect(str).to.equal('Invalid user name or password')
    })
  })
})
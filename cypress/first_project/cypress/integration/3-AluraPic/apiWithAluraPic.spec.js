describe('Search photos and datas', () => {
  it('Search photos by Flavio', () => {
    cy.request({
      method: 'GET',
      url: 'https://apialurapic.herokuapp.com/flavio/photos'
    }).then(response => {
      expect(response.status).to.be.equal(200)
      expect(response.body).is.not.empty
      expect(response.body[0]).to.have.property('description')
      expect(response.body[0].description).to.be.equal('Farol iluminado')
    })
  })

  it.only('Do login by Flavio', () => {
    cy.request({
      method: 'POST',
      url: 'https://apialurapic.herokuapp.com/user/login',
      body: Cypress.env()
    }).then(response => {
      expect(response.status).to.be.equal(200)
      expect(response.body).is.not.empty
      expect(response.body).to.have.property('id')
      expect(response.body.id).to.be.equal(1)
    })
  })
})
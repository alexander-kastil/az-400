context('Simple e2e tests', () => {
  beforeEach(() => {
    cy.visit(Cypress.config('baseUrl'));
  });

  describe('Left Menu', () => {
    it('Shows the menu when clicked', () => {
      cy.get('.clickable').first().click();
    });

    it('Has elements in the side menu', () => {
      cy.get('.clickable').first().click();
      cy.get('button.mat-raised-button').should('have.length', 2);
    });

    it('Shows render 3 rows', () => {
      cy.contains('Food').click({ force: true });
      cy.get('.mat-row').should('have.length', 3);
    });
  });
});
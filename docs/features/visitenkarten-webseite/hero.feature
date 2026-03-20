Feature: Hero Section
  As a visitor landing on alltagsbiene-im-vest.de
  I want to immediately understand what the business offers
  So that I can decide whether the service is relevant for me

  Background:
    Given the visitor opens the index page

  Scenario: Hero section is visible above the fold
    Then a hero section is displayed
    And the hero section contains the business name "Alltagsbiene im Vest"
    And the hero section contains the tagline "Alltagshilfe für Menschen mit Pflegegrad – von jung bis alt"

  Scenario: Hero section contains a call-to-action button
    Then the hero section contains a CTA button linking to the contact section
    And the CTA button text is "Jetzt Kontakt aufnehmen"

  Scenario: Hero section displays a placeholder image area
    Then the hero section contains a visual element with a CSS background-color
    And no img element is required in the hero section until real photos are provided

  Scenario: Hero section is fully visible on mobile devices
    Given the viewport width is 375 pixels
    Then the hero section is fully visible without horizontal scrolling
    And the CTA button is tappable with a minimum size of 44x44 pixels

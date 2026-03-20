Feature: About Us Section
  As a visitor interested in the service
  I want to learn about the person behind "Alltagsbiene im Vest"
  So that I can build trust before making contact

  Background:
    Given the visitor opens the index page

  Scenario: About section identifies the business owner
    Then the about section contains the name "Sabrin Salkic"
    And the about section contains the business name "Alltagsbiene im Vest"

  Scenario: About section describes the service offering
    Then the about section explains that the business provides everyday assistance for people with a care level
    And the about section mentions the service area "Vest"

  Scenario: About section is reachable via navigation
    When the visitor clicks the navigation link for the about section
    Then the about section scrolls into view

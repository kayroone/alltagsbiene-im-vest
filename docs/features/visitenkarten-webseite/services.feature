Feature: Services Section
  As a visitor or family member of a person with a care level
  I want to see which services are offered
  So that I can determine if the service fits my needs

  Background:
    Given the visitor opens the index page

  Scenario: Services section lists all offered services
    Then the services section is displayed
    And the services section lists the following services:
      | service                                |
      | Begleitung                             |
      | Haushaltshilfe                         |
      | Betreuungsdienstleistungen             |
      | Unterstützung im täglichen Leben       |
      | Förderung der Selbstständigkeit        |
      | Familienentlastung                     |

  Scenario: Services section has separate visual areas for target groups
    Then the services section contains a visually distinct area for adults
    And the services section contains a visually distinct area for children
    And each target group area has an icon and a descriptive label

  Scenario: Services section mentions the geographic coverage
    Then the services section states that services are offered in the entire Vest region

  Scenario: Services section is reachable via navigation
    When the visitor clicks the navigation link for the services section
    Then the services section scrolls into view

  Scenario: Services section is readable on mobile devices
    Given the viewport width is 375 pixels
    Then all service items are displayed in a single-column layout
    And no service text is truncated or hidden

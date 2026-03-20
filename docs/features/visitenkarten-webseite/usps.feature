Feature: Unique Selling Points Section
  As a visitor comparing care assistance providers
  I want to see what differentiates "Alltagsbiene im Vest"
  So that I can make an informed decision

  Background:
    Given the visitor opens the index page

  Scenario: USP section displays all unique selling points
    Then the USP section is displayed
    And the USP section lists the following selling points:
      | selling_point         |
      | Haftpflichtversichert |
      | Anerkannt             |
      | Zeitlich flexibel     |
      | Keine Vorkasse        |

  Scenario: USP section mentions the insurance provider
    Then the USP section states that the business is insured via "Württembergische" in "Siegen"
    And the insurance type is identified as "Berufshaftpflicht"

  Scenario: USPs are displayed as individual cards with icons
    Then each USP is displayed as an individual card or tile
    And each USP card contains an icon and a text label
    And each USP card is visually distinguishable from the others

Feature: Legal Pages
  As a website operator
  I must provide legally required information (Impressum and Datenschutz)
  So that the website complies with German law (TMG, DSGVO)

  # --- Impressum ---

  Scenario: Impressum page contains the business owner's full name
    Given the visitor opens the Impressum page
    Then the page contains the name "Sabrin Salkic"

  Scenario: Impressum page contains the full business address
    Given the visitor opens the Impressum page
    Then the page contains the street "Steinstraße 14"
    And the page contains the postal code and city "45657 Recklinghausen"

  Scenario: Impressum page contains contact information
    Given the visitor opens the Impressum page
    Then the page contains the phone number "+49(0)2361/99 12 790"
    And the page contains the email "info@alltagsbiene-im-vest.de"

  Scenario: Impressum page contains the insurance information
    Given the visitor opens the Impressum page
    Then the page contains the insurance type "Berufshaftpflicht"
    And the page contains the insurer "Württembergische"

  Scenario: Impressum page is navigable back to the index page
    Given the visitor opens the Impressum page
    Then the page contains a link back to the index page

  Scenario: Impressum page has noindex meta tag
    Given the visitor opens the Impressum page
    Then the page contains a meta robots tag with value "noindex"

  # --- Datenschutz ---

  Scenario: Datenschutz page exists and has content
    Given the visitor opens the Datenschutz page
    Then the page contains a heading with text "Datenschutzerklärung"

  Scenario: Datenschutz page mentions the responsible party
    Given the visitor opens the Datenschutz page
    Then the page identifies "Sabrin Salkic" as the responsible party

  Scenario: Datenschutz page covers GitHub Pages hosting
    Given the visitor opens the Datenschutz page
    Then the page mentions "GitHub Pages" as the hosting provider
    And the page mentions that GitHub may collect server log data including IP addresses

  Scenario: Datenschutz page mentions OpenStreetMap data transmission
    Given the visitor opens the Datenschutz page
    Then the page mentions "OpenStreetMap" as an external service
    And the page explains that map tile data is loaded from OpenStreetMap tile servers
    And the page notes that the visitor's IP address is transmitted to OpenStreetMap servers

  Scenario: Datenschutz page is navigable back to the index page
    Given the visitor opens the Datenschutz page
    Then the page contains a link back to the index page

  Scenario: Datenschutz page has noindex meta tag
    Given the visitor opens the Datenschutz page
    Then the page contains a meta robots tag with value "noindex"

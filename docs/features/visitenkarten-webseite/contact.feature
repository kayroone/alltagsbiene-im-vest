Feature: Contact Section
  As a visitor who wants to use the service
  I want to find contact information easily
  So that I can get in touch with the business

  Background:
    Given the visitor opens the index page

  Scenario: Contact section displays the phone number
    Then the contact section contains a clickable phone link
    And the phone link href is "tel:+4923619912790"
    And the displayed phone number is "+49(0)2361/99 12 790"

  Scenario: Contact section displays the email address
    Then the contact section contains a clickable email link
    And the email link href is "mailto:info@alltagsbiene-im-vest.de"
    And the displayed email is "info@alltagsbiene-im-vest.de"

  Scenario: Contact section displays the business address
    Then the contact section contains the street "Steinstraße 14"
    And the contact section contains the city "45657 Recklinghausen"

  Scenario: Contact section links to Instagram
    Then the contact section contains a link to "https://www.instagram.com/alltagsbiene.im.vest/"
    And the Instagram link opens in a new tab

  Scenario: Contact section contains an OpenStreetMap embed showing business location
    Then the contact section contains an iframe with an OpenStreetMap embed
    And the OSM iframe has the attribute sandbox="allow-scripts allow-same-origin allow-popups"
    And the OSM iframe shows the location near "Steinstraße 14, 45657 Recklinghausen"

  Scenario: Contact section is reachable via navigation
    When the visitor clicks the navigation link for the contact section
    Then the contact section scrolls into view

  Scenario: Phone link is tappable on mobile devices
    Given the viewport width is 375 pixels
    Then the phone link has a minimum tap target size of 44x44 pixels

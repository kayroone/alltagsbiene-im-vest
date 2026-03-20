Feature: Page Structure and Navigation
  As a visitor on any device
  I want a clear page structure and working navigation
  So that I can find information quickly

  # --- Index Page Structure ---

  Scenario: Index page contains all required sections in order
    Given the visitor opens the index page
    Then the page contains the following sections in order:
      | section   |
      | Hero      |
      | About     |
      | Services  |
      | USPs      |
      | Contact   |

  Scenario: Index page has a navigation header
    Given the visitor opens the index page
    Then a navigation header is displayed
    And the navigation contains links to all sections on the page

  Scenario: Index page has a footer with legal links
    Given the visitor opens the index page
    Then a footer is displayed
    And the footer contains a link to the Impressum page
    And the footer contains a link to the Datenschutz page

  # --- Responsive Navigation ---

  Scenario: Desktop navigation shows all links inline
    Given the visitor opens the index page
    And the viewport width is 1024 pixels
    Then all navigation links are visible without opening a menu

  Scenario: Mobile navigation uses a hamburger menu
    Given the visitor opens the index page
    And the viewport width is 375 pixels
    Then a hamburger menu button is displayed
    And the hamburger menu button has an aria-expanded attribute set to "false"
    And the navigation links are hidden

  Scenario: Mobile hamburger menu can be opened and closed
    Given the visitor opens the index page
    And the viewport width is 375 pixels
    When the visitor clicks the hamburger menu button
    Then the navigation links become visible
    And the hamburger menu button has an aria-expanded attribute set to "true"
    When the visitor clicks the hamburger menu button again
    Then the navigation links are hidden
    And the hamburger menu button has an aria-expanded attribute set to "false"

  Scenario: Hamburger menu closes automatically after clicking a navigation link
    Given the visitor opens the index page
    And the viewport width is 375 pixels
    And the visitor clicks the hamburger menu button
    And the navigation links become visible
    When the visitor clicks a navigation link in the mobile menu
    Then the navigation links are hidden
    And the hamburger menu button has an aria-expanded attribute set to "false"

  Scenario: Hamburger menu closes when pressing the Escape key
    Given the visitor opens the index page
    And the viewport width is 375 pixels
    And the visitor clicks the hamburger menu button
    And the navigation links become visible
    When the visitor presses the Escape key
    Then the navigation links are hidden
    And the hamburger menu button has an aria-expanded attribute set to "false"

  # --- Multi-Page Structure ---

  Scenario: All three HTML pages exist and are reachable
    Given the visitor opens the index page
    Then the page loads successfully with HTTP status 200
    When the visitor navigates to "impressum.html"
    Then the page loads successfully with HTTP status 200
    When the visitor navigates to "datenschutz.html"
    Then the page loads successfully with HTTP status 200

  # --- Accessibility ---

  Scenario: All pages use semantic HTML landmarks
    Given the visitor opens the index page
    Then the page contains a "header" landmark
    And the page contains a "main" landmark
    And the page contains a "footer" landmark
    And the page contains a "nav" landmark

  Scenario: All pages have a single h1 heading
    Given the visitor opens the index page
    Then the page contains exactly one h1 element
    When the visitor navigates to "impressum.html"
    Then the page contains exactly one h1 element
    When the visitor navigates to "datenschutz.html"
    Then the page contains exactly one h1 element

  Scenario: Gold color is not used as text color on white background
    Given the visitor opens the index page
    Then no text element uses the color "#f4c141" on a white or light background
    And the primary gold color is only used for backgrounds, borders, or accent elements

  # --- Visual Design ---

  Scenario: Pages use the bee-themed color scheme with CSS variables
    Given the visitor opens the index page
    Then the CSS defines a custom property "--color-primary" in the gold spectrum near "#f4c141"
    And the CSS defines a custom property "--color-secondary" in the black spectrum near "#000000"

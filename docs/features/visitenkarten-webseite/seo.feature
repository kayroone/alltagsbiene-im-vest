Feature: SEO and Metadata
  As a business owner
  I want search engines to find and correctly display my website
  So that potential clients can discover my services online

  # --- Basic Meta Tags ---

  Scenario: Index page has a descriptive title tag
    Given the visitor opens the index page
    Then the page title is "Alltagsbiene im Vest – Alltagshilfe für Menschen mit Pflegegrad"

  Scenario: Index page has a meta description
    Given the visitor opens the index page
    Then the page has a meta description tag
    And the meta description is between 120 and 160 characters long
    And the meta description mentions the service area or the type of service

  Scenario: Index page has a canonical URL pointing to GitHub Pages
    Given the visitor opens the index page
    Then the page has a canonical link element
    And the canonical URL points to the GitHub Pages URL for this project

  # --- Open Graph Tags ---

  Scenario: Index page has Open Graph meta tags
    Given the visitor opens the index page
    Then the page has an "og:title" meta tag
    And the page has an "og:description" meta tag
    And the page has an "og:type" meta tag with value "website"
    And the page has an "og:url" meta tag
    And the page has an "og:image" meta tag referencing a placeholder image of 1200x630 pixels
    And the page has an "og:locale" meta tag with value "de_DE"

  # --- Twitter Card Tags ---

  Scenario: Index page has Twitter Card meta tags
    Given the visitor opens the index page
    Then the page has a "twitter:card" meta tag with value "summary_large_image"
    And the page has a "twitter:title" meta tag
    And the page has a "twitter:description" meta tag

  # --- JSON-LD Structured Data ---

  Scenario: Index page contains JSON-LD LocalBusiness structured data
    Given the visitor opens the index page
    Then the page contains a script tag of type "application/ld+json"
    And the JSON-LD data has "@type" set to "LocalBusiness"
    And the JSON-LD data has "name" set to "Alltagsbiene im Vest"

  Scenario: JSON-LD contains the correct address
    Given the visitor opens the index page
    Then the JSON-LD data contains an "address" object
    And the address "streetAddress" is "Steinstraße 14"
    And the address "postalCode" is "45657"
    And the address "addressLocality" is "Recklinghausen"
    And the address "addressCountry" is "DE"

  Scenario: JSON-LD contains contact information
    Given the visitor opens the index page
    Then the JSON-LD data has "telephone" set to "+4923619912790"
    And the JSON-LD data has "email" set to "info@alltagsbiene-im-vest.de"
    And the JSON-LD data has "url" set to "https://alltagsbiene-im-vest.de"

  # --- Crawling ---

  Scenario: robots.txt exists and allows crawling
    When the visitor requests "/robots.txt"
    Then the response status is 200
    And the file contains a "Sitemap" directive pointing to the sitemap URL

  Scenario: sitemap.xml exists and lists all public pages
    When the visitor requests "/sitemap.xml"
    Then the response status is 200
    And the sitemap contains the URL for the index page
    And the sitemap does not contain the URL for the Impressum page
    And the sitemap does not contain the URL for the Datenschutz page

  # --- Language ---

  Scenario: All pages declare the document language as German
    Given the visitor opens the index page
    Then the html element has a "lang" attribute with value "de"
    When the visitor navigates to "impressum.html"
    Then the html element has a "lang" attribute with value "de"
    When the visitor navigates to "datenschutz.html"
    Then the html element has a "lang" attribute with value "de"

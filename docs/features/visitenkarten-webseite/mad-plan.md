# MAD-Plan: Visitenkarten-Webseite "Alltagsbiene im Vest"

## Szenario-Inventar

| Feature File      | Szenarien | IDs der Arbeitspakete   |
| ----------------- | --------: | ----------------------- |
| (Scaffolding)     |         - | AP-001                  |
| structure.feature |        13 | AP-002 bis AP-007       |
| hero.feature      |         4 | AP-008, AP-009          |
| about.feature     |         3 | AP-010                  |
| services.feature  |         5 | AP-011, AP-011b, AP-012 |
| usps.feature      |         3 | AP-013                  |
| contact.feature   |         7 | AP-014, AP-015, AP-016  |
| legal.feature     |        12 | AP-017, AP-018          |
| seo.feature       |        11 | AP-019, AP-020, AP-021  |
| **Gesamt**        |    **58** | **23 Arbeitspakete**    |

---

## Arbeitspakete

---

### AP-001: Projekt-Scaffolding

**Beschreibung**: Projektstruktur anlegen -- package.json mit Playwright als dev-Dependency, playwright.config.js, .gitignore, leere Ordnerstruktur (css/, js/, assets/, tests/), leere Dateien (index.html, impressum.html, datenschutz.html, css/style.css, js/main.js).

**Gherkin-Referenz**: Keine (Infrastruktur-Voraussetzung)

**Input**: Keine

**Output**: Lauffaehige Projektstruktur mit `npx playwright test` als ausfuehrbarem Kommando (0 Tests, 0 Fehler).

**Seiteneffekte**: node_modules wird durch `npm install` erzeugt.

**Akzeptanzkriterien**:

- `npm install` laeuft fehlerfrei
- `npx playwright test` laeuft fehlerfrei (0 Tests gefunden)
- Ordnerstruktur: css/, js/, assets/, tests/ existieren
- Leere HTML-Dateien: index.html, impressum.html, datenschutz.html
- .gitignore enthaelt node_modules/

**Abhaengigkeiten**: Keine

**TDD-Plan**:

- Test: Kein Test -- Scaffolding wird durch erfolgreichen `npm install` und `npx playwright test` verifiziert
- Typ: Manuell (Infrastruktur)
- Red: Entfaellt
- Green: Dateien anlegen, npm install ausfuehren

---

### AP-002: HTML-Grundgeruest und Seitenstruktur (3 Seiten)

**Beschreibung**: Alle drei HTML-Seiten mit semantischem Grundgeruest befuellen: `<!DOCTYPE html>`, `<html lang="de">`, `<head>` mit charset/viewport, `<header>`, `<nav>`, `<main>`, `<footer>`. Jede Seite bekommt genau ein `<h1>`. Index-Seite bekommt leere Sections in korrekter Reihenfolge (hero, about, services, usps, contact). CSS-Variablen fuer Farbschema anlegen.

**Gherkin-Referenz**:

- structure.feature: "All three HTML pages exist and are reachable"
- structure.feature: "All pages use semantic HTML landmarks"
- structure.feature: "All pages have a single h1 heading"
- structure.feature: "Pages use the bee-themed color scheme with CSS variables"
- seo.feature: "All pages declare the document language as German"

**Input**: Leere HTML-Dateien aus AP-001

**Output**: 3 HTML-Seiten mit semantischen Landmarks, lang="de", je ein h1. CSS-Datei mit --color-primary und --color-secondary.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- Alle 3 Seiten laden mit HTTP 200 (via Playwright-Webserver)
- Jede Seite hat header, nav, main, footer Landmarks
- Jede Seite hat genau ein h1
- html-Element hat lang="de" auf allen Seiten
- CSS definiert --color-primary nahe #f4c141 und --color-secondary nahe #000000

**Zusammenfassung**: Diese 5 Szenarien gehoeren zusammen, weil sie alle das HTML-Grundgeruest betreffen und ohne einander nicht sinnvoll testbar sind.

**Abhaengigkeiten**: AP-001

**TDD-Plan**:

- Test: `tests/structure.spec.js` -- Pruefe HTTP 200 fuer alle 3 Seiten, semantische Landmarks (header, nav, main, footer), genau ein h1 pro Seite, lang="de". Pruefe CSS-Variablen --color-primary und --color-secondary.
- Typ: E2E (Playwright)
- Red: HTML-Dateien sind leer, keine Landmarks, kein lang-Attribut
- Green: HTML-Grundgeruest mit Landmarks, lang="de", h1, CSS-Variablen befuellen

---

### AP-003: Sektions-Reihenfolge auf der Index-Seite

**Beschreibung**: Die Sections auf der Index-Seite in der korrekten Reihenfolge anordnen: Hero, About, Services, USPs, Contact. Jede Section bekommt eine id (hero, about, services, usps, contact).

**Gherkin-Referenz**:

- structure.feature: "Index page contains all required sections in order"

**Input**: Index-Seite mit Grundgeruest aus AP-002

**Output**: Index-Seite mit 5 leeren Sections in korrekter Reihenfolge mit IDs.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- 5 Sections mit IDs hero, about, services, usps, contact existieren
- Reihenfolge im DOM ist exakt Hero > About > Services > USPs > Contact

**Abhaengigkeiten**: AP-002

**TDD-Plan**:

- Test: `tests/structure.spec.js` -- Pruefe Reihenfolge der Sections via querySelectorAll('section') und erwartete ID-Reihenfolge
- Typ: E2E (Playwright)
- Red: Sections haben keine IDs oder falsche Reihenfolge
- Green: Sections mit korrekten IDs in richtiger Reihenfolge einfuegen

---

### AP-004: Desktop-Navigation mit Section-Links

**Beschreibung**: Navigation im Header mit Links zu allen Sections: "Ueber uns" (#about), "Leistungen" (#services), "Vorteile" (#usps), "Kontakt" (#contact). Smooth-Scrolling via CSS. Desktop-Layout: Links inline sichtbar.

**Gherkin-Referenz**:

- structure.feature: "Index page has a navigation header"
- structure.feature: "Desktop navigation shows all links inline"

**Input**: Index-Seite mit Sections aus AP-003

**Output**: Sichtbare Navigation mit 4 Links, scroll-behavior: smooth im CSS.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- Nav enthaelt Links zu #about, #services, #usps, #contact
- Bei Viewport 1024px sind alle Links sichtbar ohne Menu
- CSS hat scroll-behavior: smooth

**Zusammenfassung**: Navigation-Header und Desktop-Layout gehoeren zusammen, weil die Links erst mit dem Desktop-Layout sichtbar getestet werden koennen.

**Abhaengigkeiten**: AP-003

**TDD-Plan**:

- Test: `tests/structure.spec.js` -- Bei 1024px Viewport: Pruefe dass Nav 4 Links enthaelt, alle sichtbar sind, hrefs auf die Sections zeigen
- Typ: E2E (Playwright)
- Red: Keine Nav-Links vorhanden
- Green: Nav mit Links und CSS-Styling implementieren

---

### AP-005a: Hamburger-Menu CSS + Button (Mobile Layout)

**Beschreibung**: Bei Viewport < 640px: Hamburger-Button im HTML anlegen und anzeigen, Nav-Links per CSS verstecken. Button hat aria-expanded="false". Oeffnen/Schliessen der Nav-Links per CSS-Klasse `.open`.

**Gherkin-Referenz**:

- structure.feature: "Mobile navigation uses a hamburger menu"
- structure.feature: "Mobile hamburger menu can be opened and closed"

**Input**: Desktop-Navigation aus AP-004

**Output**: Hamburger-Button sichtbar bei 375px, Nav-Links versteckt, Toggle per Klick funktioniert.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- Bei 375px: Hamburger-Button sichtbar, Nav-Links versteckt
- aria-expanded="false" initial, "true" nach Oeffnen
- Klick auf Button togglet Menu (JS: Toggle `.open` Klasse + aria-expanded)

**Abhaengigkeiten**: AP-004

**TDD-Plan**:

- Test: `tests/structure.spec.js` -- Bei 375px: (1) Button sichtbar, Links versteckt, aria-expanded="false". (2) Klick oeffnet Menu, aria-expanded="true". (3) Erneuter Klick schliesst.
- Typ: E2E (Playwright)
- Red: Kein Hamburger-Button, keine CSS Media Query
- Green: HTML-Button, CSS Media Query fuer Mobile, JS Toggle in main.js

---

### AP-005b: Hamburger-Menu Auto-Close + Escape

**Beschreibung**: Hamburger-Menu schliesst automatisch bei Klick auf einen Nav-Link und bei Escape-Taste. Focus bleibt auf Button nach Escape.

**Gherkin-Referenz**:

- structure.feature: "Hamburger menu closes automatically after clicking a navigation link"
- structure.feature: "Hamburger menu closes when pressing the Escape key"

**Input**: Hamburger-Menu aus AP-005a

**Output**: Auto-Close bei Link-Klick und Escape-Key.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- Klick auf Nav-Link schliesst Menu, aria-expanded="false"
- Escape-Taste schliesst Menu, aria-expanded="false"

**Abhaengigkeiten**: AP-005a

**TDD-Plan**:

- Test: `tests/structure.spec.js` -- Bei 375px: (1) Menu oeffnen, Link klicken -> Menu geschlossen. (2) Menu oeffnen, Escape -> Menu geschlossen.
- Typ: E2E (Playwright)
- Red: Menu bleibt nach Link-Klick/Escape offen
- Green: Event-Listener fuer Nav-Links und Escape in main.js

---

### AP-006: Footer mit Legal-Links

**Beschreibung**: Footer auf der Index-Seite mit Links zu impressum.html und datenschutz.html sowie Copyright-Zeile.

**Gherkin-Referenz**:

- structure.feature: "Index page has a footer with legal links"

**Input**: Index-Seite mit Grundgeruest aus AP-002

**Output**: Footer mit Links zu Impressum und Datenschutz.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- Footer enthaelt Link zu impressum.html
- Footer enthaelt Link zu datenschutz.html
- Copyright-Zeile vorhanden

**Abhaengigkeiten**: AP-002

**TDD-Plan**:

- Test: `tests/structure.spec.js` -- Pruefe Footer enthaelt Links mit href="impressum.html" und href="datenschutz.html"
- Typ: E2E (Playwright)
- Red: Footer ist leer
- Green: Links und Copyright-Text in Footer einfuegen

---

### AP-007: Gold-Farbe nicht als Textfarbe (Accessibility)

**Beschreibung**: Sicherstellen, dass die primaere Goldfarbe (#f4c141) nicht als Textfarbe auf weissem/hellem Hintergrund verwendet wird. Nur als Background, Border oder Akzent-Element.

**Gherkin-Referenz**:

- structure.feature: "Gold color is not used as text color on white background"

**Input**: Alle CSS-Regeln

**Output**: Keine Aenderung noetig wenn korrekt umgesetzt. Ggf. CSS-Korrekturen.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- Kein sichtbares Textelement hat color: #f4c141 auf weissem/hellem Hintergrund
- Gold wird nur fuer Backgrounds, Borders, Akzente verwendet

**Abhaengigkeiten**: AP-008, AP-010, AP-011, AP-013, AP-014 (alle Content-APs muessen fertig sein, damit der Regression-Guard sinnvoll ist)

**TDD-Plan**:

- Test: `tests/structure.spec.js` -- Iteriere ueber alle sichtbaren Textelemente, pruefe computed color != #f4c141 auf hellem Background
- Typ: E2E (Playwright)
- Red: Regression-Guard -- Test prueft bestehenden Content auf korrekte Farbverwendung
- Green: CSS anpassen falls Gold als Textfarbe auf Weiss gefunden wird

---

### AP-008: Hero Section (Inhalt + Platzhalter)

**Beschreibung**: Hero-Section mit Business-Name "Alltagsbiene im Vest", Tagline, CTA-Button (Link zu #contact), Platzhalter-Bereich mit CSS-Background-Color (helles Grau). Kein img-Element.

**Gherkin-Referenz**:

- hero.feature: "Hero section is visible above the fold"
- hero.feature: "Hero section contains a call-to-action button"
- hero.feature: "Hero section displays a placeholder image area"

**Input**: Index-Seite mit leerer Hero-Section aus AP-003

**Output**: Hero-Section mit Textinhalt, CTA-Button, visuellem Platzhalter.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- Hero-Section enthaelt "Alltagsbiene im Vest"
- Hero-Section enthaelt Tagline "Alltagshilfe fuer Menschen mit Pflegegrad -- von jung bis alt"
- CTA-Button mit Text "Jetzt Kontakt aufnehmen" verlinkt auf #contact
- Visuelles Element mit CSS background-color vorhanden
- Kein img-Element in der Hero-Section

**Zusammenfassung**: Alle 3 Desktop-Hero-Szenarien gehoeren zusammen -- sie beschreiben den statischen Inhalt einer einzelnen Section.

**Abhaengigkeiten**: AP-003

**TDD-Plan**:

- Test: `tests/hero.spec.js` -- Pruefe Hero-Section enthaelt Business-Name, Tagline, CTA-Button mit href="#contact" und Text, Platzhalter-Element mit background-color, kein img-Element
- Typ: E2E (Playwright)
- Red: Hero-Section ist leer
- Green: HTML-Inhalt und CSS-Styling fuer Hero einfuegen

---

### AP-009: Hero Section Mobile-Responsiveness

**Beschreibung**: Hero-Section bei 375px Viewport: Kein horizontales Scrollen, CTA-Button mindestens 44x44px gross (Tap-Target).

**Gherkin-Referenz**:

- hero.feature: "Hero section is fully visible on mobile devices"

**Input**: Hero-Section aus AP-008

**Output**: Responsive CSS fuer Hero-Section.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- Bei 375px kein horizontales Scrollen
- CTA-Button mindestens 44x44px (Breite und Hoehe)

**Abhaengigkeiten**: AP-008

**TDD-Plan**:

- Test: `tests/hero.spec.js` -- Bei 375px Viewport: Pruefe scrollWidth <= clientWidth, CTA-Button boundingBox >= 44x44
- Typ: E2E (Playwright)
- Red: CTA-Button zu klein oder Overflow
- Green: Mobile-CSS anpassen (min-height, padding, width)

---

### AP-010: About Section

**Beschreibung**: About-Section mit Name "Sabrin Salkic", Business-Name "Alltagsbiene im Vest", Beschreibung der Alltagshilfe fuer Menschen mit Pflegegrad, Erwaehnung des Servicegebiets "Vest". Section ueber Nav erreichbar.

**Gherkin-Referenz**:

- about.feature: "About section identifies the business owner"
- about.feature: "About section describes the service offering"
- about.feature: "About section is reachable via navigation"

**Input**: Index-Seite mit leerer About-Section aus AP-003, Navigation aus AP-004

**Output**: About-Section mit Textinhalt.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- About-Section enthaelt "Sabrin Salkic"
- About-Section enthaelt "Alltagsbiene im Vest"
- About-Section beschreibt Alltagshilfe fuer Menschen mit Pflegegrad
- About-Section erwaehnt "Vest"
- Klick auf Nav-Link "Ueber uns" scrollt About-Section in den Viewport

**Zusammenfassung**: Alle 3 About-Szenarien gehoeren zusammen -- sie beschreiben den Inhalt einer einzelnen Section und die Navigation dorthin (die bereits in AP-004 implementiert wurde, nur der Scroll-Test fehlt).

**Abhaengigkeiten**: AP-004

**TDD-Plan**:

- Test: `tests/about.spec.js` -- Pruefe About-Section enthaelt "Sabrin Salkic", "Alltagsbiene im Vest", Pflegegrad-Text, "Vest". Klick auf Nav-Link -> Section ist im Viewport.
- Typ: E2E (Playwright)
- Red: About-Section ist leer
- Green: HTML-Inhalt einfuegen

---

### AP-011: Services Section (Leistungsliste + Gebiet + Navigation)

**Beschreibung**: Services-Section mit Liste aller 6 Dienstleistungen, Erwaehnung des Servicegebiets "Vest". Section ueber Nav erreichbar.

**Gherkin-Referenz**:

- services.feature: "Services section lists all offered services"
- services.feature: "Services section mentions the geographic coverage"
- services.feature: "Services section is reachable via navigation"

**Input**: Index-Seite mit leerer Services-Section aus AP-003

**Output**: Services-Section mit Dienstleistungsliste und Gebietsangabe.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- Alle 6 Services gelistet: Begleitung, Haushaltshilfe, Betreuungsdienstleistungen, Unterstützung im täglichen Leben, Förderung der Selbstständigkeit, Familienentlastung
- Erwaehnung "Vest" als Servicegebiet
- Nav-Link "Leistungen" scrollt Section in Viewport

**Abhaengigkeiten**: AP-004

**TDD-Plan**:

- Test: `tests/services.spec.js` -- Pruefe alle 6 Services vorhanden, "Vest" erwaehnt, Nav-Scroll funktioniert
- Typ: E2E (Playwright)
- Red: Services-Section ist leer
- Green: HTML-Inhalt mit Liste, CSS-Styling

---

### AP-011b: Services Section Zielgruppen-Cards

**Beschreibung**: Zwei visuell unterscheidbare Bereiche fuer Erwachsene und Kinder in der Services-Section, je mit Unicode-Icon und Label.

**Gherkin-Referenz**:

- services.feature: "Services section has separate visual areas for target groups"

**Input**: Services-Section aus AP-011

**Output**: Zielgruppen-Cards mit Icons und Labels.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- Zwei visuell unterscheidbare Bereiche (Erwachsene, Kinder)
- Jeder Bereich hat ein Icon und ein Label
- Bereiche visuell unterscheidbar (eigene Container, ggf. unterschiedliche Hintergrundfarbe oder Border)

**Abhaengigkeiten**: AP-011

**TDD-Plan**:

- Test: `tests/services.spec.js` -- Pruefe 2 Zielgruppen-Bereiche mit je Icon-Element und Text-Label, visuell unterscheidbar
- Typ: E2E (Playwright)
- Red: Keine Zielgruppen-Bereiche vorhanden
- Green: HTML-Cards mit Unicode-Icons, CSS-Styling

---

### AP-012: Services Section Mobile Layout

**Beschreibung**: Bei 375px Viewport: Alle Service-Items in Single-Column-Layout, kein Text abgeschnitten oder versteckt.

**Gherkin-Referenz**:

- services.feature: "Services section is readable on mobile devices"

**Input**: Services-Section aus AP-011

**Output**: Responsive CSS fuer Services.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- Bei 375px: Alle Items in einer Spalte
- Kein Text truncated oder overflow: hidden

**Abhaengigkeiten**: AP-011

**TDD-Plan**:

- Test: `tests/services.spec.js` -- Bei 375px: Pruefe jedes Service-Item hat volle Breite (nahe Container-Breite), kein text-overflow: ellipsis, kein overflow: hidden auf Text-Elementen
- Typ: E2E (Playwright)
- Red: Items nebeneinander oder Text abgeschnitten
- Green: Mobile-CSS: flex-direction column oder Grid single-column

---

### AP-013: USP Section (Vorteile)

**Beschreibung**: USP-Section mit 4 Selling Points als individuelle Cards/Tiles (je Icon + Text-Label, visuell unterscheidbar). Erwaehnung der Versicherung: Berufshaftpflicht, Wuerttembergische, Siegen.

**Gherkin-Referenz**:

- usps.feature: "USP section displays all unique selling points"
- usps.feature: "USP section mentions the insurance provider"
- usps.feature: "USPs are displayed as individual cards with icons"

**Input**: Index-Seite mit leerer USP-Section aus AP-003

**Output**: USP-Section mit 4 Cards und Versicherungsinfo.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- 4 USPs angezeigt: Haftpflichtversichert, Anerkannt, Zeitlich flexibel, Keine Vorkasse
- Jede USP als eigene Card/Tile mit Icon und Text-Label
- Cards visuell unterscheidbar (z.B. durch Border, Shadow oder Background)
- Versicherungsinfo: "Berufshaftpflicht", "Wuerttembergische", "Siegen"

**Zusammenfassung**: Alle 3 USP-Szenarien gehoeren zusammen -- sie beschreiben die gleiche Section, Cards sind das primaere UI-Element.

**Abhaengigkeiten**: AP-003

**TDD-Plan**:

- Test: `tests/usps.spec.js` -- Pruefe 4 USP-Texte vorhanden, jede in eigenem Container mit Icon-Element und Text, visuell unterscheidbar (z.B. verschiedene Positionen), Versicherungstext vorhanden
- Typ: E2E (Playwright)
- Red: USP-Section ist leer
- Green: HTML mit 4 Cards, Unicode-Icons, CSS-Styling, Versicherungstext

---

### AP-014: Contact Section (Kontaktdaten)

**Beschreibung**: Contact-Section mit klickbarem Telefon-Link (tel:), klickbarem E-Mail-Link (mailto:), Adresse (Steinstrasse 14, 45657 Recklinghausen), Instagram-Link (neuer Tab). Section ueber Nav erreichbar.

**Gherkin-Referenz**:

- contact.feature: "Contact section displays the phone number"
- contact.feature: "Contact section displays the email address"
- contact.feature: "Contact section displays the business address"
- contact.feature: "Contact section links to Instagram"
- contact.feature: "Contact section is reachable via navigation"

**Input**: Index-Seite mit leerer Contact-Section aus AP-003

**Output**: Contact-Section mit allen Kontaktdaten.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- Telefon-Link: href="tel:+4923619912790", angezeigter Text "+49(0)2361/99 12 790"
- E-Mail-Link: href="mailto:info@alltagsbiene-im-vest.de", angezeigter Text "info@alltagsbiene-im-vest.de"
- Adresse: "Steinstrasse 14" und "45657 Recklinghausen"
- Instagram-Link: href="https://www.instagram.com/alltagsbiene.im.vest/", target="\_blank"
- Nav-Link "Kontakt" scrollt Section in Viewport

**Zusammenfassung**: 5 Szenarien beschreiben den statischen Inhalt der Contact-Section.

**Abhaengigkeiten**: AP-004

**TDD-Plan**:

- Test: `tests/contact.spec.js` -- Pruefe Telefon-Link (href, Text), E-Mail-Link (href, Text), Adresse-Texte, Instagram-Link (href, target="\_blank"), Nav-Scroll
- Typ: E2E (Playwright)
- Red: Contact-Section ist leer
- Green: HTML mit Links und Adresse einfuegen

---

### AP-015: Contact Section OSM-Karte

**Beschreibung**: OpenStreetMap-Embed als iframe in der Contact-Section mit sandbox-Attribut.

**Gherkin-Referenz**:

- contact.feature: "Contact section contains an OpenStreetMap embed showing business location"

**Input**: Contact-Section aus AP-014

**Output**: OSM-iframe mit korrektem sandbox-Attribut.

**Seiteneffekte**: Externe Anfrage an OpenStreetMap Tile-Server beim Laden.

**Akzeptanzkriterien**:

- iframe mit OSM-URL vorhanden
- sandbox="allow-scripts allow-same-origin allow-popups"
- Karte zeigt Standort nahe Steinstrasse 14, Recklinghausen

**Abhaengigkeiten**: AP-014

**TDD-Plan**:

- Test: `tests/contact.spec.js` -- Pruefe iframe existiert, src enthaelt openstreetmap, sandbox-Attribut korrekt
- Typ: E2E (Playwright)
- Red: Kein iframe vorhanden
- Green: iframe-Element mit OSM-URL und sandbox-Attribut einfuegen

---

### AP-016: Contact Section Mobile (Tap-Target)

**Beschreibung**: Telefon-Link bei 375px Viewport mindestens 44x44px gross.

**Gherkin-Referenz**:

- contact.feature: "Phone link is tappable on mobile devices"

**Input**: Contact-Section aus AP-014

**Output**: Responsive CSS fuer Telefon-Link.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- Bei 375px: Telefon-Link boundingBox mindestens 44x44px

**Abhaengigkeiten**: AP-014

**TDD-Plan**:

- Test: `tests/contact.spec.js` -- Bei 375px: Pruefe boundingBox des Telefon-Links >= 44x44
- Typ: E2E (Playwright)
- Red: Link zu klein (Standard-Inline-Link)
- Green: CSS padding/min-height fuer Telefon-Link

---

### AP-017: Impressum-Seite

**Beschreibung**: Impressum-Seite mit vollstaendigem Inhalt: Name, Adresse, Telefon, E-Mail, Versicherungsinfo. Link zurueck zur Startseite. Meta-Tag noindex.

**Gherkin-Referenz**:

- legal.feature: "Impressum page contains the business owner's full name"
- legal.feature: "Impressum page contains the full business address"
- legal.feature: "Impressum page contains contact information"
- legal.feature: "Impressum page contains the insurance information"
- legal.feature: "Impressum page is navigable back to the index page"
- legal.feature: "Impressum page has noindex meta tag"

**Input**: Leere impressum.html aus AP-002

**Output**: Vollstaendige Impressum-Seite.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- Seite enthaelt: "Sabrin Salkic", "Steinstrasse 14", "45657 Recklinghausen"
- Seite enthaelt: Telefonnummer, E-Mail
- Seite enthaelt: "Berufshaftpflicht", "Wuerttembergische"
- Link zurueck zu index.html vorhanden
- Meta-Tag: `<meta name="robots" content="noindex">`

**Zusammenfassung**: 6 Szenarien gehoeren zusammen -- alle betreffen den Inhalt einer einzelnen Seite.

**Abhaengigkeiten**: AP-002

**TDD-Plan**:

- Test: `tests/legal.spec.js` -- Pruefe alle Texte auf Impressum-Seite vorhanden, Link zu index.html, meta robots noindex
- Typ: E2E (Playwright)
- Red: Impressum-Seite hat nur Grundgeruest
- Green: HTML-Inhalt der Impressum-Seite befuellen

---

### AP-018: Datenschutz-Seite

**Beschreibung**: Datenschutzerklaerung mit Ueberschrift, verantwortliche Person, GitHub Pages Hosting-Info, OpenStreetMap Datenuebermittlung. Link zurueck zur Startseite. Meta-Tag noindex.

**Gherkin-Referenz**:

- legal.feature: "Datenschutz page exists and has content"
- legal.feature: "Datenschutz page mentions the responsible party"
- legal.feature: "Datenschutz page covers GitHub Pages hosting"
- legal.feature: "Datenschutz page mentions OpenStreetMap data transmission"
- legal.feature: "Datenschutz page is navigable back to the index page"
- legal.feature: "Datenschutz page has noindex meta tag"

**Input**: Leere datenschutz.html aus AP-002

**Output**: Vollstaendige Datenschutz-Seite.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- Ueberschrift "Datenschutzerklaerung"
- "Sabrin Salkic" als verantwortliche Person
- "GitHub Pages" als Hosting-Provider erwaehnt, IP-Adressen-Hinweis
- "OpenStreetMap" erwaehnt, Tile-Server, IP-Uebermittlung
- Link zurueck zu index.html
- Meta-Tag: `<meta name="robots" content="noindex">`

**Zusammenfassung**: 6 Szenarien gehoeren zusammen -- alle betreffen den Inhalt einer einzelnen Seite.

**Abhaengigkeiten**: AP-002

**TDD-Plan**:

- Test: `tests/legal.spec.js` -- Pruefe Ueberschrift, verantwortliche Person, GitHub Pages + IP, OpenStreetMap + Tiles + IP, Link zu index.html, meta robots noindex
- Typ: E2E (Playwright)
- Red: Datenschutz-Seite hat nur Grundgeruest
- Green: HTML-Inhalt der Datenschutz-Seite befuellen

---

### AP-019: SEO Meta-Tags (Title, Description, Canonical)

**Beschreibung**: Index-Seite: Title-Tag, Meta-Description (120-160 Zeichen, erwaehnt Service/Gebiet), Canonical-URL auf GitHub Pages.

**Gherkin-Referenz**:

- seo.feature: "Index page has a descriptive title tag"
- seo.feature: "Index page has a meta description"
- seo.feature: "Index page has a canonical URL pointing to GitHub Pages"

**Input**: Index-Seite aus AP-002

**Output**: Meta-Tags im head der Index-Seite.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- Title: "Alltagsbiene im Vest -- Alltagshilfe fuer Menschen mit Pflegegrad"
- Meta-Description: 120-160 Zeichen, erwaehnt Service oder Gebiet
- Canonical: link rel="canonical" mit GitHub Pages URL

**Zusammenfassung**: 3 Szenarien betreffen grundlegende Meta-Tags im head.

**Abhaengigkeiten**: AP-002

**TDD-Plan**:

- Test: `tests/seo.spec.js` -- Pruefe document.title, meta description (Laenge + Inhalt), canonical link href
- Typ: E2E (Playwright)
- Red: Keine Meta-Tags vorhanden
- Green: Meta-Tags in head einfuegen

---

### AP-020: SEO Social Tags (Open Graph + Twitter Cards)

**Beschreibung**: Open Graph Tags (og:title, og:description, og:type, og:url, og:image, og:locale) und Twitter Card Tags (twitter:card, twitter:title, twitter:description). Einfaches SVG als Platzhalter-Bild fuer og:image anlegen (Text "Alltagsbiene im Vest" auf Gold-Hintergrund, 1200x630).

**Gherkin-Referenz**:

- seo.feature: "Index page has Open Graph meta tags"
- seo.feature: "Index page has Twitter Card meta tags"

**Input**: Index-Seite mit Meta-Tags aus AP-019

**Output**: OG- und Twitter-Meta-Tags, Platzhalter-Bild in assets/.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- og:title, og:description, og:type="website", og:url, og:image (1200x630 Platzhalter), og:locale="de_DE"
- twitter:card="summary_large_image", twitter:title, twitter:description

**Zusammenfassung**: OG und Twitter Cards gehoeren zusammen -- beides Social-Media-Metadaten.

**Abhaengigkeiten**: AP-019

**TDD-Plan**:

- Test: `tests/seo.spec.js` -- Pruefe alle OG-Tags und Twitter-Tags vorhanden mit korrekten Werten
- Typ: E2E (Playwright)
- Red: Keine OG/Twitter-Tags
- Green: Meta-Tags einfuegen, SVG-Platzhalter-Bild in assets/ erstellen

---

### AP-021: SEO Structured Data + Crawling (JSON-LD, robots.txt, sitemap.xml)

**Beschreibung**: JSON-LD LocalBusiness Structured Data mit Name, Adresse, Kontaktdaten. robots.txt mit Sitemap-Verweis. sitemap.xml mit Index-URL (ohne Impressum/Datenschutz).

**Gherkin-Referenz**:

- seo.feature: "Index page contains JSON-LD LocalBusiness structured data"
- seo.feature: "JSON-LD contains the correct address"
- seo.feature: "JSON-LD contains contact information"
- seo.feature: "robots.txt exists and allows crawling"
- seo.feature: "sitemap.xml exists and lists all public pages"

**Input**: Index-Seite aus AP-002

**Output**: JSON-LD Script-Tag in index.html, robots.txt, sitemap.xml.

**Seiteneffekte**: Keine

**Akzeptanzkriterien**:

- JSON-LD: @type="LocalBusiness", name="Alltagsbiene im Vest"
- JSON-LD Adresse: streetAddress, postalCode, addressLocality, addressCountry
- JSON-LD Kontakt: telephone, email, url
- robots.txt: HTTP 200, enthaelt Sitemap-Direktive
- sitemap.xml: HTTP 200, enthaelt Index-URL, enthaelt NICHT Impressum/Datenschutz

**Zusammenfassung**: JSON-LD und Crawling-Dateien gehoeren zusammen -- beides SEO-Infrastruktur, die sich ergaenzt.

**Abhaengigkeiten**: AP-002

**TDD-Plan**:

- Test: `tests/seo.spec.js` -- Pruefe JSON-LD Inhalt (parse script[type="application/ld+json"]), robots.txt (fetch + Inhalt), sitemap.xml (fetch + Inhalt)
- Typ: E2E (Playwright)
- Red: Keine JSON-LD, kein robots.txt, kein sitemap.xml
- Green: JSON-LD in index.html einfuegen, robots.txt und sitemap.xml erstellen

---

## Abhaengigkeits-Graph

```
AP-001 (Scaffolding)
  |
  v
AP-002 (HTML-Grundgeruest, Landmarks, CSS-Variablen)
  |
  +---> AP-003 (Sections-Reihenfolge)
  |       |
  |       +---> AP-004 (Desktop-Navigation)
  |       |       |
  |       |       +---> AP-005a (Hamburger CSS + Button)
  |       |       |       |
  |       |       |       +---> AP-005b (Auto-Close + Escape)
  |       |       |
  |       |       +---> AP-010 (About Section)
  |       |       |
  |       |       +---> AP-011 (Services Leistungsliste)
  |       |       |       |
  |       |       |       +---> AP-011b (Zielgruppen-Cards)
  |       |       |       |
  |       |       |       +---> AP-012 (Services Mobile)
  |       |       |
  |       |       +---> AP-014 (Contact Section)
  |       |               |
  |       |               +---> AP-015 (OSM-Karte)
  |       |               |
  |       |               +---> AP-016 (Contact Mobile)
  |       |
  |       +---> AP-008 (Hero Section)
  |       |       |
  |       |       +---> AP-009 (Hero Mobile)
  |       |
  |       +---> AP-013 (USP Section)
  |
  +---> AP-006 (Footer)
  |
  +---> AP-017 (Impressum)
  |
  +---> AP-018 (Datenschutz)
  |
  +---> AP-019 (SEO Meta-Tags)
  |       |
  |       +---> AP-020 (Social Tags + SVG-Platzhalter)
  |
  +---> AP-021 (JSON-LD + Crawling)

AP-007 (Gold-Farbe Accessibility) -- Regression-Guard, abhaengig von:
  AP-008, AP-010, AP-011, AP-013, AP-014 (alle Content-APs)
```

## Optimale Implementierungsreihenfolge

| Schritt | Arbeitspaket(e)                                | Parallelisierbar?                                                                |
| ------: | ---------------------------------------------- | -------------------------------------------------------------------------------- |
|       1 | AP-001                                         | Nein (Basis)                                                                     |
|       2 | AP-002                                         | Nein (Basis)                                                                     |
|       3 | AP-003, AP-006, AP-017, AP-018, AP-019, AP-021 | Ja (alle nur von AP-002 abhaengig)                                               |
|       4 | AP-004, AP-008, AP-013, AP-020                 | Ja (AP-004 braucht AP-003, AP-008/AP-013 brauchen AP-003, AP-020 braucht AP-019) |
|       5 | AP-005a, AP-009, AP-010, AP-011, AP-014        | Ja (jeweils von AP-004 bzw. AP-008 abhaengig)                                    |
|       6 | AP-005b, AP-011b, AP-012, AP-015, AP-016       | Ja (jeweils von Vorgaenger-APs abhaengig)                                        |
|       7 | AP-007                                         | Nein (Regression-Guard, nach allen Content-APs)                                  |

## Zusammenfassung

| Metrik                     | Wert |
| -------------------------- | ---: |
| Gherkin-Szenarien gesamt   |   58 |
| Arbeitspakete gesamt       |   23 |
| Test-Spec-Dateien          |    7 |
| Parallelisierbare Schritte |    5 |
| Implementierungsschritte   |    7 |

## Regeln fuer die Implementierung

1. **Tests zuerst**: Pro AP erst den Test schreiben, ausfuehren (muss fehlschlagen), dann implementieren.
2. **Tests nicht aendern**: Einmal geschriebene Tests duerfen waehrend der Implementierung nicht geaendert werden.
3. **Scope-Guard**: Keine neuen APs ohne Ruecksprache.
4. **Abbruchkriterium**: Wenn der Plan nicht passt, STOPP und Plan anpassen.

---

## Review-Ergebnis

### Szenario-Zaehlung

**MUSS-Finding:** Die Szenario-Inventar-Tabelle enthaelt falsche Zahlen.

| Feature File      | Plan sagt | Tatsaechlich |
| ----------------- | --------: | -----------: |
| structure.feature |        10 |           13 |
| hero.feature      |         4 |            4 |
| about.feature     |         3 |            3 |
| services.feature  |         5 |            5 |
| usps.feature      |         3 |            3 |
| contact.feature   |         7 |            7 |
| legal.feature     |        12 |           12 |
| seo.feature       |        11 |           11 |
| **Gesamt**        |    **48** |       **58** |

Die Differenz von 3 bei structure.feature entsteht, weil der Plan 10 zaehlt, es aber 13 Szenarien sind. Die Gesamtzahl 48 im Plan ist damit ebenfalls falsch (korrekt: 58). Allerdings: 4+3+5+3+7+12+11 = 45, plus 13 = 58. Selbst mit 10 waeren es 55, nicht 48. Die Summe stimmt also auch mit der eigenen Zaehlung nicht.

### Gherkin-Abdeckung

**structure.feature (13 Szenarien):**

- [x] "Index page contains all required sections in order" -> AP-003
- [x] "Index page has a navigation header" -> AP-004
- [x] "Index page has a footer with legal links" -> AP-006
- [x] "Desktop navigation shows all links inline" -> AP-004
- [x] "Mobile navigation uses a hamburger menu" -> AP-005
- [x] "Mobile hamburger menu can be opened and closed" -> AP-005
- [x] "Hamburger menu closes automatically after clicking a navigation link" -> AP-005
- [x] "Hamburger menu closes when pressing the Escape key" -> AP-005
- [x] "All three HTML pages exist and are reachable" -> AP-002
- [x] "All pages use semantic HTML landmarks" -> AP-002
- [x] "All pages have a single h1 heading" -> AP-002
- [x] "Gold color is not used as text color on white background" -> AP-007
- [x] "Pages use the bee-themed color scheme with CSS variables" -> AP-002

**hero.feature (4 Szenarien):**

- [x] "Hero section is visible above the fold" -> AP-008
- [x] "Hero section contains a call-to-action button" -> AP-008
- [x] "Hero section displays a placeholder image area" -> AP-008
- [x] "Hero section is fully visible on mobile devices" -> AP-009

**about.feature (3 Szenarien):**

- [x] "About section identifies the business owner" -> AP-010
- [x] "About section describes the service offering" -> AP-010
- [x] "About section is reachable via navigation" -> AP-010

**services.feature (5 Szenarien):**

- [x] "Services section lists all offered services" -> AP-011
- [x] "Services section has separate visual areas for target groups" -> AP-011
- [x] "Services section mentions the geographic coverage" -> AP-011
- [x] "Services section is reachable via navigation" -> AP-011
- [x] "Services section is readable on mobile devices" -> AP-012

**usps.feature (3 Szenarien):**

- [x] "USP section displays all unique selling points" -> AP-013
- [x] "USP section mentions the insurance provider" -> AP-013
- [x] "USPs are displayed as individual cards with icons" -> AP-013

**contact.feature (7 Szenarien):**

- [x] "Contact section displays the phone number" -> AP-014
- [x] "Contact section displays the email address" -> AP-014
- [x] "Contact section displays the business address" -> AP-014
- [x] "Contact section links to Instagram" -> AP-014
- [x] "Contact section contains an OpenStreetMap embed showing business location" -> AP-015
- [x] "Contact section is reachable via navigation" -> AP-014
- [x] "Phone link is tappable on mobile devices" -> AP-016

**legal.feature (12 Szenarien):**

- [x] "Impressum page contains the business owner's full name" -> AP-017
- [x] "Impressum page contains the full business address" -> AP-017
- [x] "Impressum page contains contact information" -> AP-017
- [x] "Impressum page contains the insurance information" -> AP-017
- [x] "Impressum page is navigable back to the index page" -> AP-017
- [x] "Impressum page has noindex meta tag" -> AP-017
- [x] "Datenschutz page exists and has content" -> AP-018
- [x] "Datenschutz page mentions the responsible party" -> AP-018
- [x] "Datenschutz page covers GitHub Pages hosting" -> AP-018
- [x] "Datenschutz page mentions OpenStreetMap data transmission" -> AP-018
- [x] "Datenschutz page is navigable back to the index page" -> AP-018
- [x] "Datenschutz page has noindex meta tag" -> AP-018

**seo.feature (11 Szenarien):**

- [x] "Index page has a descriptive title tag" -> AP-019
- [x] "Index page has a meta description" -> AP-019
- [x] "Index page has a canonical URL pointing to GitHub Pages" -> AP-019
- [x] "Index page has Open Graph meta tags" -> AP-020
- [x] "Index page has Twitter Card meta tags" -> AP-020
- [x] "Index page contains JSON-LD LocalBusiness structured data" -> AP-021
- [x] "JSON-LD contains the correct address" -> AP-021
- [x] "JSON-LD contains contact information" -> AP-021
- [x] "robots.txt exists and allows crawling" -> AP-021
- [x] "sitemap.xml exists and lists all public pages" -> AP-021
- [x] "All pages declare the document language as German" -> AP-002

**Ergebnis:** Alle 58 Gherkin-Szenarien sind durch Arbeitspakete abgedeckt. Kein Scope-Creep (kein AP ohne Szenario-Zuordnung, ausser AP-001 Scaffolding, was korrekt ist). Keine Luecken.

### Findings pro Arbeitspaket

**AP-001: Projekt-Scaffolding**

- Severity: OK
- Kein TDD noetig fuer Scaffolding, Verifikation ueber npm install ist angemessen.

**AP-002: HTML-Grundgeruest und Seitenstruktur**

- Severity: SOLLTE
- Finding: Buendelt 5 Szenarien aus structure.feature plus 1 aus seo.feature (lang="de"). Das sind 6 Szenarien, was grenzwertig ist, aber inhaltlich zusammengehoert (alles HTML-Grundgeruest). Passt noch.
- Finding: "Semantic HTML landmarks" Szenario prueft nur die Index-Seite im Gherkin, aber das AP sagt "Jede Seite hat header, nav, main, footer Landmarks". Das ist korrekter als das Gherkin (das Gherkin prueft nur Index), aber der Vollstaendigkeit halber sollten die Tests auch Impressum und Datenschutz abdecken -- was im Gherkin "All pages use semantic HTML landmarks" heisst und implizit alle Seiten meint, obwohl die Steps nur die Index-Seite navigieren.
- Empfehlung: Pruefe im Test tatsaechlich alle 3 Seiten auf Landmarks, nicht nur die Index-Seite. Das Gherkin-Szenario heisst "All pages" und testet aktuell nur Index -- entweder Gherkin oder Test anpassen.

**AP-003: Sektions-Reihenfolge**

- Severity: OK
- Atomare Verantwortlichkeit, klarer Test.

**AP-004: Desktop-Navigation**

- Severity: OK
- Buendelt 2 zusammengehoerige Szenarien. Passt.

**AP-005: Hamburger-Menu**

- Severity: SOLLTE
- Finding: 4 Szenarien in einem AP. Das sind ~50 Zeilen JS + CSS Media Query. Koennte knapp ueber 50 Zeilen Produktivcode kommen.
- Empfehlung: Ist akzeptabel, weil alles eine Komponente ist (Toggle-Button). Wenn die Implementierung ueber 50 Zeilen waechst, aufteilen.

**AP-006: Footer mit Legal-Links**

- Severity: OK
- Klein, atomar, klar.

**AP-007: Gold-Farbe Accessibility**

- Severity: SOLLTE
- Finding: Der Test "iteriere ueber alle sichtbaren Textelemente" ist technisch aufwaendig und fragil (computed styles in Playwright). Der Red-Zustand ist "sollte initial gruen sein" -- das widerspricht TDD (Test MUSS zuerst rot sein).
- Empfehlung: Dieses AP besser als Regression-Guard nach AP-008 bis AP-013 ausfuehren (wenn tatsaechlich Inhalt vorhanden ist, der potentiell Gold als Textfarbe nutzen koennte). Alternativ: Den Test so formulieren, dass er spezifisch CSS-Regeln prueft statt computed styles.

**AP-008: Hero Section**

- Severity: OK
- 3 Desktop-Szenarien einer Section, passt zusammen.

**AP-009: Hero Mobile**

- Severity: OK
- Atomar, eine Verantwortlichkeit.

**AP-010: About Section**

- Severity: OK
- 3 Szenarien, alle gleiche Section. Nav-Scroll-Test haengt von AP-004 ab, Abhaengigkeit korrekt deklariert.

**AP-011: Services Section**

- Severity: SOLLTE
- Finding: 4 Szenarien mit Dienstleistungsliste, Zielgruppen-Bereichen mit Icons, Gebietsangabe und Nav-Scroll. Das koennte >50 Zeilen HTML+CSS werden (6 Services + 2 Zielgruppen-Cards mit Icons).
- Empfehlung: Beobachten. Wenn die Implementierung waechst, Zielgruppen-Cards als eigenes AP auslagern.

**AP-012: Services Mobile**

- Severity: OK

**AP-013: USP Section**

- Severity: OK
- 3 Szenarien, eine Section, passt.

**AP-014: Contact Section**

- Severity: OK
- 5 Szenarien, aber alles statischer HTML-Inhalt (Links + Adresse). Unter 50 Zeilen.

**AP-015: OSM-Karte**

- Severity: OK
- Atomar, ein iframe.

**AP-016: Contact Mobile**

- Severity: OK

**AP-017: Impressum-Seite**

- Severity: OK
- 6 Szenarien, aber alles statischer Text auf einer Seite. Passt.

**AP-018: Datenschutz-Seite**

- Severity: OK
- Gleiche Struktur wie AP-017.

**AP-019: SEO Meta-Tags**

- Severity: OK
- 3 Szenarien im head. Passt.

**AP-020: Social Tags**

- Severity: SOLLTE
- Finding: "Platzhalter-Bild fuer og:image anlegen" -- ein 1200x630 Platzhalter-Bild erstellen ist nicht trivial mit Vanilla-Mitteln. Wie soll das Bild erstellt werden? Einfache Loesung: Ein SVG oder ein einfarbiges PNG generieren.
- Empfehlung: Klaeren, wie das Platzhalter-Bild erstellt wird (manuell, per Script, SVG?).

**AP-021: JSON-LD + Crawling**

- Severity: SOLLTE
- Finding: Buendelt 5 Szenarien aus 3 verschiedenen Bereichen (JSON-LD, robots.txt, sitemap.xml). Das sind 3 verschiedene Dateien/Technologien. Koennte aufgeteilt werden in (a) JSON-LD und (b) robots.txt + sitemap.xml.
- Empfehlung: Akzeptabel, da jedes Teilstueck wenig Code ist (~10-15 Zeilen je). Aber bei Problemen aufteilen.

### Abhaengigkeits-Graph

- Keine zirkulaeren Abhaengigkeiten -- OK.
- Optimale Reihenfolge ist korrekt abgeleitet.
- Parallelisierbare Pakete korrekt identifiziert.
- **SOLLTE-Finding:** AP-007 (Gold-Farbe) haengt im Graph nur von AP-002 ab, aber der Test macht nur Sinn wenn es tatsaechlich gestylte Inhalte gibt. Besser nach den Content-APs (AP-008 bis AP-014) ausfuehren.

### Offene Fragen

1. **Szenario-Zaehlung korrigieren:** Die Tabelle im Szenario-Inventar zeigt 10 fuer structure.feature, korrekt sind 13. Gesamtsumme ist 58, nicht 48. Bitte korrigieren.
2. **og:image Platzhalter:** Wie soll das 1200x630 Platzhalter-Bild erstellt werden? SVG? Einfarbiges PNG per Script?
3. **Landmarks-Test fuer alle Seiten:** Das Gherkin sagt "All pages use semantic HTML landmarks" -- soll der Test alle 3 Seiten pruefen oder nur Index?
4. **AP-007 Timing:** Soll die Gold-Farbe-Pruefung wirklich parallel zu AP-003 laufen (Schritt 3), oder besser spaeter wenn Inhalte vorhanden sind?
5. **System-Font-Stack:** Wird im Plan nirgends explizit implementiert. Ist das Teil von AP-002 (CSS-Grundgeruest) oder braucht es ein eigenes AP? Es gibt kein Gherkin-Szenario dafuer, also kein AP noetig -- aber es sollte bei AP-002 im CSS mit erledigt werden (als Implementierungsdetail).

### Scope-Checklist

- [x] Plan deckt gesamte Feature-Beschreibung ab (alle Sections, alle Seiten, Responsive, SEO, Legal)
- [x] Kein Scope-Creep (jedes AP hat Gherkin-Referenz, ausser AP-001 Scaffolding)
- [x] Prioritaeten klar (Abhaengigkeits-Graph + Reihenfolgetabelle)
- [ ] Szenario-Inventar-Zahlen stimmen nicht (MUSS korrigiert werden)

### Gesamtbewertung

- [ ] Plan ist bereit zur Implementierung
- [x] Plan benötigt Anpassungen

**Begruendung:** Der Plan ist inhaltlich vollstaendig und gut strukturiert. Die Gherkin-Abdeckung ist lueckenlos. Es gibt zwei MUSS-Findings:

1. **Szenario-Zaehlung korrigieren** (structure.feature: 13 statt 10, Gesamt: 58 statt 48)

Und mehrere SOLLTE-Findings, die vor der Implementierung geklaert werden sollten:

2. AP-007 Timing (Gold-Farbe-Test macht erst Sinn mit Inhalt)
3. og:image Platzhalter-Erstellung klaeren
4. AP-021 Buendelung beobachten

Nach Korrektur der Zahlen und Klaerung der offenen Fragen ist der Plan bereit zur Implementierung.

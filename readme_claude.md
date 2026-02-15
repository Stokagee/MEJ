# MEJ Robot Framework Testovaci Projekt

Kompletni dokumentace pro automatizovane end-to-end testy webove aplikace MEJ (system pro spravu jizd a prepravy).

## Obsah

- [Uvod](#uvod)
- [Technologie a predpoklady](#technologie-a-predpoklady)
- [Rychly start](#rychly-start)
- [Struktura projektu](#struktura-projektu)
- [Architektura](#architektura)
- [Spousteni testu](#spousteni-testu)
- [TeamCity integrace](#teamcity-integrace)
- [Tvorba testu](#tvorba-testu)
- [Reseni problemu](#reseni-problemu)
- [Reference](#reference)

---

## Uvod

### Co je to za projekt

Tento projekt obsahuje automatizovane end-to-end testy pro webovou aplikaci MEJ, ktera je systemem pro spravu jizd a prepravy. Testy jsou napsane v Robot Framework s vyuzitim Playwright pro browser automatizaci.

### Ucel testu

- Overeni spravne funkcnosti aplikace po zmeneach
- Detekce regresnich chyb
- Validace formularu a uzivatelskych vstupu
- Testovani kompletnich workflow napric ruznymi uzivatelskymi rolemi
- Overeni API a databazovych operaci

### Statistiky projektu

| Metrika | Hodnota |
|---------|---------|
| Testovaci soubory | 17 |
| Resource soubory | 41 |
| Testovaci scenare | priblizne 70 az 80 |
| Uzivatelske role | 3 (Operator, Driver, Company) |
| Podporovane browser | Chromium |

---

## Technologie a predpoklady

### Pouzite technologie

| Technologie | Verze | Ucel |
|-------------|-------|------|
| Robot Framework | 7.0 a vyssi | Jadro testovaciho frameworku |
| Python | 3.11 a vyssi | Runtime prostredi |
| robotframework-browser | 18.0 a vyssi | Browser automatizace (Playwright) |
| Playwright | - | Browser automation engine |
| Node.js | 20.x | Potrebne pro Playwright |
| Docker | - | Kontejnerizace testu |
| Docker Compose | - | Sprava Docker kontejneru |
| Microsoft SQL Server | - | Databaze (pres ODBC Driver 17) |

### Python knihovny

| Knihovna | Ucel |
|----------|------|
| robotframework-faker | Generovani nahodnych testovacich dat |
| robotframework-databaselibrary | Databazove operace |
| robotframework-requests | HTTP API testovani |
| geopy | Vypocet geografickych vzdalenosti |

### Systemove pozadavky

Pro lokalni spousteni testu potrebujes:

- **Python 3.11 nebo vyssi** - [python.org](https://www.python.org/downloads/)
- **Node.js 20.x** - [nodejs.org](https://nodejs.org/)
- **Git** - pro klonovani repozitare
- **Docker a Docker Compose** - pro kontejnerizovane spousteni (volitelne)
- **ODBC Driver 17 for SQL Server** - pro databazove testy

### Pristup k repozitari

Potrebujes pristup k Git repozitari s projektem. Kontaktuj administratora projektu pro ziskani pristupu.

---

## Rychly start

Tato sekce te provede zakladnimi kroky pro prvni spusteni testu.

### Krok 1: Klonovani repozitare

```bash
git clone <repo-url>
cd MEJ
```

### Krok 2: Vytvoreni virtualniho prostredi

**Windows:**
```bash
python -m venv venv
venv\Scripts\activate
```

**Linux a macOS:**
```bash
python -m venv venv
source venv/bin/activate
```

### Krok 3: Instalace zavislosti

```bash
pip install -r requirements.txt
```

### Krok 4: Instalace browseru

Tento krok stahne a nainstaluje Chromium browser pro testovani:

```bash
rfbrowser init
```

Pozor: Tento krok muze trvat nekolik minut, protoze se stahuji browser binarky.

### Krok 5: Konfigurace prostredi

Zkopiruj vzorovy soubor s promennymi prostredi:

```bash
cp .env.example .env
```

Otevri soubor `.env` a vypln sve prihlasovaci udaje:

```bash
# --- Credentials - Admin ---
MEJ_ADMIN_EMAIL=tvuj-admin@email.com
MEJ_ADMIN_PASSWORD=tvoje-heslo

# --- Credentials - Driver ---
MEJ_DRIVER_EMAIL=tvuj-driver@email.com
MEJ_DRIVER_PASSWORD=tvoje-heslo

# --- Credentials - Company ---
MEJ_COMPANY_EMAIL=tvuj-company@email.com
MEJ_COMPANY_PASSWORD=tvoje-heslo
```

Dulezite: Nikdy neukladej soubor `.env` do Gitu. Je jiz pridan do `.gitignore`.

### Krok 6: Spusteni testu

```bash
robot --outputdir results tests/
```

Po dokonceni testu najdes vysledky ve slozce `results/`:
- `report.html` - prehledna html zprava s vysledky
- `log.html` - detailni log behu testu
- `output.xml` - vysledky ve formatu XML

---

## Struktura projektu

```
MEJ/
|
+-- KONFIGURACE
|   |-- pyproject.toml              # Konfigurace Robot Framework Browser
|   |-- requirements.txt            # Python zavislosti
|   |-- Dockerfile                  # Definice Docker obrazu
|   |-- docker-compose.yml          # Konfigurace Docker Compose
|   |-- .env.example                # Vzor souboru s promennymi prostredi
|   |-- .gitignore                  # Ignorovane soubory pro Git
|   |-- README.md                   # Zakladni dokumentace
|
+-- ZAKLADNI RESOURCES (korenovy adresar)
|   |-- common.resource              # Sdilena klicova slova a importy
|   |-- global_variables.resource    # Globalni promenne
|   |-- login_locators.resource      # Lokatory pro prihlasovaci stranku
|   |-- login_page.resource          # Page object pro prihlasovaci stranku
|
+-- resources/
|   |-- api/                         # API klicova slova
|   |-- db/                          # Databazova klicova slova
|   |-- libraries/                   # Vlastni Python knihovny
|   |-- Python_skripts.py            # Pomocne Python funkce
|   |
|   |-- operators/                   # ROLE: Admin a Operator
|   |   |-- locators/                # Lokatory pro admin stranky
|   |   |-- page/                    # Page objects pro admin stranky
|   |   |-- workflows/               # Komplexni workflow
|   |
|   |-- drivers/                     # ROLE: Ridic
|   |   |-- locators/                # Lokatory pro driver stranky
|   |   |-- page/                    # Page objects pro driver stranky
|   |
|   |-- company/                     # ROLE: Spolecnost
|   |   |-- locators/                # Lokatory pro company stranky
|   |   |-- page/                    # Page objects pro company stranky
|   |
|   |-- Register/                    # Registrace novych entit
|
+-- tests/
    |-- Negative/                    # Negativni testy (validace chyb)
    |-- Operator/                    # Operator a admin testy
    |-- Registers/                   # Registracni testy
    |-- Valid_content/               # Pozitivni validacni testy
    |-- tour_route.robot             # E2E test pro tour routes
    |-- package.robot                # E2E test pro balikovani jizd
    |-- exam.robot                   # API testy
    |-- te.robot                     # Testy s databazi
```

### Vyznam hlavnich adresaru

| Adresar | Vyznam |
|---------|--------|
| `resources/` | Vsechny zdroje pro testy (lokatory, page objects, workflows) |
| `tests/` | Testovaci soubory v formatu .robot |
| `results/` | Vystupni slozka s vysledky testu (vytvori se automaticky) |

---

## Architektura

### Page Object Model

Projekt vyuziva vzor **Page Object Model (POM)**, ktery oddeluje definice prvku na strance od testovaci logiky.

**Tvrzene vrstvy:**

1. **Locators** - CSS selektory a XPath vyrazy pro nalezeni prvku na strance
2. **Page** - Klicova slova pro interakci s jednotlivymi strankami
3. **Workflows** - Komplexni workflow spojujici vice kroku dohromady

**Vyhody tohoto pristupu:**

- Meni se pouze lokatory, kdyz se zmeni design aplikace
- Testy jsou citelnejsi a lepe udrzovatelne
- Opakovane pouzitelne klicova slova

### Uzivatelske role

Projekt testuje aplikaci z pohledu tri uzivatelskych roli:

| Role | Popis | Slozka v resources/ |
|------|-------|---------------------|
| **Operator/Admin** | Administrativa systemu, sprava jizd, fakturace, balikovani | `operators/` |
| **Driver** | Ridic, ktery potvrzuje jizdy, zobrazuje prirazene trasy | `drivers/` |
| **Company** | Prepravni spolecnost, nabizi vozidla a sluzby | `company/` |

### Sdilene zdroje

**common.resource** - centralni soubor, ktery:
- Importuje vsechny potrebne knihovny (Browser, FakerLibrary, atd.)
- Definuje univerzalni klicova slova (Click Element, Fill Field, atd.)
- Je importovan ve vsech testovacich souborech

**global_variables.resource** - definuje:
- URL aplikace
- Prihlasovaci udaje pro jednotlive role
- Konfiguraci browseru (headless, rozmery okna)
- Databazove pripojeni

---

## Spousteni testu

### Lokalni spousteni

#### Spustit vsechny testy

```bash
robot --outputdir results tests/
```

#### Spustit konkretni soubor

```bash
robot --outputdir results tests/tour_route.robot
robot --outputdir results tests/Operator/test_1.robot
```

#### Spustit testy podle adresare

```bash
robot --outputdir results tests/Negative/
robot --outputdir results tests/Registers/
```

#### Spustit testy s konkretnim tagem

```bash
robot --outputdir results --include smoke tests/
robot --outputdir results --include e2e tests/
robot --outputdir results --include positive tests/
```

#### Vyloucit testy s konkretnim tagem

```bash
robot --outputdir results --exclude wip tests/
```

#### Kombinace tagu

```bash
robot --outputdir results --include e2e --exclude wip tests/
robot --outputdir results --include smoke --include p1 tests/
```

### Docker spousteni

#### Sestavit Docker image

```bash
docker-compose build
```

#### Spustit vsechny testy

```bash
docker-compose run --rm rf-tests
```

#### Spustit konkretni testy

```bash
docker-compose run --rm rf-tests robot --include smoke tests/
docker-compose run --rm rf-tests robot tests/tour_route.robot
```

#### Spustit s vlastnimi promennymi

```bash
docker-compose run --rm -e MEJ_HEADLESS=False rf-tests
```

### Testovaci tagy

Tagy slouzi ke kategorizaci a filtrovani testu:

| Tag | Vyznam | Priklad pouziti |
|-----|--------|-----------------|
| `smoke` | Kriticke testy pro rychlou kontrolu systemu | `--include smoke` |
| `e2e` | End-to-end testy pokravajici cely workflow | `--include e2e` |
| `positive` | Pozitivni testovaci scenare (ocekavany uspech) | `--include positive` |
| `negative` | Negativni scenare (testovani chybovych stavu) | `--include negative` |
| `p1` | Priorita 1 (vysoka, kriticke testy) | `--include p1` |
| `p2` | Priorita 2 (stredni) | `--include p2` |
| `wip` | Work in progress (nedokoncene testy) | `--exclude wip` |

---

## TeamCity integrace

### Princip fungovani

Testy jsou navrzeny pro spousteni v CI/CD prostredi TeamCity. Princip integrace:

1. **Docker kontejner** - TeamCity spousti testy v Docker kontejneru
2. **Environment promenne** - Vsechny konfiguracni hodnoty jsou predavany jako promenne prostredi
3. **Headless mode** - Browser bezi bez grafickeho rozhrani (vychozi nastaveni)
4. **Vystupy** - Vysledky testu jsou mountovany do slozky `./results`
5. **Vylouceni WIP** - Testy s tagem `wip` jsou automaticky vyloucene

### Nastaveni TeamCity projektu

#### Krok 1: Vytvoreni Build Configuration

1. V TeamCity vytvor novy projekt nebo pouzij existujici
2. Pridat novou Build Configuration s nazvem napriklad `MEJ_E2E_Tests`
3. Nastavit VCS root na repozitar s testy

#### Krok 2: Konfigurace Build Steps

**Typ:** Command Line nebo Docker Compose

**Working directory:** korenovy adresar projektu MEJ

**Script:**
```bash
docker-compose run --rm rf-tests
```

Alternativne s explicitnimi promennymi:
```bash
docker-compose run --rm \
  -e MEJ_URL=%env.MEJ_URL% \
  -e MEJ_API_URL=%env.MEJ_API_URL% \
  -e MEJ_HEADLESS=%env.MEJ_HEADLESS% \
  -e MEJ_ADMIN_EMAIL=%env.MEJ_ADMIN_EMAIL% \
  -e MEJ_ADMIN_PASSWORD=%env.MEJ_ADMIN_PASSWORD% \
  -e MEJ_DRIVER_EMAIL=%env.MEJ_DRIVER_EMAIL% \
  -e MEJ_DRIVER_PASSWORD=%env.MEJ_DRIVER_PASSWORD% \
  -e MEJ_COMPANY_EMAIL=%env.MEJ_COMPANY_EMAIL% \
  -e MEJ_COMPANY_PASSWORD=%env.MEJ_COMPANY_PASSWORD% \
  -e MEJ_API_KEY=%env.MEJ_API_KEY% \
  -e MEJ_DB_HOST=%env.MEJ_DB_HOST% \
  -e MEJ_DB_PORT=%env.MEJ_DB_PORT% \
  -e MEJ_DB_NAME=%env.MEJ_DB_NAME% \
  -e MEJ_DB_USER=%env.MEJ_DB_USER% \
  -e MEJ_DB_PASSWORD=%env.MEJ_DB_PASSWORD% \
  rf-tests
```

#### Krok 3: Konfigurace parametru

V TeamCity pridat nasledujici parametry (Settings > Parameters):

| Parameter | Typ | Povinny | Vychozi hodnota |
|-----------|-----|---------|-----------------|
| `env.MEJ_URL` | Text | Ano | `https://shared-testing-2.continero.com/` |
| `env.MEJ_API_URL` | Text | Ne | `https://shared-testing-2.continero.com` |
| `env.MEJ_HEADLESS` | Text | Ne | `True` |
| `env.MEJ_ADMIN_EMAIL` | Text | Ano | - |
| `env.MEJ_ADMIN_PASSWORD` | Password | Ano | - |
| `env.MEJ_DRIVER_EMAIL` | Text | Ano | - |
| `env.MEJ_DRIVER_PASSWORD` | Password | Ano | - |
| `env.MEJ_COMPANY_EMAIL` | Text | Ano | - |
| `env.MEJ_COMPANY_PASSWORD` | Password | Ano | - |
| `env.MEJ_API_KEY` | Password | Ne | - |
| `env.MEJ_DB_HOST` | Text | Ano | - |
| `env.MEJ_DB_PORT` | Text | Ano | - |
| `env.MEJ_DB_NAME` | Text | Ano | - |
| `env.MEJ_DB_USER` | Text | Ano | - |
| `env.MEJ_DB_PASSWORD` | Password | Ano | - |

#### Krok 4: Konfigurace Artifact Paths

V sekci General Settings nastav Artifact Paths:

```
results/** => results
```

Toto zajisti, ze vysledky testu (report.html, log.html) budou dostupne po dokonceni buildu.

#### Krok 5: Konfigurace Triggeru

Doporucene triggery:

**VCS Trigger:**
- Spousti testy po kazdem commitu
- Quiet period: 60 sekund (cekani na hromadeni commitu)

**Schedule Trigger:**
- Spousti testy kazde rano (napriklad v 02:00)
- Umoznuje detekovat problemy z predchoziho dne

**Dependency Trigger:**
- Spousti testy po uspesnem deployi aplikace

#### Krok 6: Failure Conditions

V sekci Failure Conditions povolit:
- **Test failures** - ozna build jako failed pokud nektery test selze
- **Build log contains** - pridej text `FAIL` jako indikator selhani

### Kompletni priklad konfigurace

```yaml
# Build Configuration: MEJ_E2E_Tests

# General Settings
Build directory: MEJ/
Clean build: Enabled
Artifact paths: results/** => results

# VCS Settings
VCS root: MEJ repository
Branch filter: +:* (vsechny vetve)

# Build Steps
Step 1: Command Line
  Working directory: ./
  Script: docker-compose run --rm rf-tests

# Parameters
env.MEJ_URL = https://shared-testing-2.continero.com/
env.MEJ_API_URL = https://shared-testing-2.continero.com
env.MEJ_HEADLESS = True
env.MEJ_ADMIN_EMAIL = (vyplnit)
env.MEJ_ADMIN_PASSWORD = (vyplnit - password type)
env.MEJ_DRIVER_EMAIL = (vyplnit)
env.MEJ_DRIVER_PASSWORD = (vyplnit - password type)
env.MEJ_COMPANY_EMAIL = (vyplnit)
env.MEJ_COMPANY_PASSWORD = (vyplnit - password type)
env.MEJ_API_KEY = (vyplnit - password type)
env.MEJ_DB_HOST = (vyplnit)
env.MEJ_DB_PORT = (vyplnit)
env.MEJ_DB_NAME = (vyplnit)
env.MEJ_DB_USER = (vyplnit)
env.MEJ_DB_PASSWORD = (vyplnit - password type)

# Triggers
VCS Trigger: Quiet period 60s

# Failure Conditions
Test failures: Enable
Build log contains: FAIL
```

### Dynamicka konfigurace podle vetve

Pro ruzne vetve muzes nastavit ruzne URL a databaze:

```
# Feature branch
env.MEJ_URL = https://mej-feature-%teamcity.build.branch%.continero.com/
env.MEJ_DB_NAME = MEJ-feature-%teamcity.build.branch%

# Develop branch
env.MEJ_URL = https://mej-dev.continero.com/
env.MEJ_DB_NAME = MEJ-dev

# Main branch
env.MEJ_URL = https://mej-staging.continero.com/
env.MEJ_DB_NAME = MEJ-staging
```

---

## Tvorba testu

### Zakladni struktura testovaciho souboru

```robotframework
*** Settings ***
Documentation     Testy pro konkretni funkcionalitu
Resource          ../common.resource

*** Variables ***
${pick_up_time}        10:00
${destination}         Praha

*** Test Cases ***
Nazev testovaciho scenare
    [Documentation]    Popis co test overuje
    [Tags]             e2e    positive    p1
    Given Sem prihlasen jako admin
    When Prejdu na stranku jizd
    Then Vidim seznam jizd
```

### Best practices

1. **Vzdy pouzivej common.resource** - zajisti, ze budes mit pristup ke vsem knihovnam a klicovym slovum

2. **Pouzivej popisne nazvy testu** - nazev testu by mel rikat, co se testuje, ne jak

3. **Pridej dokumentaci a tagy** - kazdy test by mel mit `[Documentation]` a `[Tags]`

4. **Vyuzivej POM** - oddeluj lokatory, page objects a workflows do prislusnych souboru

5. **Neopakuj kod** - opakujici se sekvence premistuj do workflow souboru

---

## Reseni problemu

### Caste chyby a jejich reseni

| Chyba | Pricina | Reseni |
|-------|---------|--------|
| `Browser not found` | Neni nainstalovany Playwright browser | Spustit `rfbrowser init` |
| `Timeout on element` | Prvek se nenacetl v casovem limitu | Zvysit `${TIMEOUT}` v `global_variables.resource` |
| `Invalid credentials` | Spatne prihlasovaci udaje | Zkontrolovat soubor `.env` |
| `Docker permission denied` | Uzivatel nema prava pro Docker | Pridat uzivatele do docker group |
| `Element not found` | Zmenil se selektor na strance | Aktualizovat lokatory |
| `Database connection failed` | Spatne DB udaje nebo spojeni | Zkontrolovat DB parametry v `.env` |

### Debug mod

Pro detailnejsi vypisy behem testovani:

```bash
robot --loglevel DEBUG --outputdir results tests/
```

Pro interaktivni debug muzes odkomentovat v `requirements.txt`:
```
robotframework-debug
```

A v `common.resource` odkomentovat:
```
DebugLibrary
```

### Logy a screenshoty

Po kazdem behu testu najdes ve slozce `results/`:

- **report.html** - prehledna HTML zprava s vysledky testu
- **log.html** - detailni log behu testu vcetne screenshotu
- **output.xml** - vysledky ve formatu XML (pro dalsi zpracovani)

Pri selhani testu se automaticky uklada screenshot a HTML stav stranky.

---

## Reference

### Seznam environment promennych

| Promenna | Vyznam | Vychozi hodnota |
|----------|--------|-----------------|
| `MEJ_URL` | URL testovane aplikace | `https://shared-testing-2.continero.com/` |
| `MEJ_API_URL` | API base URL | `https://shared-testing-2.continero.com` |
| `MEJ_HEADLESS` | Headless mode browseru | `True` |
| `MEJ_ADMIN_EMAIL` | Email admin uzivatele | - |
| `MEJ_ADMIN_PASSWORD` | Heslo admin uzivatele | - |
| `MEJ_DRIVER_EMAIL` | Email driver uzivatele | - |
| `MEJ_DRIVER_PASSWORD` | Heslo driver uzivatele | - |
| `MEJ_COMPANY_EMAIL` | Email company uzivatele | - |
| `MEJ_COMPANY_PASSWORD` | Heslo company uzivatele | - |
| `MEJ_API_KEY` | API klic pro MEJ API | - |
| `MEJ_DB_HOST` | Adresa databazoveho serveru | - |
| `MEJ_DB_PORT` | Port databaze | - |
| `MEJ_DB_NAME` | Nazev databaze | - |
| `MEJ_DB_USER` | Uzivatel databaze | - |
| `MEJ_DB_PASSWORD` | Heslo do databaze | - |

### Robot Framework globalni promenne

| Promenna | Vyznam | Vychozi hodnota |
|----------|--------|-----------------|
| `${URL}` | URL aplikace (z `MEJ_URL`) | `${EMPTY}` |
| `${TIMEOUT}` | Timeout pro cekani na prvky | `60` sekund |
| `${BROWSER}` | Typ browseru | `chromium` |
| `${HEADLESS}` | Headless mode | `${True}` |
| `${WIDTH}` | Sirka okna browseru | `1800` |
| `${HEIGHT}` | Vyska okna browseru | `900` |

### Uzitecne prikazy

| Prikaz | Popis |
|--------|-------|
| `pip install -r requirements.txt` | Instalace vsech zavislosti |
| `rfbrowser init` | Instalace Playwright browseru |
| `robot --outputdir results tests/` | Spustit vsechny testy |
| `robot --include smoke tests/` | Spustit pouze smoke testy |
| `robot --exclude wip tests/` | Vyloucit WIP testy |
| `robot --dryrun tests/` | Kontrola syntaxe bez spusteni |
| `robot --loglevel DEBUG tests/` | Spustit s debug vypisy |
| `docker-compose build` | Sestavit Docker image |
| `docker-compose run --rm rf-tests` | Spustit testy v Dockeru |

### Odkazy na dokumentaci

- [Robot Framework User Guide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)
- [Robot Framework Browser](https://marketsquare.github.io/robotframework-browser/Browser.html)
- [Playwright Documentation](https://playwright.dev/python/docs/intro)

---

## Kontakt a podpora

Pro dotazy ohledne tohoto projektu kontaktuj administratora repozitare.

Dokumentace byla vytvorena pro nove cleny tymu, aby mohli rychle zacinat pracovat s testovacim frameworkem.

- Vygenerováno AI a já jsem to cheknul.

- Dušan.

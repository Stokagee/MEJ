# MEJ Robot Framework Tests

Automatizované end-to-end testy pro MEJ aplikaci.

## Rychlý start

### Docker (doporučeno)

```bash
# Build image
docker build -t mej-rf-tests .

# Dry-run (ověření syntaxe)
docker run --rm mej-rf-tests robot --dryrun tests/

# Spuštění testů s proměnnými
docker run --rm \
  -e MEJ_ADMIN_EMAIL=váš@email.com \
  -e MEJ_ADMIN_PASSWORD=vaše_heslo \
  -v $(pwd)/results:/app/results \
  mej-rf-tests

# Docker Compose
docker-compose run --rm rf-tests
```

### Lokálně

```bash
# Vytvoření virtuálního prostředí
python -m venv .venv
source .venv/bin/activate  # Linux/Mac
.\.venv\Scripts\activate   # Windows

# Instalace závislostí
pip install -r requirements.txt
rfbrowser init

# Konfigurace
cp .env.example .env
# Upravte .env s vašimi přihlašovacími údaji

# Spuštění testů
robot --outputdir results tests/
```

## Struktura projektu

```
MEJ/
├── common.resource          # Sdílená klíčová slova
├── global_variables.resource # Globální proměnné
├── login_locators.resource  # Lokátory pro přihlášení
├── login_page.resource      # Přihlašovací page object
├── pyproject.toml           # Konfigurace projektu
├── requirements.txt         # Python závislosti
├── Dockerfile              # Docker konfigurace
├── docker-compose.yml      # Docker Compose
├── resources/              # Zdroje
│   ├── api/               # API klíčová slova
│   ├── db/                # Databázové klíčová slova
│   ├── company/           # Company role
│   ├── drivers/           # Driver role
│   ├── operators/         # Operator role
│   ├── register/          # Registrace nových entit
│   │   ├── locators/      # Lokátory pro registraci
│   │   └── page/          # Page objects pro registraci
│   ├── libraries/         # Python knihovny
│   └── python_skripts.py  # Pomocné Python funkce
└── tests/                 # Testovací soubory
    ├── operators/         # Operátor testy
    │   ├── negative_content/  # Negativní testy
    │   └── valid_content/     # Validační testy
    ├── registers/         # Registrační testy
    │   └── driver_registration.robot  # Registrace řidiče
    ├── tour_route.robot   # E2E test tras
    └── package.robot      # E2E test balíčků
```

## Environment proměnné

| Proměnná | Popis | Povinné |
|----------|-------|---------|
| MEJ_URL | URL testované aplikace | Ano |
| MEJ_ADMIN_EMAIL | Admin email | Ano |
| MEJ_ADMIN_PASSWORD | Admin heslo | Ano |
| MEJ_DRIVER_EMAIL | Driver email | Pro driver testy |
| MEJ_DRIVER_PASSWORD | Driver heslo | Pro driver testy |
| MEJ_COMPANY_EMAIL | Company email | Pro company testy |
| MEJ_COMPANY_PASSWORD | Company heslo | Pro company testy |
| MEJ_HEADLESS | Headless mode (True/False) | Ne (default: True) |

## Spouštění konkrétních testů

```bash
# Konkrétní tag
robot --include smoke tests/

# Vyloučení tagů
robot --exclude wip tests/

# Konkrétní soubor
robot tests/tour_route.robot
```

## Tags

- `smoke` - Rychlé kritické testy
- `e2e` - End-to-end testy
- `positive` - Pozitivní scénáře
- `negative` - Negativní scénáře
- `p1` - Kritická priorita
- `register` - Registrační testy
- `wip` - Work in progress (vyloučit z CI)

## Python pomocné funkce

V souboru `resources/python_skripts.py` jsou dostupné funkce pro generování testovacích dat:

| Funkce | Popis |
|--------|-------|
| `generate_ico()` | Generuje české IČO (8-místné číslo) |
| `generate_vat_number(country_code)` | Generuje DIČ pro zadanou zemi |
| `generate_valid_czech_iban()` | Generuje validní český IBAN |

Použití v Robot Framework:
```robotframework
${ico}=    generate_ico
${vat}=    generate_vat_number    CZ
${iban}=    generate_valid_czech_iban
```

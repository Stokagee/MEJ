# MEJ Robot Framework Testing Project

Complete documentation for automated end-to-end tests of the MEJ web application (ride and transportation management system).

## Table of Contents

- [Introduction](#introduction)
- [Technologies and Prerequisites](#technologies-and-prerequisites)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Architecture](#architecture)
- [Running Tests](#running-tests)
- [TeamCity Integration](#teamcity-integration)
- [Writing Tests](#writing-tests)
- [Troubleshooting](#troubleshooting)
- [Reference](#reference)

---

## Introduction

### What is this project

This project contains automated end-to-end tests for the MEJ web application, which is a system for managing rides and transportation. Tests are written in Robot Framework using Playwright for browser automation.

### Purpose of tests

- Verify correct application functionality after changes
- Detect regression bugs
- Validate forms and user inputs
- Test complete workflows across different user roles
- Verify API and database operations

### Project statistics

| Metric | Value |
|--------|-------|
| Test files | 17 |
| Resource files | 41 |
| Test scenarios | approximately 70 to 80 |
| User roles | 3 (Operator, Driver, Company) |
| Supported browsers | Chromium |

---

## Technologies and Prerequisites

### Technologies used

| Technology | Version | Purpose |
|------------|---------|---------|
| Robot Framework | 7.0 and higher | Core testing framework |
| Python | 3.11 and higher | Runtime environment |
| robotframework-browser | 18.0 and higher | Browser automation (Playwright) |
| Playwright | - | Browser automation engine |
| Node.js | 20.x | Required for Playwright |
| Docker | - | Test containerization |
| Docker Compose | - | Docker container management |
| Microsoft SQL Server | - | Database (via ODBC Driver 17) |

### Python libraries

| Library | Purpose |
|---------|---------|
| robotframework-faker | Generating random test data |
| robotframework-databaselibrary | Database operations |
| robotframework-requests | HTTP API testing |
| geopy | Geographic distance calculation |

### System requirements

For local test execution you need:

- **Python 3.11 or higher** - [python.org](https://www.python.org/downloads/)
- **Node.js 20.x** - [nodejs.org](https://nodejs.org/)
- **Git** - for cloning the repository
- **Docker and Docker Compose** - for containerized execution (optional)
- **ODBC Driver 17 for SQL Server** - for database tests

### Repository access

You need access to the Git repository with the project. Contact the project administrator to obtain access.

---

## Quick Start

This section will guide you through the basic steps for your first test run.

### Step 1: Clone the repository

```bash
git clone <repo-url>
cd MEJ
```

### Step 2: Create virtual environment

**Windows:**
```bash
python -m venv venv
venv\Scripts\activate
```

**Linux and macOS:**
```bash
python -m venv venv
source venv/bin/activate
```

### Step 3: Install dependencies

```bash
pip install -r requirements.txt
```

### Step 4: Install browser

This step downloads and installs the Chromium browser for testing:

```bash
rfbrowser init
```

Note: This step may take several minutes as browser binaries are downloaded.

### Step 5: Configure environment

Copy the template file with environment variables:

```bash
cp .env.example .env
```

Open the `.env` file and fill in your credentials:

```bash
# --- Credentials - Admin ---
MEJ_ADMIN_EMAIL=your-admin@email.com
MEJ_ADMIN_PASSWORD=your-password

# --- Credentials - Driver ---
MEJ_DRIVER_EMAIL=your-driver@email.com
MEJ_DRIVER_PASSWORD=your-password

# --- Credentials - Company ---
MEJ_COMPANY_EMAIL=your-company@email.com
MEJ_COMPANY_PASSWORD=your-password
```

Important: Never commit the `.env` file to Git. It is already added to `.gitignore`.

### Step 6: Run tests

```bash
robot --outputdir results tests/
```

After tests complete, you will find results in the `results/` folder:
- `report.html` - comprehensive HTML report with results
- `log.html` - detailed test execution log
- `output.xml` - results in XML format

---

## Project Structure

```
MEJ/
|
+-- CONFIGURATION
|   |-- pyproject.toml              # Robot Framework Browser configuration
|   |-- requirements.txt            # Python dependencies
|   |-- Dockerfile                  # Docker image definition
|   |-- docker-compose.yml          # Docker Compose configuration
|   |-- .env.example                # Template file for environment variables
|   |-- .gitignore                  # Git ignored files
|   |-- README.md                   # Basic documentation
|
+-- BASIC RESOURCES (root directory)
|   |-- common.resource              # Shared keywords and imports
|   |-- global_variables.resource    # Global variables
|   |-- login_locators.resource      # Locators for login page
|   |-- login_page.resource          # Page object for login page
|
+-- resources/
|   |-- api/                         # API keywords
|   |-- db/                          # Database keywords
|   |-- libraries/                   # Custom Python libraries
|   |-- Python_skripts.py            # Helper Python functions
|   |
|   |-- operators/                   # ROLE: Admin and Operator
|   |   |-- locators/                # Locators for admin pages
|   |   |-- page/                    # Page objects for admin pages
|   |   |-- workflows/               # Complex workflows
|   |
|   |-- drivers/                     # ROLE: Driver
|   |   |-- locators/                # Locators for driver pages
|   |   |-- page/                    # Page objects for driver pages
|   |
|   |-- company/                     # ROLE: Company
|   |   |-- locators/                # Locators for company pages
|   |   |-- page/                    # Page objects for company pages
|   |
|   |-- Register/                    # Registration of new entities
|
+-- tests/
    |-- Negative/                    # Negative tests (error validation)
    |-- Operator/                    # Operator and admin tests
    |-- Registers/                   # Registration tests
    |-- Valid_content/               # Positive validation tests
    |-- tour_route.robot             # E2E test for tour routes
    |-- package.robot                # E2E test for ride packaging
    |-- exam.robot                   # API tests
    |-- te.robot                     # Tests with database
```

### Meaning of main directories

| Directory | Meaning |
|-----------|---------|
| `resources/` | All test resources (locators, page objects, workflows) |
| `tests/` | Test files in .robot format |
| `results/` | Output folder with test results (created automatically) |

---

## Architecture

### Page Object Model

The project uses the **Page Object Model (POM)** pattern, which separates element definitions on the page from test logic.

**Defined layers:**

1. **Locators** - CSS selectors and XPath expressions for finding elements on the page
2. **Page** - Keywords for interacting with individual pages
3. **Workflows** - Complex workflows combining multiple steps together

**Advantages of this approach:**

- Only locators change when application design changes
- Tests are more readable and maintainable
- Reusable keywords

### User roles

The project tests the application from the perspective of three user roles:

| Role | Description | Folder in resources/ |
|------|-------------|---------------------|
| **Operator/Admin** | System administration, ride management, invoicing, packaging | `operators/` |
| **Driver** | Driver who confirms rides, views assigned routes | `drivers/` |
| **Company** | Transportation company, offers vehicles and services | `company/` |

### Shared resources

**common.resource** - central file that:
- Imports all necessary libraries (Browser, FakerLibrary, etc.)
- Defines universal keywords (Click Element, Fill Field, etc.)
- Is imported in all test files

**global_variables.resource** - defines:
- Application URL
- Login credentials for individual roles
- Browser configuration (headless, window dimensions)
- Database connection

---

## Running Tests

### Local execution

#### Run all tests

```bash
robot --outputdir results tests/
```

#### Run specific file

```bash
robot --outputdir results tests/tour_route.robot
robot --outputdir results tests/Operator/test_1.robot
```

#### Run tests by directory

```bash
robot --outputdir results tests/Negative/
robot --outputdir results tests/Registers/
```

#### Run tests with specific tag

```bash
robot --outputdir results --include smoke tests/
robot --outputdir results --include e2e tests/
robot --outputdir results --include positive tests/
```

#### Exclude tests with specific tag

```bash
robot --outputdir results --exclude wip tests/
```

#### Combine tags

```bash
robot --outputdir results --include e2e --exclude wip tests/
robot --outputdir results --include smoke --include p1 tests/
```

### Docker execution

#### Build Docker image

```bash
docker-compose build
```

#### Run all tests

```bash
docker-compose run --rm rf-tests
```

#### Run specific tests

```bash
docker-compose run --rm rf-tests robot --include smoke tests/
docker-compose run --rm rf-tests robot tests/tour_route.robot
```

#### Run with custom variables

```bash
docker-compose run --rm -e MEJ_HEADLESS=False rf-tests
```

### Test tags

Tags serve for categorization and filtering of tests:

| Tag | Meaning | Usage example |
|-----|---------|---------------|
| `smoke` | Critical tests for quick system check | `--include smoke` |
| `e2e` | End-to-end tests covering complete workflow | `--include e2e` |
| `positive` | Positive test scenarios (expected success) | `--include positive` |
| `negative` | Negative scenarios (testing error states) | `--include negative` |
| `p1` | Priority 1 (high, critical tests) | `--include p1` |
| `p2` | Priority 2 (medium) | `--include p2` |
| `wip` | Work in progress (unfinished tests) | `--exclude wip` |

---

## TeamCity Integration

### How it works

Tests are designed to run in TeamCity CI/CD environment. Integration principle:

1. **Docker container** - TeamCity runs tests in a Docker container
2. **Environment variables** - All configuration values are passed as environment variables
3. **Headless mode** - Browser runs without graphical interface (default setting)
4. **Outputs** - Test results are mounted to the `./results` folder
5. **WIP exclusion** - Tests with the `wip` tag are automatically excluded

### Setting up TeamCity project

#### Step 1: Create Build Configuration

1. In TeamCity, create a new project or use an existing one
2. Add a new Build Configuration named for example `MEJ_E2E_Tests`
3. Set VCS root to the test repository

#### Step 2: Configure Build Steps

**Type:** Command Line or Docker Compose

**Working directory:** root directory of MEJ project

**Script:**
```bash
docker-compose run --rm rf-tests
```

Alternatively with explicit variables:
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

#### Step 3: Configure parameters

In TeamCity add the following parameters (Settings > Parameters):

| Parameter | Type | Required | Default value |
|-----------|------|----------|---------------|
| `env.MEJ_URL` | Text | Yes | `https://shared-testing-2.continero.com/` |
| `env.MEJ_API_URL` | Text | No | `https://shared-testing-2.continero.com` |
| `env.MEJ_HEADLESS` | Text | No | `True` |
| `env.MEJ_ADMIN_EMAIL` | Text | Yes | - |
| `env.MEJ_ADMIN_PASSWORD` | Password | Yes | - |
| `env.MEJ_DRIVER_EMAIL` | Text | Yes | - |
| `env.MEJ_DRIVER_PASSWORD` | Password | Yes | - |
| `env.MEJ_COMPANY_EMAIL` | Text | Yes | - |
| `env.MEJ_COMPANY_PASSWORD` | Password | Yes | - |
| `env.MEJ_API_KEY` | Password | No | - |
| `env.MEJ_DB_HOST` | Text | Yes | - |
| `env.MEJ_DB_PORT` | Text | Yes | - |
| `env.MEJ_DB_NAME` | Text | Yes | - |
| `env.MEJ_DB_USER` | Text | Yes | - |
| `env.MEJ_DB_PASSWORD` | Password | Yes | - |

#### Step 4: Configure Artifact Paths

In General Settings section set Artifact Paths:

```
results/** => results
```

This ensures that test results (report.html, log.html) will be available after the build completes.

#### Step 5: Configure Triggers

Recommended triggers:

**VCS Trigger:**
- Runs tests after each commit
- Quiet period: 60 seconds (waiting for commit accumulation)

**Schedule Trigger:**
- Runs tests every morning (for example at 02:00)
- Allows detecting problems from the previous day

**Dependency Trigger:**
- Runs tests after successful application deployment

#### Step 6: Failure Conditions

In Failure Conditions section enable:
- **Test failures** - mark build as failed if any test fails
- **Build log contains** - add text `FAIL` as failure indicator

### Complete configuration example

```yaml
# Build Configuration: MEJ_E2E_Tests

# General Settings
Build directory: MEJ/
Clean build: Enabled
Artifact paths: results/** => results

# VCS Settings
VCS root: MEJ repository
Branch filter: +:* (all branches)

# Build Steps
Step 1: Command Line
  Working directory: ./
  Script: docker-compose run --rm rf-tests

# Parameters
env.MEJ_URL = https://shared-testing-2.continero.com/
env.MEJ_API_URL = https://shared-testing-2.continero.com
env.MEJ_HEADLESS = True
env.MEJ_ADMIN_EMAIL = (fill in)
env.MEJ_ADMIN_PASSWORD = (fill in - password type)
env.MEJ_DRIVER_EMAIL = (fill in)
env.MEJ_DRIVER_PASSWORD = (fill in - password type)
env.MEJ_COMPANY_EMAIL = (fill in)
env.MEJ_COMPANY_PASSWORD = (fill in - password type)
env.MEJ_API_KEY = (fill in - password type)
env.MEJ_DB_HOST = (fill in)
env.MEJ_DB_PORT = (fill in)
env.MEJ_DB_NAME = (fill in)
env.MEJ_DB_USER = (fill in)
env.MEJ_DB_PASSWORD = (fill in - password type)

# Triggers
VCS Trigger: Quiet period 60s

# Failure Conditions
Test failures: Enable
Build log contains: FAIL
```

### Dynamic configuration by branch

For different branches you can set different URLs and databases:

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

## Writing Tests

### Basic test file structure

```robotframework
*** Settings ***
Documentation     Tests for specific functionality
Resource          ../common.resource

*** Variables ***
${pick_up_time}        10:00
${destination}         Prague

*** Test Cases ***
Name of test scenario
    [Documentation]    Description of what the test verifies
    [Tags]             e2e    positive    p1
    Given I am logged in as admin
    When I navigate to rides page
    Then I see list of rides
```

### Best practices

1. **Always use common.resource** - ensures you have access to all libraries and keywords

2. **Use descriptive test names** - test name should say what is being tested, not how

3. **Add documentation and tags** - every test should have `[Documentation]` and `[Tags]`

4. **Utilize POM** - separate locators, page objects and workflows into appropriate files

5. **Do not repeat code** - move repeating sequences to workflow files

---

## Troubleshooting

### Common errors and solutions

| Error | Cause | Solution |
|-------|-------|----------|
| `Browser not found` | Playwright browser is not installed | Run `rfbrowser init` |
| `Timeout on element` | Element did not load within time limit | Increase `${TIMEOUT}` in `global_variables.resource` |
| `Invalid credentials` | Wrong login credentials | Check the `.env` file |
| `Docker permission denied` | User does not have Docker permissions | Add user to docker group |
| `Element not found` | Selector on page has changed | Update locators |
| `Database connection failed` | Wrong DB credentials or connection | Check DB parameters in `.env` |

### Debug mode

For more detailed output during testing:

```bash
robot --loglevel DEBUG --outputdir results tests/
```

For interactive debug you can uncomment in `requirements.txt`:
```
robotframework-debug
```

And in `common.resource` uncomment:
```
DebugLibrary
```

### Logs and screenshots

After each test run you will find in the `results/` folder:

- **report.html** - comprehensive HTML report with test results
- **log.html** - detailed test execution log including screenshots
- **output.xml** - results in XML format (for further processing)

When a test fails, a screenshot and HTML page state are automatically saved.

---

## Reference

### List of environment variables

| Variable | Meaning | Default value |
|----------|---------|---------------|
| `MEJ_URL` | URL of tested application | `https://shared-testing-2.continero.com/` |
| `MEJ_API_URL` | API base URL | `https://shared-testing-2.continero.com` |
| `MEJ_HEADLESS` | Browser headless mode | `True` |
| `MEJ_ADMIN_EMAIL` | Admin user email | - |
| `MEJ_ADMIN_PASSWORD` | Admin user password | - |
| `MEJ_DRIVER_EMAIL` | Driver user email | - |
| `MEJ_DRIVER_PASSWORD` | Driver user password | - |
| `MEJ_COMPANY_EMAIL` | Company user email | - |
| `MEJ_COMPANY_PASSWORD` | Company user password | - |
| `MEJ_API_KEY` | API key for MEJ API | - |
| `MEJ_DB_HOST` | Database server address | - |
| `MEJ_DB_PORT` | Database port | - |
| `MEJ_DB_NAME` | Database name | - |
| `MEJ_DB_USER` | Database user | - |
| `MEJ_DB_PASSWORD` | Database password | - |

### Robot Framework global variables

| Variable | Meaning | Source |
|----------|---------|--------|
| `${URL}` | Application URL | `MEJ_URL` env var |
| `${TIMEOUT}` | Timeout for waiting on elements | `60` seconds |
| `${BROWSER}` | Browser type | `chromium` |
| `${HEADLESS}` | Headless mode | `MEJ_HEADLESS` env var |
| `${WIDTH}` | Browser window width | `1800` |
| `${HEIGHT}` | Browser window height | `900` |

### Useful commands

| Command | Description |
|---------|-------------|
| `pip install -r requirements.txt` | Install all dependencies |
| `rfbrowser init` | Install Playwright browser |
| `robot --outputdir results tests/` | Run all tests |
| `robot --include smoke tests/` | Run only smoke tests |
| `robot --exclude wip tests/` | Exclude WIP tests |
| `robot --dryrun tests/` | Syntax check without execution |
| `robot --loglevel DEBUG tests/` | Run with debug output |
| `docker-compose build` | Build Docker image |
| `docker-compose run --rm rf-tests` | Run tests in Docker |

### Documentation links

- [Robot Framework User Guide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)
- [Robot Framework Browser](https://marketsquare.github.io/robotframework-browser/Browser.html)
- [Playwright Documentation](https://playwright.dev/python/docs/intro)

---

## Contact and Support

For questions about this project, contact the repository administrator.

This documentation was created for new team members to help them quickly start working with the testing framework.

- Generated by AI.

- Dušan.

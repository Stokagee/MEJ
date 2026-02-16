# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

# MEJ Robot Framework Test Project

Complete documentation for automated end-to-end tests of the MEJ web application (journey and transport management system).

## Contents

- [Introduction](#introduction)
- [Technologies and Prerequisites](#technologies-and-prerequisites)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Architecture](#architecture)
- [Running Tests](#running-tests)
- [TeamCity Integration](#teamcity-integration)
- [Creating Tests](#creating-tests)
- [Troubleshooting](#troubleshooting)
- [Reference](#reference)

---

## Introduction

### What is this Project

This project contains automated end-to-end tests for the MEJ web application, which is a journey and transport management system. Tests are written in Robot Framework using Playwright for browser automation.

### Purpose of Tests

- Verify correct application functionality after changes
- Detect regression bugs
- Validate forms and user inputs
- Test complete workflows across different user roles
- Verify API and database operations

### Project Statistics

| Metric | Value |
|--------|-------|
| Test files | 17 |
| Resource files | 41 |
| Test scenarios | approximately 70 to 80 |
| User roles | 3 (Operator, Driver, Company) |
| Supported browsers | Chromium |

---

## Technologies and Prerequisites

### Technologies Used

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

### Python Libraries

| Library | Purpose |
|---------|---------|
| robotframework-faker | Generate random test data |
| robotframework-databaselibrary | Database operations |
| robotframework-requests | HTTP API testing |
| geopy | Geographic distance calculations |

### System Requirements

For local test execution you need:

- **Python 3.11 or higher** - [python.org](https://www.python.org/downloads/)
- **Node.js 20.x** - [nodejs.org](https://nodejs.org/)
- **Git** - for cloning the repository
- **Docker and Docker Compose** - for containerized execution (optional)
- **ODBC Driver 17 for SQL Server** - for database tests

### Repository Access

You need access to the Git repository with the project. Contact the project administrator to obtain access.

---

## Quick Start

This section will guide you through the basic steps for first test execution.

### Step 1: Clone the Repository

```bash
git clone <repo-url>
cd MEJ
```

### Step 2: Create Virtual Environment

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

### Step 3: Install Dependencies

```bash
pip install -r requirements.txt
```

### Step 4: Install Browser

This step downloads and installs Chromium browser for testing:
```bash
rfbrowser init
```

Note: This step may take several minutes as it downloads browser binaries.

### Step 5: Configure Environment

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

Important: Never save the `.env` file to Git. It is already added to `.gitignore`.

### Step 6: Run Tests

```bash
robot --outputdir results tests/
```

After test completion you will find results in the `results/` folder:
- `report.html` - readable HTML report with results
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
|   |-- .env.example                # Environment variables template
|   |-- .gitignore                  # Git ignored files
|   |-- README.md                   # Basic documentation
|
+-- BASIC RESOURCES (root directory)
|   |-- common.resource              # Shared keywords and imports
|   |-- global_variables.resource    # Global variables
|   |-- login_locators.resource      # Login page locators
|   |-- login_page.resource          # Login page page object
|
+-- resources/
|   |-- api/                         # API keywords
|   |-- db/                          # Database keywords
|   |-- libraries/                   # Custom Python libraries
|   |-- Python_skripts.py            # Helper Python functions
|   |
|   |-- operators/                   # ROLE: Admin and Operator
|   |   |-- locators/                # Admin page locators
|   |   |-- page/                    # Admin page page objects
|   |   |-- workflows/               # Complex workflows
|   |
|   |-- drivers/                     # ROLE: Driver
|   |   |-- locators/                # Driver page locators
|   |   |-- page/                    # Driver page page objects
|   |
|   |-- company/                     # ROLE: Company
|   |   |-- locators/                # Company page locators
|   |   |-- page/                    # Company page page objects
|   |
|   |-- Register/                    # New entity registration
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

### Main Directory Purpose

| Directory | Purpose |
|-----------|---------|
| `resources/` | All test resources (locators, page objects, workflows) |
| `tests/` | Test files in .robot format |
| `results/` | Output folder with test results (created automatically) |

---

## Architecture

### Page Object Model

The project uses the **Page Object Model (POM)** pattern, which separates page element definitions from test logic.

**Three Layers:**

1. **Locators** - CSS selectors and XPath expressions for finding elements on the page
2. **Page** - Keywords for interacting with individual pages
3. **Workflows** - Complex workflows combining multiple steps together

**Advantages of this approach:**

- Only locators change when application design changes
- Tests are more readable and maintainable
- Reusable keywords

### User Roles

The project tests the application from three user role perspectives:

| Role | Description | Folder in resources/ |
|------|-------------|---------------------|
| **Operator/Admin** | System administration, journey management, invoicing, packaging | `operators/` |
| **Driver** | Driver who confirms rides, views assigned routes | `drivers/` |
| **Company** | Transport company offering vehicles and services | `company/` |

### Shared Resources

**common.resource** - central file that:
- Imports all necessary libraries (Browser, FakerLibrary, etc.)
- Defines universal keywords (Click Element, Fill Field, etc.)
- Is imported in all test files

**global_variables.resource** - defines:
- Application URL
- Login credentials for each role
- Browser configuration (headless, window dimensions)
- Database connection

---

## Running Tests

### Local Execution

#### Run All Tests

```bash
robot --outputdir results tests/
```

#### Run Specific File

```bash
robot --outputdir results tests/tour_route.robot
robot --outputdir results tests/Operator/test_1.robot
```

#### Run Tests by Directory

```bash
robot --outputdir results tests/Negative/
robot --outputdir results tests/Registers/
```

#### Run Tests with Specific Tag

```bash
robot --outputdir results --include smoke tests/
robot --outputdir results --include e2e tests/
robot --outputdir results --include positive tests/
```

#### Exclude Tests with Specific Tag

```bash
robot --outputdir results --exclude wip tests/
```

#### Combine Tags

```bash
robot --outputdir results --include e2e --exclude wip tests/
robot --outputdir results --include smoke --include p1 tests/
```

### Docker Execution

#### Build Docker Image

```bash
docker-compose build
```

#### Run All Tests

```bash
docker-compose run --rm rf-tests
```

#### Run Specific Tests

```bash
docker-compose run --rm rf-tests robot --include smoke tests/
docker-compose run --rm rf-tests robot tests/tour_route.robot
```

#### Run with Custom Variables

```bash
docker-compose run --rm -e MEJ_HEADLESS=False rf-tests
```

### Test Tags

Tags are used for categorizing and filtering tests:

| Tag | Meaning | Usage Example |
|-----|---------|---------------|
| `smoke` | Critical tests for quick system check | `--include smoke` |
| `e2e` | End-to-end tests covering entire workflow | `--include e2e` |
| `positive` | Positive test scenarios (expected success) | `--include positive` |
| `negative` | Negative scenarios (error state testing) | `--include negative` |
| `p1` | Priority 1 (high, critical tests) | `--include p1` |
| `p2` | Priority 2 (medium) | `--include p2` |
| `wip` | Work in progress (unfinished tests) | `--exclude wip` |

---

## TeamCity Integration

### How It Works

Tests are designed to run in TeamCity CI/CD environment. Integration principle:

1. **Docker container** - TeamCity runs tests in Docker container
2. **Environment variables** - All configuration values are passed as environment variables
3. **Headless mode** - Browser runs without GUI (default setting)
4. **Outputs** - Test results are mounted to `./results` folder
5. **WIP exclusion** - Tests with `wip` tag are automatically excluded

### TeamCity Project Setup

#### Step 1: Create Build Configuration

1. In TeamCity create a new project or use existing
2. Add new Build Configuration with name e.g. `MEJ_E2E_Tests`
3. Set VCS root to the test repository

#### Step 2: Configure Build Steps

**Type:** Command Line or Docker Compose

**Working directory:** MEJ project root directory

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

#### Step 3: Configure Parameters

In TeamCity add the following parameters (Settings > Parameters):

| Parameter | Type | Required | Default Value |
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

This ensures test results (report.html, log.html) are available after build completion.

#### Step 5: Configure Triggers

Recommended triggers:

**VCS Trigger:**
- Runs tests after each commit
- Quiet period: 60 seconds (wait for commit accumulation)

**Schedule Trigger:**
- Runs tests every morning (e.g. at 02:00)
- Allows detecting problems from previous day

**Dependency Trigger:**
- Runs tests after successful application deployment

#### Step 6: Failure Conditions

In Failure Conditions section enable:
- **Test failures** - mark build as failed if any test fails
- **Build log contains** - add text `FAIL` as failure indicator

### Complete Configuration Example

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

### Dynamic Configuration by Branch

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

## Creating Tests

### Basic Test File Structure

```robotframework
*** Settings ***
Documentation     Tests for specific functionality
Resource          ../common.resource

*** Variables ***
${pick_up_time}        10:00
${destination}         Prague

*** Test Cases ***
Test scenario name
    [Documentation]    Description of what the test verifies
    [Tags]             e2e    positive    p1
    Given I am logged in as admin
    When I navigate to rides page
    Then I see list of rides
```

### Best Practices

1. **Always use common.resource** - ensures access to all libraries and keywords
2. **Use descriptive test names** - test name should say what is tested, not how
3. **Add documentation and tags** - every test should have `[Documentation]` and `[Tags]`
4. **Utilize POM** - separate locators, page objects and workflows into appropriate files
5. **Don't repeat code** - move repeating sequences to workflow files

---

## Troubleshooting

### Common Errors and Solutions

| Error | Cause | Solution |
|-------|-------|----------|
| `Browser not found` | Playwright browser not installed | Run `rfbrowser init` |
| `Timeout on element` | Element didn't load within time limit | Increase `${TIMEOUT}` in `global_variables.resource` |
| `Invalid credentials` | Wrong login credentials | Check `.env` file |
| `Docker permission denied` | User doesn't have Docker permissions | Add user to docker group |
| `Element not found` | Selector changed on page | Update locators |
| `Database connection failed` | Wrong DB credentials or connection | Check DB parameters in `.env` |

### Debug Mode

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

### Logs and Screenshots

After each test run you find in `results/` folder:

- **report.html** - readable HTML report with test results
- **log.html** - detailed test execution log including screenshots
- **output.xml** - results in XML format (for further processing)

On test failure, screenshot and HTML page state are automatically saved.

---

## Reference

### Environment Variables List

| Variable | Meaning | Default Value |
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

### Robot Framework Global Variables

| Variable | Meaning | Source |
|----------|---------|--------|
| `${URL}` | Application URL | `MEJ_URL` env var |
| `${TIMEOUT}` | Timeout for waiting on elements | `60` seconds |
| `${BROWSER}` | Browser type | `chromium` |
| `${HEADLESS}` | Headless mode | `MEJ_HEADLESS` env var |
| `${WIDTH}` | Browser window width | `1800` |
| `${HEIGHT}` | Browser window height | `900` |

### Useful Commands

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

### Documentation Links

- [Robot Framework User Guide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)
- [Robot Framework Browser](https://marketsquare.github.io/robotframework-browser/Browser.html)
- [Playwright Documentation](https://playwright.dev/python/docs/intro)

---

## Contact and Support

For questions about this project contact the repository administrator.

Documentation was created for new team members to quickly start working with the testing framework.

- Generated by AI and checked by me.

- Dušan.

*** Variables ***
# =============================================================================
# MEJ Robot Framework Tests - Global Variables
# =============================================================================
# Variables are read from environment variables (MEJ_ prefix).
# These can be set via:
#   1. .env file (for local development)
#   2. Docker Compose (docker-compose.yml)
#   3. TeamCity CI/CD (environment parameters)
#   4. Command line: robot --variable NAME:value tests/
# =============================================================================

# Logging configuration
${LOG_TO_CONSOLE}     %{MEJ_LOG_TO_CONSOLE=True}

# Application URL
${URL}                %{MEJ_URL=}

# Timeout for waiting on elements
${TIMEOUT}            %{MEJ_TIMEOUT=0}

# Login credentials - Admin
${ADMIN_EMAIL}        %{MEJ_ADMIN_EMAIL=}
${ADMIN_PASSWORD}     %{MEJ_ADMIN_PASSWORD=}

# Login credentials - Driver
${DRIVER_EMAIL}       %{MEJ_DRIVER_EMAIL=}
${DRIVER_PASSWORD}    %{MEJ_DRIVER_PASSWORD=}

# Login credentials - Company
${COMPANY_EMAIL}      %{MEJ_COMPANY_EMAIL=}
${COMPANY_PASSWORD}   %{MEJ_COMPANY_PASSWORD=}

# Browser configuration
${BROWSER}            chromium
${HEADLESS}           %{MEJ_HEADLESS=}
${WIDTH}              1800
${HEIGHT}             900
${WIDTH_1}            1800
${HEIGHT_1}           900

# API configuration
${API_BASE_URL}       %{MEJ_API_URL=}
${API_KEY_HEADER}     X-Mej-API-Key
${API_KEY_VALUE}      %{MEJ_API_KEY=}

# Database configuration
${DB_CONFIG}          pyodbc
${DB_NAME}            %{MEJ_DB_NAME=}
${DB_HOST}            %{MEJ_DB_HOST=}
${DB_PORT}            %{MEJ_DB_PORT=}
${DB_USER}            %{MEJ_DB_USER=}
${DB_PASSWORD}        %{MEJ_DB_PASSWORD=}
${DB_CONN_STRING}     DRIVER={ODBC Driver 17 for SQL Server};SERVER=${DB_HOST},${DB_PORT};DATABASE=${DB_NAME};UID=${DB_USER};PWD=${DB_PASSWORD};TrustServerCertificate=yes

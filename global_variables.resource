*** Variables ***
# =============================================================================
# MEJ Robot Framework Tests - Global Variables
# Values can be overridden from TeamCity using --variable NAME:value
# =============================================================================

# Application URL (TC: --variable URL:xxx)
${URL}                ${EMPTY}

# Timeout for waiting on elements
${TIMEOUT}            60

# Login credentials - Admin (TC: --variable ADMIN_EMAIL:xxx --variable ADMIN_PASSWORD:xxx)
${ADMIN_EMAIL}        ${EMPTY}
${ADMIN_PASSWORD}     ${EMPTY}

# Login credentials - Driver (TC: --variable DRIVER_EMAIL:xxx --variable DRIVER_PASSWORD:xxx)
${DRIVER_EMAIL}       ${EMPTY}
${DRIVER_PASSWORD}    ${EMPTY}

# Login credentials - Company (TC: --variable COMPANY_EMAIL:xxx --variable COMPANY_PASSWORD:xxx)
${COMPANY_EMAIL}      %{COMPANY_EMAIL=}
${COMPANY_PASSWORD}   %{COMPANY_PASSWORD=}

# Browser configuration
${BROWSER}            chromium
${HEADLESS}           ${True}
${WIDTH}              1800
${HEIGHT}             900
${WIDTH_1}            1800
${HEIGHT_1}           900

# API configuration (TC: --variable API_BASE_URL:xxx --variable API_KEY_VALUE:xxx)
${API_BASE_URL}       ${EMPTY}
${API_KEY_HEADER}     X-Mej-API-Key
${API_KEY_VALUE}      ${EMPTY}

# Database configuration (TC: --variable DB_NAME:xxx --variable DB_USER:xxx --variable DB_PASSWORD:xxx)
${DB_CONFIG}          pyodbc
${DB_NAME}            ${EMPTY}
${DB_HOST}            %{DB_HOST=}
${DB_PORT}            %{DB_PORT=}
${DB_USER}            %{DB_USER=}
${DB_PASSWORD}        %{DB_PASSWORD=}
${DB_CONN_STRING}     DRIVER={ODBC Driver 17 for SQL Server};SERVER=${DB_HOST},${DB_PORT};DATABASE=${DB_NAME};UID=${DB_USER};PWD=${DB_PASSWORD};TrustServerCertificate=yes

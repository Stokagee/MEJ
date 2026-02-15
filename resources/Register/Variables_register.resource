*** Variables ***
# Registration test passwords (for newly created test users)
${PASSWORD_LOG}       Pan123!
${PASSWORD_CONFIRM_LOG}    Pan123!
${BROWSER}        chromium    # Browser used for testing
${URL}            %{MEJ_URL=}    # Address of the test application (passed from CI/CD)
${DB_NAME}        %{MEJ_DB_NAME=}    # Name of the database (passed from CI/CD)
${SHORT}          20s      # Short wait timeout



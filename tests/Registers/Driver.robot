*** Settings ***
Documentation     This test suite validates the registration functionality for drivers.
...               It guides users through the registration process and verifies that.
Resource    ../../common.resource
Resource    ../../Resources/Register/Keywords_register.resource
Library    ../../Resources/Python_skripts.py
Library    Browser

*** Test Cases ***
Register For a Driver
    [Tags]    register    driver    positive    p2
    [Documentation]    This test case ensures that:
    ...                - A driver can register using valid credentials and business details.
    ...                - The user is redirected to the dashboard after successful registration.
    ...                - The dashboard displays a welcome message to confirm success.
    ${browser_id}    ${context_id}    ${page_id}=    Initialize Browser Session
    ...    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}
    Navigate To Register Page
    Fill Valid Credentials
    [Teardown]    Close Browser

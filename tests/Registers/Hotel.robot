*** Settings ***
Documentation     This test suite validates the registration functionality for hotels.
...               It guides users through the registration process and verifies that.
...               - A hotel can register using valid credentials and business details.
Library    Browser
Resource    ../../Resources/Register/Keywords_register.resource
Resource    ../../Resources/Register/Variables_register.resource
Library    ../../Resources/Python_skripts.py

*** Test Cases ***
Register As Hotel
    [Tags]    e2e    register    positive    p2
    [Documentation]    This test case ensures that:
    ...                - A hotel can register using valid credentials and business details.
    ...                - The user is redirected to the dashboard after successful registration.
    ...                - The dashboard displays a welcome message to confirm success.
    New Browser    chromium    headless=${True}
    New Context    # Open a new context
    New Page    ${URL}   # Open the page
    Navigate To Hotel Register Page
    Fill Valid Hotel Credentials
    [Teardown]    Close Browser

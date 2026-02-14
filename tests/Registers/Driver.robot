*** Settings ***
Documentation     This test suite validates the registration functionality for drivers.
...               It guides users through the registration process and verifies that.
Resource    ../../Resources/Register/Keywords_register.resource
Resource    ../../Resources/Register/Variables_register.resource
Library    ../../Resources/Python_skripts.py
Library    Browser

*** Test Cases ***
Register For a Driver
    [Tags]    register    driver    positive    p2
    [Documentation]    This test case ensures that:
    ...                - A driver can register using valid credentials and business details.
    ...                - The user is redirected to the dashboard after successful registration.
    ...                - The dashboard displays a welcome message to confirm success.
    New Browser    chromium    headless=${True}    # Open a new browser
    New Context    # Open a new context
    New Page    ${URL}   # Open the page
    Navigate To Register Page
    Fill Valid Credentials
    [Teardown]    Close Browser

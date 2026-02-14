*** Settings ***
Library    Browser
Library    FakerLibrary
Resource    ../../Resources/Register/Variables_register.resource
Resource    ../../Resources/Register/Keywords_register.resource
Library    ../../Resources/Python_skripts.py


*** Test Cases ***
Register As Shuttle Company With VAT
    [Tags]    e2e    register    positive    p2
    [Documentation]    This test case ensures that:
    ...                - A shuttle company can register using valid credentials and VAT business details.
    ...                - The user is redirected to the dashboard after successful registration.
    ...                - The dashboard displays a welcome message to confirm success.
    New Browser    chromium    headless=${True}
    New Context    # Open a new context
    New Page    ${URL}   # Open the page
    Navigate To SH Register Page
    Fill Valid VAT SH Credentials
    [Teardown]    Close Browser


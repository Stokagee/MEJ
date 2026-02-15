*** Settings ***
Resource    ../../common.resource
Library    Browser
Library    FakerLibrary
Resource    ../../Resources/Register/Keywords_register.resource
Library    ../../Resources/Python_skripts.py


*** Test Cases ***
Register As Shuttle Company With VAT
    [Tags]    e2e    register    positive    p2
    [Documentation]    This test case ensures that:
    ...                - A shuttle company can register using valid credentials and VAT business details.
    ...                - The user is redirected to the dashboard after successful registration.
    ...                - The dashboard displays a welcome message to confirm success.
    ${browser_id}    ${context_id}    ${page_id}=    Initialize Browser Session
    ...    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}
    Navigate To SH Register Page
    Fill Valid VAT SH Credentials
    [Teardown]    Close Browser


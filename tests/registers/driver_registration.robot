*** Settings ***
Documentation     Test for new driver registration
...               This test verifies the complete driver registration workflow including:
...               - Personal information (1st page): name, phone, email, password
...               - Language skills (2nd page): native language, English level, driving experience
...               - Business details (3rd page): IČO, business name, address, IBAN, BIC
...               - Verification of successful registration
Resource          ../../common.resource

*** Variables ***
${PASSWORD}       Pan123!

*** Test Cases ***

Register New Driver
    [Documentation]    Complete registration of a new driver with random values (without VAT).
    ...                Returns: first_name, last_name, dial, phone, email, ico, business_name, iban
    [Tags]             e2e    register    positive    p1

    ${email}=    Complete Driver Registration Workflow    ${PASSWORD}

    [Teardown]    Close Browser

Register New Driver With VAT
    [Documentation]    Complete registration of a new driver with VAT number (VAT payer).
    ...                Returns: first_name, last_name, dial, phone, email, ico, vat, iban
    [Tags]             e2e    register    positive    p2

    ${email}=    Complete Driver Registration With VAT Workflow    ${PASSWORD}    CZ

    [Teardown]    Close Browser

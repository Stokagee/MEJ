*** Settings ***
Documentation     Tests for shuttle company registration
...               This test verifies the complete shuttle company registration workflow including:
...               - Personal information (1st page): name, phone, email, password
...               - Business details (3rd page): IČO, business name, address, IBAN, BIC
...               - NOTE: No second page (Languages) for Shuttle Company!
...               - Verification of successful registration
Resource          ../../common.resource

*** Variables ***
${PASSWORD}       Pan123!

*** Test Cases ***

Register New Shuttle Company
    [Documentation]    Complete registration of a new shuttle company with random values (without VAT).
    ...                Returns: first_name, last_name, dial, phone, email, ico, business_name, iban
    [Tags]             e2e    register    positive    p1    shuttle

    ${email}=    Complete Shuttle Company Registration Workflow    ${PASSWORD}

    [Teardown]    Close Browser

Register New Shuttle Company With VAT
    [Documentation]    Complete registration of a new shuttle company with VAT number (VAT payer).
    ...                Returns: first_name, last_name, dial, phone, email, ico, vat, iban
    [Tags]             e2e    register    positive    p2    shuttle    vat

    ${email}=    Complete Shuttle Company Registration With VAT Workflow    ${PASSWORD}    CZ

    [Teardown]    Close Browser

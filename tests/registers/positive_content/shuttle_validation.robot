*** Settings ***
Documentation    Positive tests for Shuttle Company registration form validation.
...              Tests maxlength truncation:
...              - First Name: max 128 characters
...              - Last Name: max 128 characters
...              - Phone: max 15 characters
...              - Email: max 256 characters
...              - Password: max 256 characters
...              - Business Number: max 20 characters
...              - ZIP Code: max 32 characters
...              - IBAN: max 34 characters
...              - BIC: max 11 characters
...              Note: Shuttle has only 2 pages (no Languages page)
...              Follows POM structure - uses keywords from validation_page.resource
Resource         ../../../common.resource

*** Test Cases ***
### *** First Name MaxLength ***

Test First Name MaxLength Truncation
    [Documentation]    Verify that First Name is truncated to 128 characters.
    ...                Validation rule: MaxLength(128)
    [Tags]    ui    register    shuttle    positive    p1    validation    maxlength    firstname
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Fill Register Field With Generated Text    ${FIRST_PAGE_REGISTER_SH_NAME_INPUT}    150
    Verify Register Field MaxLength Truncation    ${FIRST_PAGE_REGISTER_SH_NAME_INPUT}    128
    [Teardown]    Close Browser

### *** Last Name MaxLength ***

Test Last Name MaxLength Truncation
    [Documentation]    Verify that Last Name is truncated to 128 characters.
    ...                Validation rule: MaxLength(128)
    [Tags]    ui    register    shuttle    positive    p1    validation    maxlength    lastname
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Fill Register Field With Generated Text    ${FIRST_PAGE_REGISTER_SH_LAST_NAME_INPUT}    150
    Verify Register Field MaxLength Truncation    ${FIRST_PAGE_REGISTER_SH_LAST_NAME_INPUT}    128
    [Teardown]    Close Browser

### *** Phone MaxLength ***

Test Phone MaxLength Truncation
    [Documentation]    Verify that Phone is truncated to 15 characters.
    ...                Validation rule: MaxLength(15)
    [Tags]    ui    register    shuttle    positive    p1    validation    maxlength    phone
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Fill Register Field With Generated Text    xpath=//label[contains(text(), "Phone")]/preceding-sibling::input    20
    Verify Register Field MaxLength Truncation    xpath=//label[contains(text(), "Phone")]/preceding-sibling::input    15
    [Teardown]    Close Browser

### *** Business Number MaxLength (Page 2) ***

Test Business Number MaxLength Truncation
    [Documentation]    Verify that Business Number is truncated to 20 characters.
    ...                Validation rule: MaxLength(20)
    [Tags]    ui    register    shuttle    positive    p1    validation    maxlength    business
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Navigate To Second Page Shuttle
    Select Options By    ${THIRD_PAGE_REGISTER_SH_COUNTRY_DROPDOWN}    label    Czech Republic
    Fill Register Field With Generated Text    ${THIRD_PAGE_REGISTER_SH_BUSINESS_NUMBER_INPUT}    30
    Verify Register Field MaxLength Truncation    ${THIRD_PAGE_REGISTER_SH_BUSINESS_NUMBER_INPUT}    20
    [Teardown]    Close Browser

### *** ZIP Code MaxLength (Page 2) ***

Test Zip Code MaxLength Truncation
    [Documentation]    Verify that ZIP Code is truncated to 32 characters.
    ...                Validation rule: MaxLength(32)
    [Tags]    ui    register    shuttle    positive    p1    validation    maxlength    zipcode
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Navigate To Second Page Shuttle
    Select Options By    ${THIRD_PAGE_REGISTER_SH_COUNTRY_DROPDOWN}    label    Czech Republic
    Fill Register Field With Generated Text    ${THIRD_PAGE_REGISTER_SH_ZIP_CODE_INPUT}    40
    Verify Register Field MaxLength Truncation    ${THIRD_PAGE_REGISTER_SH_ZIP_CODE_INPUT}    32
    [Teardown]    Close Browser

### *** IBAN MaxLength (Page 2) ***

Test IBAN MaxLength Truncation
    [Documentation]    Verify that IBAN is truncated to 34 characters.
    ...                Validation rule: MaxLength(34)
    [Tags]    ui    register    shuttle    positive    p1    validation    maxlength    iban
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Navigate To Second Page Shuttle
    Select Options By    ${THIRD_PAGE_REGISTER_SH_COUNTRY_DROPDOWN}    label    Czech Republic
    Fill Register Field With Generated Text    ${THIRD_PAGE_REGISTER_SH_IBAN_INPUT}    40
    Verify Register Field MaxLength Truncation    ${THIRD_PAGE_REGISTER_SH_IBAN_INPUT}    34
    [Teardown]    Close Browser

### *** BIC MaxLength (Page 2) ***

Test BIC MaxLength Truncation
    [Documentation]    Verify that BIC is truncated to 11 characters.
    ...                Validation rule: MaxLength(11)
    [Tags]    ui    register    shuttle    positive    p1    validation    maxlength    bic
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Navigate To Second Page Shuttle
    Select Options By    ${THIRD_PAGE_REGISTER_SH_COUNTRY_DROPDOWN}    label    Czech Republic
    Fill Register Field With Generated Text    ${THIRD_PAGE_REGISTER_SH_BIC_INPUT}    15
    Verify Register Field MaxLength Truncation    ${THIRD_PAGE_REGISTER_SH_BIC_INPUT}    11
    [Teardown]    Close Browser

### *** Valid Data Test ***

Test Valid Data Passes Without Errors
    [Documentation]    Verify that valid registration data passes without validation errors.
    ...                Complete first page with valid data and verify no errors.
    [Tags]    ui    register    shuttle    positive    p1    validation    valid
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Fill First Page With Valid Data Shuttle
    Click Next Button Shuttle
    # Verify we navigated to page 2 (Business Details dropdown visible)
    Wait Element State    ${THIRD_PAGE_REGISTER_SH_COUNTRY_DROPDOWN}
    Log Verification    Successfully navigated to page 2 with valid data
    [Teardown]    Close Browser

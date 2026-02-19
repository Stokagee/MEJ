*** Settings ***
Documentation    Positive tests for Driver registration form validation.
...              Tests maxlength truncation:
...              - First Name: max 128 characters
...              - Last Name: max 128 characters
...              - Phone: max 15 characters
...              - Email: max 256 characters
...              - Password: max 256 characters
...              - About Me: max 2000 characters
...              - Business Number: max 20 characters
...              - ZIP Code: max 32 characters
...              - VAT Number: max 32 characters
...              - IBAN: max 34 characters
...              - BIC: max 11 characters
...              - Other business fields: max 256 characters
...              Follows POM structure - uses keywords from validation_page.resource
Resource         ../../../common.resource

*** Test Cases ***
### *** First Name MaxLength ***

Test First Name MaxLength Truncation
    [Documentation]    Verify that First Name is truncated to 128 characters.
    ...                Validation rule: MaxLength(128)
    [Tags]    ui    register    driver    positive    p1    validation    maxlength    firstname
    [Setup]    Open Browser And Navigate To Registration Form
    Fill Register Field With Generated Text    ${FIRST_PAGE_REGISTER_DRIVER_NAME_INPUT}    150
    Verify Register Field MaxLength Truncation    ${FIRST_PAGE_REGISTER_DRIVER_NAME_INPUT}    128
    [Teardown]    Close Browser

### *** Last Name MaxLength ***

Test Last Name MaxLength Truncation
    [Documentation]    Verify that Last Name is truncated to 128 characters.
    ...                Validation rule: MaxLength(128)
    [Tags]    ui    register    driver    positive    p1    validation    maxlength    lastname
    [Setup]    Open Browser And Navigate To Registration Form
    Fill Register Field With Generated Text    ${FIRST_PAGE_REGISTER_DRIVER_LAST_NAME_INPUT}    150
    Verify Register Field MaxLength Truncation    ${FIRST_PAGE_REGISTER_DRIVER_LAST_NAME_INPUT}    128
    [Teardown]    Close Browser

### *** Phone MaxLength ***

Test Phone MaxLength Truncation
    [Documentation]    Verify that Phone is truncated to 15 characters.
    ...                Validation rule: MaxLength(15)
    [Tags]    ui    register    driver    positive    p1    validation    maxlength    phone
    [Setup]    Open Browser And Navigate To Registration Form
    Fill Register Field With Generated Text    xpath=//label[contains(text(), "Phone")]/preceding-sibling::input    20
    Verify Register Field MaxLength Truncation    xpath=//label[contains(text(), "Phone")]/preceding-sibling::input    15
    [Teardown]    Close Browser

### *** Email MaxLength ***

Test Email MaxLength Truncation
    [Documentation]    Verify that Email is truncated to 256 characters.
    ...                Validation rule: MaxLength(256)
    [Tags]    ui    register    driver    positive    p1    validation    maxlength    email
    [Setup]    Open Browser And Navigate To Registration Form
    ${long_email}=    Generate Random String    250    [LETTERS]
    ${long_email}=    Catenate    ${long_email}@test.com
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_DRIVER_EMAIL_INPUT}    ${long_email}
    Verify Register Field MaxLength Truncation    ${FIRST_PAGE_REGISTER_DRIVER_EMAIL_INPUT}    256
    [Teardown]    Close Browser

### *** Password MaxLength ***

Test Password MaxLength Truncation
    [Documentation]    Verify that Password is truncated to 256 characters.
    ...                Validation rule: MaxLength(256)
    [Tags]    ui    register    driver    positive    p1    validation    maxlength    password
    [Setup]    Open Browser And Navigate To Registration Form
    ${long_password}=    Set Variable    Abcdefghij1!
    ${long_password}=    Catenate    SEPARATOR=    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}    ${long_password}
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_DRIVER_PASSWORD_INPUT}    ${long_password}
    Verify Register Field MaxLength Truncation    ${FIRST_PAGE_REGISTER_DRIVER_PASSWORD_INPUT}    256
    [Teardown]    Close Browser

### *** About Me MaxLength (Page 2) ***

Test About Me MaxLength Truncation Positive
    [Documentation]    Verify that About Me is truncated to 2000 characters.
    ...                Validation rule: MaxLength(2000)
    [Tags]    ui    register    driver    positive    p1    validation    maxlength    aboutme
    [Setup]    Open Browser And Navigate To Registration Form
    Navigate To Second Page Driver
    Fill Register Field With Generated Text    ${SECOND_PAGE_REGISTER_DRIVER_ABOUT_ME_INPUT}    2100
    Verify Register Field MaxLength Truncation    ${SECOND_PAGE_REGISTER_DRIVER_ABOUT_ME_INPUT}    2000
    [Teardown]    Close Browser

### *** Business Number MaxLength (Page 3) ***

Test Business Number MaxLength Truncation
    [Documentation]    Verify that Business Number is truncated to 20 characters.
    ...                Validation rule: MaxLength(20)
    [Tags]    ui    register    driver    positive    p1    validation    maxlength    business
    [Setup]    Open Browser And Navigate To Registration Form
    Navigate To Third Page Driver
    Select Options By    ${THIRD_PAGE_REGISTER_DRIVER_COUNTRY_DROPDOWN}    label    Czech Republic
    Fill Register Field With Generated Text    ${THIRD_PAGE_REGISTER_DRIVER_BUSINESS_NUMBER_INPUT}    30
    Verify Register Field MaxLength Truncation    ${THIRD_PAGE_REGISTER_DRIVER_BUSINESS_NUMBER_INPUT}    20
    [Teardown]    Close Browser

### *** ZIP Code MaxLength (Page 3) ***

Test Zip Code MaxLength Truncation
    [Documentation]    Verify that ZIP Code is truncated to 32 characters.
    ...                Validation rule: MaxLength(32)
    [Tags]    ui    register    driver    positive    p1    validation    maxlength    zipcode
    [Setup]    Open Browser And Navigate To Registration Form
    Navigate To Third Page Driver
    Select Options By    ${THIRD_PAGE_REGISTER_DRIVER_COUNTRY_DROPDOWN}    label    Czech Republic
    Fill Register Field With Generated Text    ${THIRD_PAGE_REGISTER_DRIVER_ZIP_CODE_INPUT}    40
    Verify Register Field MaxLength Truncation    ${THIRD_PAGE_REGISTER_DRIVER_ZIP_CODE_INPUT}    32
    [Teardown]    Close Browser

### *** IBAN MaxLength (Page 3) ***

Test IBAN MaxLength Truncation
    [Documentation]    Verify that IBAN is truncated to 34 characters.
    ...                Validation rule: MaxLength(34)
    [Tags]    ui    register    driver    positive    p1    validation    maxlength    iban
    [Setup]    Open Browser And Navigate To Registration Form
    Navigate To Third Page Driver
    Select Options By    ${THIRD_PAGE_REGISTER_DRIVER_COUNTRY_DROPDOWN}    label    Czech Republic
    Fill Register Field With Generated Text    ${THIRD_PAGE_REGISTER_DRIVER_IBAN_INPUT}    40
    Verify Register Field MaxLength Truncation    ${THIRD_PAGE_REGISTER_DRIVER_IBAN_INPUT}    34
    [Teardown]    Close Browser

### *** BIC MaxLength (Page 3) ***

Test BIC MaxLength Truncation
    [Documentation]    Verify that BIC is truncated to 11 characters.
    ...                Validation rule: MaxLength(11)
    [Tags]    ui    register    driver    positive    p1    validation    maxlength    bic
    [Setup]    Open Browser And Navigate To Registration Form
    Navigate To Third Page Driver
    Select Options By    ${THIRD_PAGE_REGISTER_DRIVER_COUNTRY_DROPDOWN}    label    Czech Republic
    Fill Register Field With Generated Text    ${THIRD_PAGE_REGISTER_DRIVER_BIC_INPUT}    15
    Verify Register Field MaxLength Truncation    ${THIRD_PAGE_REGISTER_DRIVER_BIC_INPUT}    11
    [Teardown]    Close Browser

### *** Valid Data Test ***

Test Valid Data Passes Without Errors
    [Documentation]    Verify that valid registration data passes without validation errors.
    ...                Complete first page with valid data and verify no errors.
    [Tags]    ui    register    driver    positive    p1    validation    valid
    [Setup]    Open Browser And Navigate To Registration Form
    Fill First Page With Valid Data Driver
    Click Next Button Driver
    # Verify we navigated to page 2 (Languages dropdown visible)
    Wait Element State    ${SECOND_PAGE_REGISTER_DRIVER_LANGUAGE_DROPDOWN}
    Log Verification    Successfully navigated to page 2 with valid data
    [Teardown]    Close Browser

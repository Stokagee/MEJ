*** Settings ***
Documentation    Negative tests for Shuttle Company registration form validation.
...              Tests validation messages for invalid inputs:
...              - First Name: min 2 characters
...              - Last Name: min 2 characters
...              - Email: valid format required
...              - Password: min 6 chars, requires lowercase, uppercase, special char
...              - Confirm Password: must match Password
...              - Terms of Use: must be checked
...              - Business Number: alphanumeric only
...              - ZIP Code: alphanumeric only
...              - IBAN: valid format required
...              - BIC: valid format required
...              Note: Shuttle has only 2 pages (no Languages page)
...              Follows POM structure - uses keywords from validation_page.resource
Resource         ../../../common.resource

*** Variables ***
${INVALID_EMAIL_1}           invalid@
${INVALID_EMAIL_2}           @invalid.com
${INVALID_EMAIL_3}           invalid.email
${SHORT_PASSWORD}            Abc1!
${PASSWORD_NO_SPECIAL}       Abcdef1
${PASSWORD_NO_LOWERCASE}     ABCDE1!
${PASSWORD_NO_UPPERCASE}     abcde1!
${PASSWORD_MISMATCH}         Xyz123!@
${ONE_CHAR}                  A

*** Test Cases ***
### *** First Name Validation ***

Test First Name With One Character Shows Error
    [Documentation]    Verify that 1 character in First Name displays validation error.
    ...                Validation rule: MinLength(2)
    ...                Expected message: "Name must be at least two characters."
    [Tags]    ui    register    shuttle    negative    p1    validation    firstname
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_SH_NAME_INPUT}    ${ONE_CHAR}
    Click Next Button Shuttle
    Verify Register Validation Error Is Visible    ${REGISTER_FIRST_NAME_VALIDATION}    ${MSG_NAME_MIN_LENGTH}
    [Teardown]    Close Browser

### *** Last Name Validation ***

Test Last Name With One Character Shows Error
    [Documentation]    Verify that 1 character in Last Name displays validation error.
    ...                Validation rule: MinLength(2)
    ...                Expected message: "Name must be at least two characters."
    [Tags]    ui    register    shuttle    negative    p1    validation    lastname
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_SH_LAST_NAME_INPUT}    ${ONE_CHAR}
    Click Next Button Shuttle
    Verify Register Validation Error Is Visible    ${REGISTER_LAST_NAME_VALIDATION}    ${MSG_NAME_MIN_LENGTH}
    [Teardown]    Close Browser

### *** Email Validation ***

Test Invalid Email Without Domain Shows Error
    [Documentation]    Verify that email without domain displays validation error.
    ...                Validation rule: Email format
    ...                Expected message: "Invalid email address"
    [Tags]    ui    register    shuttle    negative    p1    validation    email
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_SH_EMAIL_INPUT}    ${INVALID_EMAIL_1}
    Click Next Button Shuttle
    Verify Register Validation Error Is Visible    ${REGISTER_EMAIL_VALIDATION}    ${MSG_EMAIL_INVALID}
    [Teardown]    Close Browser

Test Invalid Email Without At Sign Shows Error
    [Documentation]    Verify that email without @ displays validation error.
    ...                Validation rule: Email format
    [Tags]    ui    register    shuttle    negative    p1    validation    email
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_SH_EMAIL_INPUT}    ${INVALID_EMAIL_3}
    Click Next Button Shuttle
    Verify Register Validation Error Is Visible    ${REGISTER_EMAIL_VALIDATION}    ${MSG_EMAIL_INVALID}
    [Teardown]    Close Browser

### *** Password Validation - Length ***

Test Password With Less Than Six Characters Shows Error
    [Documentation]    Verify that password with less than 6 characters displays validation error.
    ...                Validation rule: MinLength(6)
    ...                Expected message: "Passwords must be at least 6 characters."
    [Tags]    ui    register    shuttle    negative    p1    validation    password
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Fill First Page With Password Shuttle    ${SHORT_PASSWORD}    ${SHORT_PASSWORD}
    Click Next Button Shuttle
    Verify Register Validation Error Is Visible    ${REGISTER_PASSWORD_VALIDATION}    ${MSG_PASSWORD_MIN_LENGTH}
    [Teardown]    Close Browser

### *** Password Validation - No Special Character ***

Test Password Without Special Character Shows Error
    [Documentation]    Verify that password without special character displays validation error.
    ...                Validation rule: Requires non-alphanumeric character
    ...                Expected message: "Passwords must have at least one non alphanumeric character."
    [Tags]    ui    register    shuttle    negative    p1    validation    password
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Fill First Page With Password Shuttle    ${PASSWORD_NO_SPECIAL}    ${PASSWORD_NO_SPECIAL}
    Click Next Button Shuttle
    Verify Register Validation Error Is Visible    ${REGISTER_PASSWORD_VALIDATION}    ${MSG_PASSWORD_NO_SPECIAL}
    [Teardown]    Close Browser

### *** Password Validation - No Lowercase ***

Test Password Without Lowercase Shows Error
    [Documentation]    Verify that password without lowercase letter displays validation error.
    ...                Validation rule: Requires lowercase ('a'-'z')
    ...                Expected message: "Passwords must have at least one lowercase ('a'-'z')."
    [Tags]    ui    register    shuttle    negative    p1    validation    password
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Fill First Page With Password Shuttle    ${PASSWORD_NO_LOWERCASE}    ${PASSWORD_NO_LOWERCASE}
    Click Next Button Shuttle
    Verify Register Validation Error Is Visible    ${REGISTER_PASSWORD_VALIDATION}    ${MSG_PASSWORD_NO_LOWERCASE}
    [Teardown]    Close Browser

### *** Password Validation - No Uppercase ***

Test Password Without Uppercase Shows Error
    [Documentation]    Verify that password without uppercase letter displays validation error.
    ...                Validation rule: Requires uppercase ('A'-'Z')
    ...                Expected message: "Passwords must have at least one uppercase ('A'-'Z')."
    [Tags]    ui    register    shuttle    negative    p1    validation    password
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Fill First Page With Password Shuttle    ${PASSWORD_NO_UPPERCASE}    ${PASSWORD_NO_UPPERCASE}
    Click Next Button Shuttle
    Verify Register Validation Error Is Visible    ${REGISTER_PASSWORD_VALIDATION}    ${MSG_PASSWORD_NO_UPPERCASE}
    [Teardown]    Close Browser

### *** Confirm Password Validation ***

Test Confirm Password Mismatch Shows Error
    [Documentation]    Verify that mismatched Confirm Password displays validation error.
    ...                Validation rule: Must match Password
    ...                Expected message: "'ConfirmPassword' and 'Password' do not match."
    [Tags]    ui    register    shuttle    negative    p1    validation    password
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_SH_PASSWORD_INPUT}    TestPassword1!
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_SH_CONFIRMED_PASSWORD_INPUT}    ${PASSWORD_MISMATCH}
    Click Next Button Shuttle
    Verify Register Validation Error Is Visible    ${REGISTER_CONFIRM_PASSWORD_VALIDATION}    ${MSG_PASSWORD_MISMATCH}
    [Teardown]    Close Browser

### *** Business Number Validation (Page 2 - Business Details) ***

Test Business Number With Special Characters Shows Error
    [Documentation]    Verify that Business Number with special characters displays validation error.
    ...                Validation rule: Alphanumeric only (A-Z, 0-9)
    ...                Expected message: "Input can only contain letters (A-Z) and numbers (0-9)."
    [Tags]    ui    register    shuttle    negative    p1    validation    business
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Navigate To Second Page Shuttle
    Select Options By    ${THIRD_PAGE_REGISTER_SH_COUNTRY_DROPDOWN}    label    Czech Republic
    Clear And Fill Registration Field    ${THIRD_PAGE_REGISTER_SH_BUSINESS_NUMBER_INPUT}    ABC-123!
    Click Finish Button Shuttle
    Verify Register Validation Error Is Visible    ${REGISTER_BUSINESS_NUMBER_VALIDATION}    ${MSG_ALPHANUMERIC_ONLY}
    [Teardown]    Close Browser

### *** ZIP Code Validation (Page 2) ***

Test Zip Code With Special Characters Shows Error
    [Documentation]    Verify that ZIP Code with special characters displays validation error.
    ...                Validation rule: Alphanumeric only (A-Z, 0-9)
    ...                Expected message: "Input can only contain letters (A-Z) and numbers (0-9)."
    [Tags]    ui    register    shuttle    negative    p1    validation    zipcode
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Navigate To Second Page Shuttle
    Select Options By    ${THIRD_PAGE_REGISTER_SH_COUNTRY_DROPDOWN}    label    Czech Republic
    Clear And Fill Registration Field    ${THIRD_PAGE_REGISTER_SH_ZIP_CODE_INPUT}    123-45@
    Click Finish Button Shuttle
    Verify Register Validation Error Is Visible    ${REGISTER_ZIP_CODE_VALIDATION}    ${MSG_ALPHANUMERIC_ONLY}
    [Teardown]    Close Browser

### *** IBAN Validation (Page 2) ***

Test Invalid IBAN Shows Error
    [Documentation]    Verify that invalid IBAN displays validation error.
    ...                Validation rule: Valid IBAN format
    ...                Expected message: "IBAN is not valid."
    [Tags]    ui    register    shuttle    negative    p1    validation    iban
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Navigate To Second Page Shuttle
    Select Options By    ${THIRD_PAGE_REGISTER_SH_COUNTRY_DROPDOWN}    label    Czech Republic
    Clear And Fill Registration Field    ${THIRD_PAGE_REGISTER_SH_IBAN_INPUT}    INVALID_IBAN
    Click Finish Button Shuttle
    Verify Register Validation Error Is Visible    ${REGISTER_IBAN_VALIDATION}    ${MSG_IBAN_INVALID}
    [Teardown]    Close Browser

### *** BIC Validation (Page 2) ***

Test Invalid BIC Shows Error
    [Documentation]    Verify that invalid BIC displays validation error.
    ...                Validation rule: Valid BIC format
    ...                Expected message: "BIC is not valid."
    [Tags]    ui    register    shuttle    negative    p1    validation    bic
    [Setup]    Open Browser And Navigate To Shuttle Registration Form
    Navigate To Second Page Shuttle
    Select Options By    ${THIRD_PAGE_REGISTER_SH_COUNTRY_DROPDOWN}    label    Czech Republic
    Clear And Fill Registration Field    ${THIRD_PAGE_REGISTER_SH_BIC_INPUT}    INVALID_BIC
    Click Finish Button Shuttle
    Verify Register Validation Error Is Visible    ${REGISTER_BIC_VALIDATION}    ${MSG_BIC_INVALID}
    [Teardown]    Close Browser

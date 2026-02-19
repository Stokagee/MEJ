*** Settings ***
Documentation    Negative tests for Driver registration form validation.
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
    [Tags]    ui    register    driver    negative    p1    validation    firstname
    [Setup]    Open Browser And Navigate To Registration Form
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_DRIVER_NAME_INPUT}    ${ONE_CHAR}
    Click Next Button Driver
    Verify Register Validation Error Is Visible    ${REGISTER_FIRST_NAME_VALIDATION}    ${MSG_NAME_MIN_LENGTH}
    [Teardown]    Close Browser

### *** Last Name Validation ***

Test Last Name With One Character Shows Error
    [Documentation]    Verify that 1 character in Last Name displays validation error.
    ...                Validation rule: MinLength(2)
    ...                Expected message: "Name must be at least two characters."
    [Tags]    ui    register    driver    negative    p1    validation    lastname
    [Setup]    Open Browser And Navigate To Registration Form
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_DRIVER_LAST_NAME_INPUT}    ${ONE_CHAR}
    Click Next Button Driver
    Verify Register Validation Error Is Visible    ${REGISTER_LAST_NAME_VALIDATION}    ${MSG_NAME_MIN_LENGTH}
    [Teardown]    Close Browser

### *** Email Validation ***

Test Invalid Email Without Domain Shows Error
    [Documentation]    Verify that email without domain displays validation error.
    ...                Validation rule: Email format
    ...                Expected message: "Invalid email address"
    [Tags]    ui    register    driver    negative    p1    validation    email
    [Setup]    Open Browser And Navigate To Registration Form
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_DRIVER_EMAIL_INPUT}    ${INVALID_EMAIL_1}
    Click Next Button Driver
    Verify Register Validation Error Is Visible    ${REGISTER_EMAIL_VALIDATION}    ${MSG_EMAIL_INVALID}
    [Teardown]    Close Browser

Test Invalid Email Without Username Shows Error
    [Documentation]    Verify that email without username displays validation error.
    ...                Validation rule: Email format
    [Tags]    ui    register    driver    negative    p1    validation    email
    [Setup]    Open Browser And Navigate To Registration Form
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_DRIVER_EMAIL_INPUT}    ${INVALID_EMAIL_2}
    Click Next Button Driver
    Verify Register Validation Error Is Visible    ${REGISTER_EMAIL_VALIDATION}    ${MSG_EMAIL_INVALID}
    [Teardown]    Close Browser

Test Invalid Email Without At Sign Shows Error
    [Documentation]    Verify that email without @ displays validation error.
    ...                Validation rule: Email format
    [Tags]    ui    register    driver    negative    p1    validation    email
    [Setup]    Open Browser And Navigate To Registration Form
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_DRIVER_EMAIL_INPUT}    ${INVALID_EMAIL_3}
    Click Next Button Driver
    Verify Register Validation Error Is Visible    ${REGISTER_EMAIL_VALIDATION}    ${MSG_EMAIL_INVALID}
    [Teardown]    Close Browser

### *** Password Validation - Length ***

Test Password With Less Than Six Characters Shows Error
    [Documentation]    Verify that password with less than 6 characters displays validation error.
    ...                Validation rule: MinLength(6)
    ...                Expected message: "Passwords must be at least 6 characters."
    [Tags]    ui    register    driver    negative    p1    validation    password
    [Setup]    Open Browser And Navigate To Registration Form
    Fill First Page With Password Driver    ${SHORT_PASSWORD}    ${SHORT_PASSWORD}
    Click Next Button Driver
    Verify Register Validation Error Is Visible    ${REGISTER_PASSWORD_VALIDATION}    ${MSG_PASSWORD_MIN_LENGTH}
    [Teardown]    Close Browser

### *** Password Validation - No Special Character ***

Test Password Without Special Character Shows Error
    [Documentation]    Verify that password without special character displays validation error.
    ...                Validation rule: Requires non-alphanumeric character
    ...                Expected message: "Passwords must have at least one non alphanumeric character."
    [Tags]    ui    register    driver    negative    p1    validation    password
    [Setup]    Open Browser And Navigate To Registration Form
    Fill First Page With Password Driver    ${PASSWORD_NO_SPECIAL}    ${PASSWORD_NO_SPECIAL}
    Click Next Button Driver
    Verify Register Validation Error Is Visible    ${REGISTER_PASSWORD_VALIDATION}    ${MSG_PASSWORD_NO_SPECIAL}
    [Teardown]    Close Browser

### *** Password Validation - No Lowercase ***

Test Password Without Lowercase Shows Error
    [Documentation]    Verify that password without lowercase letter displays validation error.
    ...                Validation rule: Requires lowercase ('a'-'z')
    ...                Expected message: "Passwords must have at least one lowercase ('a'-'z')."
    [Tags]    ui    register    driver    negative    p1    validation    password
    [Setup]    Open Browser And Navigate To Registration Form
    Fill First Page With Password Driver    ${PASSWORD_NO_LOWERCASE}    ${PASSWORD_NO_LOWERCASE}
    Click Next Button Driver
    Verify Register Validation Error Is Visible    ${REGISTER_PASSWORD_VALIDATION}    ${MSG_PASSWORD_NO_LOWERCASE}
    [Teardown]    Close Browser

### *** Password Validation - No Uppercase ***

Test Password Without Uppercase Shows Error
    [Documentation]    Verify that password without uppercase letter displays validation error.
    ...                Validation rule: Requires uppercase ('A'-'Z')
    ...                Expected message: "Passwords must have at least one uppercase ('A'-'Z')."
    [Tags]    ui    register    driver    negative    p1    validation    password
    [Setup]    Open Browser And Navigate To Registration Form
    Fill First Page With Password Driver    ${PASSWORD_NO_UPPERCASE}    ${PASSWORD_NO_UPPERCASE}
    Click Next Button Driver
    Verify Register Validation Error Is Visible    ${REGISTER_PASSWORD_VALIDATION}    ${MSG_PASSWORD_NO_UPPERCASE}
    [Teardown]    Close Browser

### *** Confirm Password Validation ***

Test Confirm Password Mismatch Shows Error
    [Documentation]    Verify that mismatched Confirm Password displays validation error.
    ...                Validation rule: Must match Password
    ...                Expected message: "'ConfirmPassword' and 'Password' do not match."
    [Tags]    ui    register    driver    negative    p1    validation    password
    [Setup]    Open Browser And Navigate To Registration Form
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_DRIVER_PASSWORD_INPUT}    TestPassword1!
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_DRIVER_CONFIRMED_PASSWORD_INPUT}    ${PASSWORD_MISMATCH}
    Click Next Button Driver
    Verify Register Validation Error Is Visible    ${REGISTER_CONFIRM_PASSWORD_VALIDATION}    ${MSG_PASSWORD_MISMATCH}
    [Teardown]    Close Browser

### *** Terms of Use Validation ***

Test Terms Of Use Not Checked Prevents Navigation
    [Documentation]    Verify that registration cannot proceed without accepting Terms of Use.
    ...                Validation rule: Required checkbox
    [Tags]    ui    register    driver    negative    p1    validation    terms
    [Setup]    Open Browser And Navigate To Registration Form
    Fill Text    ${FIRST_PAGE_REGISTER_DRIVER_NAME_INPUT}    John
    Fill Text    ${FIRST_PAGE_REGISTER_DRIVER_LAST_NAME_INPUT}    Doe
    Select Options By    ${FIRST_PAGE_REGISTER_DRIVER_DIAL_DROPDOWN}    label    +420
    Fill Text    xpath=//label[contains(text(), "Phone")]/preceding-sibling::input    123456789
    Fill Text    ${FIRST_PAGE_REGISTER_DRIVER_EMAIL_INPUT}    test@example.com
    Fill Text    ${FIRST_PAGE_REGISTER_DRIVER_PASSWORD_INPUT}    TestPassword1!
    Fill Text    ${FIRST_PAGE_REGISTER_DRIVER_CONFIRMED_PASSWORD_INPUT}    TestPassword1!
    # Terms checkbox is NOT checked
    Click Next Button Driver
    # Verify we are still on the first page (Next button still visible)
    ${state}=    Get Element States    ${FIRST_PAGE_REGISTER_DRIVER_NEXT_BUTTON}
    Should Contain    ${state}    visible    Should still be on first page when Terms not accepted
    [Teardown]    Close Browser

### *** About Me MaxLength (Page 2) ***

Test About Me MaxLength Truncation
    [Documentation]    Verify that About Me text is truncated to 2000 characters.
    ...                Validation rule: MaxLength(2000) - input is truncated
    [Tags]    ui    register    driver    negative    p1    validation    aboutme
    [Setup]    Open Browser And Navigate To Registration Form
    Navigate To Second Page Driver
    Fill Register Field With Generated Text    ${SECOND_PAGE_REGISTER_DRIVER_ABOUT_ME_INPUT}    2100
    Verify Register Field MaxLength Truncation    ${SECOND_PAGE_REGISTER_DRIVER_ABOUT_ME_INPUT}    2000
    [Teardown]    Close Browser

### *** Business Number Validation (Page 3) ***

Test Business Number With Special Characters Shows Error
    [Documentation]    Verify that Business Number with special characters displays validation error.
    ...                Validation rule: Alphanumeric only (A-Z, 0-9)
    ...                Expected message: "Input can only contain letters (A-Z) and numbers (0-9)."
    [Tags]    ui    register    driver    negative    p1    validation    business
    [Setup]    Open Browser And Navigate To Registration Form
    Navigate To Third Page Driver
    Select Options By    ${THIRD_PAGE_REGISTER_DRIVER_COUNTRY_DROPDOWN}    label    Czech Republic
    Clear And Fill Registration Field    ${THIRD_PAGE_REGISTER_DRIVER_BUSINESS_NUMBER_INPUT}    ABC-123!
    Click Finish Button Driver
    Verify Register Validation Error Is Visible    ${REGISTER_BUSINESS_NUMBER_VALIDATION}    ${MSG_ALPHANUMERIC_ONLY}
    [Teardown]    Close Browser

### *** ZIP Code Validation (Page 3) ***

Test Zip Code With Special Characters Shows Error
    [Documentation]    Verify that ZIP Code with special characters displays validation error.
    ...                Validation rule: Alphanumeric only (A-Z, 0-9)
    ...                Expected message: "Input can only contain letters (A-Z) and numbers (0-9)."
    [Tags]    ui    register    driver    negative    p1    validation    zipcode
    [Setup]    Open Browser And Navigate To Registration Form
    Navigate To Third Page Driver
    Select Options By    ${THIRD_PAGE_REGISTER_DRIVER_COUNTRY_DROPDOWN}    label    Czech Republic
    Clear And Fill Registration Field    ${THIRD_PAGE_REGISTER_DRIVER_ZIP_CODE_INPUT}    123-45@
    Click Finish Button Driver
    Verify Register Validation Error Is Visible    ${REGISTER_ZIP_CODE_VALIDATION}    ${MSG_ALPHANUMERIC_ONLY}
    [Teardown]    Close Browser

### *** IBAN Validation (Page 3) ***

Test Invalid IBAN Shows Error
    [Documentation]    Verify that invalid IBAN displays validation error.
    ...                Validation rule: Valid IBAN format
    ...                Expected message: "IBAN is not valid."
    [Tags]    ui    register    driver    negative    p1    validation    iban
    [Setup]    Open Browser And Navigate To Registration Form
    Navigate To Third Page Driver
    Select Options By    ${THIRD_PAGE_REGISTER_DRIVER_COUNTRY_DROPDOWN}    label    Czech Republic
    Clear And Fill Registration Field    ${THIRD_PAGE_REGISTER_DRIVER_IBAN_INPUT}    INVALID_IBAN
    Click Finish Button Driver
    Verify Register Validation Error Is Visible    ${REGISTER_IBAN_VALIDATION}    ${MSG_IBAN_INVALID}
    [Teardown]    Close Browser

### *** BIC Validation (Page 3) ***

Test Invalid BIC Shows Error
    [Documentation]    Verify that invalid BIC displays validation error.
    ...                Validation rule: Valid BIC format
    ...                Expected message: "BIC is not valid."
    [Tags]    ui    register    driver    negative    p1    validation    bic
    [Setup]    Open Browser And Navigate To Registration Form
    Navigate To Third Page Driver
    Select Options By    ${THIRD_PAGE_REGISTER_DRIVER_COUNTRY_DROPDOWN}    label    Czech Republic
    Clear And Fill Registration Field    ${THIRD_PAGE_REGISTER_DRIVER_BIC_INPUT}    INVALID_BIC
    Click Finish Button Driver
    Verify Register Validation Error Is Visible    ${REGISTER_BIC_VALIDATION}    ${MSG_BIC_INVALID}
    [Teardown]    Close Browser

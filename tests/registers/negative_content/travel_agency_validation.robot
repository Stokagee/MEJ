*** Settings ***
Documentation    Negative tests for Travel Agency/Hotel registration form validation.
...              Tests validation messages for invalid inputs:
...              - First Name: min 2 characters
...              - Last Name: min 2 characters
...              - Email: valid format required
...              - Password: min 6 chars, requires lowercase, uppercase, special char
...              - Confirm Password: must match Password
...              - Terms of Use: must be checked
...              Note: Travel Agency has only 1 page (no Languages or Business pages)
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
    [Tags]    ui    register    travelagency    negative    p1    validation    firstname
    [Setup]    Open Browser And Navigate To Travel Agency Registration Form
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_TA_NAME_INPUT}    ${ONE_CHAR}
    Click Submit Button Travel Agency
    Verify Register Validation Error Is Visible    ${REGISTER_FIRST_NAME_VALIDATION}    ${MSG_NAME_MIN_LENGTH}
    [Teardown]    Close Browser

### *** Last Name Validation ***

Test Last Name With One Character Shows Error
    [Documentation]    Verify that 1 character in Last Name displays validation error.
    ...                Validation rule: MinLength(2)
    ...                Expected message: "Name must be at least two characters."
    [Tags]    ui    register    travelagency    negative    p1    validation    lastname
    [Setup]    Open Browser And Navigate To Travel Agency Registration Form
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_TA_LAST_NAME_INPUT}    ${ONE_CHAR}
    Click Submit Button Travel Agency
    Verify Register Validation Error Is Visible    ${REGISTER_LAST_NAME_VALIDATION}    ${MSG_NAME_MIN_LENGTH}
    [Teardown]    Close Browser

### *** Email Validation ***

Test Invalid Email Without Domain Shows Error
    [Documentation]    Verify that email without domain displays validation error.
    ...                Validation rule: Email format
    ...                Expected message: "Invalid email address"
    [Tags]    ui    register    travelagency    negative    p1    validation    email
    [Setup]    Open Browser And Navigate To Travel Agency Registration Form
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_TA_EMAIL_INPUT}    ${INVALID_EMAIL_1}
    Click Submit Button Travel Agency
    Verify Register Validation Error Is Visible    ${REGISTER_EMAIL_VALIDATION}    ${MSG_EMAIL_INVALID}
    [Teardown]    Close Browser

Test Invalid Email Without At Sign Shows Error
    [Documentation]    Verify that email without @ displays validation error.
    ...                Validation rule: Email format
    [Tags]    ui    register    travelagency    negative    p1    validation    email
    [Setup]    Open Browser And Navigate To Travel Agency Registration Form
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_TA_EMAIL_INPUT}    ${INVALID_EMAIL_3}
    Click Submit Button Travel Agency
    Verify Register Validation Error Is Visible    ${REGISTER_EMAIL_VALIDATION}    ${MSG_EMAIL_INVALID}
    [Teardown]    Close Browser

### *** Password Validation - Length ***

Test Password With Less Than Six Characters Shows Error
    [Documentation]    Verify that password with less than 6 characters displays validation error.
    ...                Validation rule: MinLength(6)
    ...                Expected message: "Passwords must be at least 6 characters."
    [Tags]    ui    register    travelagency    negative    p1    validation    password
    [Setup]    Open Browser And Navigate To Travel Agency Registration Form
    Fill First Page With Password Travel Agency    ${SHORT_PASSWORD}    ${SHORT_PASSWORD}
    Click Submit Button Travel Agency
    Verify Register Validation Error Is Visible    ${REGISTER_PASSWORD_VALIDATION}    ${MSG_PASSWORD_MIN_LENGTH}
    [Teardown]    Close Browser

### *** Password Validation - No Special Character ***

Test Password Without Special Character Shows Error
    [Documentation]    Verify that password without special character displays validation error.
    ...                Validation rule: Requires non-alphanumeric character
    ...                Expected message: "Passwords must have at least one non alphanumeric character."
    [Tags]    ui    register    travelagency    negative    p1    validation    password
    [Setup]    Open Browser And Navigate To Travel Agency Registration Form
    Fill First Page With Password Travel Agency    ${PASSWORD_NO_SPECIAL}    ${PASSWORD_NO_SPECIAL}
    Click Submit Button Travel Agency
    Verify Register Validation Error Is Visible    ${REGISTER_PASSWORD_VALIDATION}    ${MSG_PASSWORD_NO_SPECIAL}
    [Teardown]    Close Browser

### *** Password Validation - No Lowercase ***

Test Password Without Lowercase Shows Error
    [Documentation]    Verify that password without lowercase letter displays validation error.
    ...                Validation rule: Requires lowercase ('a'-'z')
    ...                Expected message: "Passwords must have at least one lowercase ('a'-'z')."
    [Tags]    ui    register    travelagency    negative    p1    validation    password
    [Setup]    Open Browser And Navigate To Travel Agency Registration Form
    Fill First Page With Password Travel Agency    ${PASSWORD_NO_LOWERCASE}    ${PASSWORD_NO_LOWERCASE}
    Click Submit Button Travel Agency
    Verify Register Validation Error Is Visible    ${REGISTER_PASSWORD_VALIDATION}    ${MSG_PASSWORD_NO_LOWERCASE}
    [Teardown]    Close Browser

### *** Password Validation - No Uppercase ***

Test Password Without Uppercase Shows Error
    [Documentation]    Verify that password without uppercase letter displays validation error.
    ...                Validation rule: Requires uppercase ('A'-'Z')
    ...                Expected message: "Passwords must have at least one uppercase ('A'-'Z')."
    [Tags]    ui    register    travelagency    negative    p1    validation    password
    [Setup]    Open Browser And Navigate To Travel Agency Registration Form
    Fill First Page With Password Travel Agency    ${PASSWORD_NO_UPPERCASE}    ${PASSWORD_NO_UPPERCASE}
    Click Submit Button Travel Agency
    Verify Register Validation Error Is Visible    ${REGISTER_PASSWORD_VALIDATION}    ${MSG_PASSWORD_NO_UPPERCASE}
    [Teardown]    Close Browser

### *** Confirm Password Validation ***

Test Confirm Password Mismatch Shows Error
    [Documentation]    Verify that mismatched Confirm Password displays validation error.
    ...                Validation rule: Must match Password
    ...                Expected message: "'ConfirmPassword' and 'Password' do not match."
    [Tags]    ui    register    travelagency    negative    p1    validation    password
    [Setup]    Open Browser And Navigate To Travel Agency Registration Form
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_TA_PASSWORD_INPUT}    TestPassword1!
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_TA_CONFIRMED_PASSWORD_INPUT}    ${PASSWORD_MISMATCH}
    Click Submit Button Travel Agency
    Verify Register Validation Error Is Visible    ${REGISTER_CONFIRM_PASSWORD_VALIDATION}    ${MSG_PASSWORD_MISMATCH}
    [Teardown]    Close Browser

### *** Terms of Use Validation ***

Test Terms Of Use Not Checked Prevents Navigation
    [Documentation]    Verify that registration cannot proceed without accepting Terms of Use.
    ...                Validation rule: Required checkbox
    [Tags]    ui    register    travelagency    negative    p1    validation    terms
    [Setup]    Open Browser And Navigate To Travel Agency Registration Form
    Fill Text    ${FIRST_PAGE_REGISTER_TA_NAME_INPUT}    John
    Fill Text    ${FIRST_PAGE_REGISTER_TA_LAST_NAME_INPUT}    Doe
    Select Options By    ${FIRST_PAGE_REGISTER_TA_DIAL_DROPDOWN}    label    +420
    Fill Text    xpath=//label[contains(text(), "Phone")]/preceding-sibling::input    123456789
    Fill Text    ${FIRST_PAGE_REGISTER_TA_EMAIL_INPUT}    test@example.com
    Fill Text    ${FIRST_PAGE_REGISTER_TA_PASSWORD_INPUT}    TestPassword1!
    Fill Text    ${FIRST_PAGE_REGISTER_TA_CONFIRMED_PASSWORD_INPUT}    TestPassword1!
    # Terms checkbox is NOT checked
    Click Submit Button Travel Agency
    # Verify we are still on the first page (Submit button still visible)
    ${state}=    Get Element States    ${FIRST_PAGE_REGISTER_TA_SUBMIT_BUTTON}
    Should Contain    ${state}    visible    Should still be on first page when Terms not accepted
    [Teardown]    Close Browser

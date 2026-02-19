*** Settings ***
Documentation    Positive tests for Travel Agency/Hotel registration form validation.
...              Tests maxlength truncation:
...              - First Name: max 128 characters
...              - Last Name: max 128 characters
...              - Phone: max 15 characters
...              - Email: max 256 characters
...              Note: Travel Agency has only 1 page (no Languages or Business pages)
...              Follows POM structure - uses keywords from validation_page.resource
Resource         ../../../common.resource

*** Test Cases ***
### *** First Name MaxLength ***

Test First Name MaxLength Truncation
    [Documentation]    Verify that First Name is truncated to 128 characters.
    ...                Validation rule: MaxLength(128)
    [Tags]    ui    register    travelagency    positive    p1    validation    maxlength    firstname
    [Setup]    Open Browser And Navigate To Travel Agency Registration Form
    Fill Register Field With Generated Text    ${FIRST_PAGE_REGISTER_TA_NAME_INPUT}    150
    Verify Register Field MaxLength Truncation    ${FIRST_PAGE_REGISTER_TA_NAME_INPUT}    128
    [Teardown]    Close Browser

### *** Last Name MaxLength ***

Test Last Name MaxLength Truncation
    [Documentation]    Verify that Last Name is truncated to 128 characters.
    ...                Validation rule: MaxLength(128)
    [Tags]    ui    register    travelagency    positive    p1    validation    maxlength    lastname
    [Setup]    Open Browser And Navigate To Travel Agency Registration Form
    Fill Register Field With Generated Text    ${FIRST_PAGE_REGISTER_TA_LAST_NAME_INPUT}    150
    Verify Register Field MaxLength Truncation    ${FIRST_PAGE_REGISTER_TA_LAST_NAME_INPUT}    128
    [Teardown]    Close Browser

### *** Phone MaxLength ***

Test Phone MaxLength Truncation
    [Documentation]    Verify that Phone is truncated to 15 characters.
    ...                Validation rule: MaxLength(15)
    [Tags]    ui    register    travelagency    positive    p1    validation    maxlength    phone
    [Setup]    Open Browser And Navigate To Travel Agency Registration Form
    Fill Register Field With Generated Text    xpath=//label[contains(text(), "Phone")]/preceding-sibling::input    20
    Verify Register Field MaxLength Truncation    xpath=//label[contains(text(), "Phone")]/preceding-sibling::input    15
    [Teardown]    Close Browser

### *** Email MaxLength ***

Test Email MaxLength Truncation
    [Documentation]    Verify that Email is truncated to 256 characters.
    ...                Validation rule: MaxLength(256)
    [Tags]    ui    register    travelagency    positive    p1    validation    maxlength    email
    [Setup]    Open Browser And Navigate To Travel Agency Registration Form
    ${long_email}=    Generate Random String    250    [LETTERS]
    ${long_email}=    Catenate    ${long_email}@test.com
    Clear And Fill Registration Field    ${FIRST_PAGE_REGISTER_TA_EMAIL_INPUT}    ${long_email}
    Verify Register Field MaxLength Truncation    ${FIRST_PAGE_REGISTER_TA_EMAIL_INPUT}    256
    [Teardown]    Close Browser

### *** Valid Data Test ***

Test Valid Data Passes Without Errors
    [Documentation]    Verify that valid registration data passes without validation errors.
    ...                Complete form with valid data and verify success message.
    [Tags]    ui    register    travelagency    positive    p1    validation    valid
    [Setup]    Open Browser And Navigate To Travel Agency Registration Form
    ${first_name}=    FakerLibrary.First Name
    ${last_name}=    FakerLibrary.Last Name
    ${email}=    FakerLibrary.Email
    ${password}=    Set Variable    TestPassword1!
    Log Data    First Name    ${first_name}
    Log Data    Last Name    ${last_name}
    Log Data    Email    ${email}
    Fill Text    ${FIRST_PAGE_REGISTER_TA_NAME_INPUT}    ${first_name}
    Fill Text    ${FIRST_PAGE_REGISTER_TA_LAST_NAME_INPUT}    ${last_name}
    Select Options By    ${FIRST_PAGE_REGISTER_TA_DIAL_DROPDOWN}    label    +420
    Fill Text    xpath=//label[contains(text(), "Phone")]/preceding-sibling::input    123456789
    Fill Text    ${FIRST_PAGE_REGISTER_TA_EMAIL_INPUT}    ${email}
    Fill Text    ${FIRST_PAGE_REGISTER_TA_PASSWORD_INPUT}    ${password}
    Fill Text    ${FIRST_PAGE_REGISTER_TA_CONFIRMED_PASSWORD_INPUT}    ${password}
    ${checkbox}=    Get Element    ${FIRST_PAGE_REGISTER_TA_TERMS_OF_USE_CHECKBOX}
    Click    ${checkbox}
    Click Submit Button Travel Agency
    # Verify success message
    Wait Element State    ${REGISTER_TA_FINISH_PAGE_EMAIL_TEXTAREA}
    ${message}=    Get Text    ${REGISTER_TA_FINISH_PAGE_EMAIL_TEXTAREA}
    Should Contain    ${message}    ${REGISTER_TA_FINISH_PAGE_EMAIL_TEXT_FOR_VERIFY}
    Log Verification    Registration completed successfully
    [Teardown]    Close Browser

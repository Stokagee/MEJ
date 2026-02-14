*** Settings ***
Documentation    Negative tests for validating Journey form.
...              Tests empty required fields, exceeding maximum length and invalid formats.
...              Follows POM structure - uses keywords from validation_page.resource
Resource         ../../common.resource

*** Variables ***
${INVALID_EMAIL_1}           invalid@
${INVALID_EMAIL_2}           @invalid.com
${INVALID_EMAIL_3}           invalid.email

*** Test Cases ***
### *** Passengers Count Validation ***

Test Empty Passengers Count Shows Error
    [Documentation]    Verify that empty passengers count displays validation error.
    ...                Validation rule: Range(1, int.MaxValue)
    [Tags]    ui    journey    negative    p1    validation    passengers
    [Setup]    Open Browser And Navigate To Journey Form
    Clear And Fill Field    ${JOURNEYS_FORM_REQUEST_PASSENGERS_INPUT}    ${EMPTY}
    Verify Validation Error Is Visible    ${PASSENGERS_COUNT_VALIDATION}
    [Teardown]    Close Browser

Test Zero Passengers Count Shows Error
    [Documentation]    Verify that 0 passengers displays validation error.
    ...                Validation rule: Range(1, int.MaxValue) - minimum 1
    [Tags]    ui    journey    negative    p1    validation    passengers
    [Setup]    Open Browser And Navigate To Journey Form
    Clear And Fill Field    ${JOURNEYS_FORM_REQUEST_PASSENGERS_INPUT}    0
    Verify Validation Error Is Visible    ${PASSENGERS_COUNT_VALIDATION}
    [Teardown]    Close Browser

Test Negative Passengers Count Shows Error
    [Documentation]    Verify that negative passengers count displays validation error.
    [Tags]    ui    journey    negative    p1    validation    passengers
    [Setup]    Open Browser And Navigate To Journey Form
    Clear And Fill Field    ${JOURNEYS_FORM_REQUEST_PASSENGERS_INPUT}    -1
    Verify Validation Error Is Visible    ${PASSENGERS_COUNT_VALIDATION}
    [Teardown]    Close Browser

### *** Notes Validation ***

Test Too Long Note For Driver Shows Error
    [Documentation]    Verify that too long note for driver (>2000 characters) displays error.
    ...                Validation rule: StringLength(2000)
    [Tags]    ui    journey    negative    p1    validation    notes
    [Setup]    Open Browser And Navigate To Journey Form
    Fill Field With Generated Text    ${JOURNEYS_FORM_REQUEST_DRIVER_NOTE_INPUT}    2001
    Click Save And Trigger Validation
    Verify Validation Error Is Visible    ${NOTE_DRIVER_VALIDATION}
    [Teardown]    Close Browser

Test Too Long Note For Operator Shows Error
    [Documentation]    Verify that too long note for operator (>2000 characters) displays error.
    ...                Validation rule: StringLength(2000)
    [Tags]    ui    journey    negative    p1    validation    notes
    [Setup]    Open Browser And Navigate To Journey Form
    Fill Field With Generated Text    ${JOURNEYS_FORM_REQUEST_OPERATOR_NOTE_INPUT}    2001
    Click Save And Trigger Validation
    Verify Validation Error Is Visible    ${NOTE_OPERATOR_VALIDATION}
    [Teardown]    Close Browser

### *** Passenger Contact - Email Validation ***

Test Invalid Email Format Without Domain Shows Error
    [Documentation]    Verify that email without domain displays validation error.
    ...                Validation rule: CustomEmail
    [Tags]    ui    journey    negative    p1    validation    email
    [Setup]    Open Browser And Navigate To Journey Form
    Clear And Fill Field    ${JOURNEYS_FORM_REQUEST_PASSENGERS_EMAIL_INPUT}    ${INVALID_EMAIL_1}
    Verify Validation Error Is Visible    ${EMAIL_VALIDATION}
    [Teardown]    Close Browser

Test Invalid Email Format Without Username Shows Error
    [Documentation]    Verify that email without username displays error.
    [Tags]    ui    journey    negative    p1    validation    email
    [Setup]    Open Browser And Navigate To Journey Form
    Clear And Fill Field    ${JOURNEYS_FORM_REQUEST_PASSENGERS_EMAIL_INPUT}    ${INVALID_EMAIL_2}
    Verify Validation Error Is Visible    ${EMAIL_VALIDATION}
    [Teardown]    Close Browser

Test Invalid Email Format Without At Sign Shows Error
    [Documentation]    Verify that email without @ displays validation error.
    [Tags]    ui    journey    negative    p1    validation    email
    [Setup]    Open Browser And Navigate To Journey Form
    Clear And Fill Field    ${JOURNEYS_FORM_REQUEST_PASSENGERS_EMAIL_INPUT}    ${INVALID_EMAIL_3}
    Verify Validation Error Is Visible    ${EMAIL_VALIDATION}
    [Teardown]    Close Browser

### *** Passenger Contact - Required Fields ***

Test Empty First Name Shows Error
    [Documentation]    Verify that empty passenger first name displays validation error.
    ...                Validation rule: Required
    [Tags]    ui    journey    negative    p1    validation    required
    [Setup]    Open Browser And Navigate To Journey Form
    Clear And Fill Field    ${JOURNEYS_FORM_REQUEST_PASSENGERS_FIRST_NAME_INPUT}    ${EMPTY}
    Click Save And Trigger Validation
    Verify Validation Error Is Visible    ${FIRST_NAME_VALIDATION}
    [Teardown]    Close Browser

Test Empty Last Name Shows Error
    [Documentation]    Verify that empty passenger last name displays validation error.
    ...                Validation rule: Required
    [Tags]    ui    journey    negative    p1    validation    required
    [Setup]    Open Browser And Navigate To Journey Form
    Clear And Fill Field    ${JOURNEYS_FORM_REQUEST_PASSENGERS_LAST_NAME_INPUT}    ${EMPTY}
    Click Save And Trigger Validation
    Verify Validation Error Is Visible    ${LAST_NAME_VALIDATION}
    [Teardown]    Close Browser

Test Empty Phone Shows Error
    [Documentation]    Verify that empty passenger phone displays validation error.
    ...                Validation rule: Required
    [Tags]    ui    journey    negative    p1    validation    required
    [Setup]    Open Browser And Navigate To Journey Form
    Clear And Fill Field    ${JOURNEYS_FORM_REQUEST_PASSENGERS_PHONE_INPUT}    ${EMPTY}
    Click Save And Trigger Validation
    Verify Validation Error Is Visible    ${PHONE_VALIDATION}
    [Teardown]    Close Browser

### *** Passenger Contact - Max Length ***

Test Too Long Phone Number Shows Error
    [Documentation]    Verify that too long phone number (>64 characters) displays error.
    ...                Validation rule: MaxLength(64)
    [Tags]    ui    journey    negative    p1    validation    phone
    [Setup]    Open Browser And Navigate To Journey Form
    Fill Field With Generated Text    ${JOURNEYS_FORM_REQUEST_PASSENGERS_PHONE_INPUT}    65
    Click Save And Trigger Validation
    Verify Validation Error Is Visible    ${PHONE_VALIDATION}
    [Teardown]    Close Browser

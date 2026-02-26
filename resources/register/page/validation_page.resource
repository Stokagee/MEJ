*** Settings ***
Documentation    Page object for registration form validation - shared keywords for negative and positive tests
Resource         ../../../common.resource
Resource         ../locators/main_page_locators.resource
Resource         ../locators/validation_locators.resource
Resource         driver_page.resource
Resource         shuttle_page.resource
Resource         travel_agency_page.resource

*** Keywords ***
# === SETUP/TEARDOWN KEYWORDS ===

Open Browser And Navigate To Registration Form
    [Documentation]    Opens browser and navigates to registration form (Driver role by default)
    Log Workflow Start    Navigate to Registration Form
    Initialize Browser Session    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}
    Log Action    Navigating to Sign Up page
    Click    ${MAIN_REGISTER_BUTTON}
    Wait Element State    ${SIGN_UP_DRIVER_CHECKBOX}
    Log Action    Selecting Driver role
    Click    ${SIGN_UP_DRIVER_CHECKBOX}
    Click    ${SIGN_UP_SELECT_BUTTON}
    Wait Element State    ${FIRST_PAGE_REGISTER_DRIVER_NAME_INPUT}
    Log Workflow End    Navigate to Registration Form

Open Browser And Navigate To Shuttle Registration Form
    [Documentation]    Opens browser and navigates to Shuttle Company registration form
    Log Workflow Start    Navigate to Shuttle Registration Form
    Initialize Browser Session    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}
    Log Action    Navigating to Sign Up page
    Click    ${MAIN_REGISTER_BUTTON}
    Wait Element State    ${SIGN_UP_SHUTTLE_COMPANY_CHECKBOX}
    Log Action    Selecting Shuttle Company role
    Click    ${SIGN_UP_SHUTTLE_COMPANY_CHECKBOX}
    Click    ${SIGN_UP_SELECT_BUTTON}
    Wait Element State    ${FIRST_PAGE_REGISTER_SH_NAME_INPUT}
    Log Workflow End    Navigate to Shuttle Registration Form

Open Browser And Navigate To Travel Agency Registration Form
    [Documentation]    Opens browser and navigates to Travel Agency registration form
    Log Workflow Start    Navigate to Travel Agency Registration Form
    Initialize Browser Session    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}
    Log Action    Navigating to Sign Up page
    Click    ${MAIN_REGISTER_BUTTON}
    Wait Element State    ${SIGN_UP_HOTEL_CHECKBOX}
    Log Action    Selecting Travel Agency role
    Click    ${SIGN_UP_HOTEL_CHECKBOX}
    Click    ${SIGN_UP_SELECT_BUTTON}
    Wait Element State    ${FIRST_PAGE_REGISTER_TA_NAME_INPUT}
    Log Workflow End    Navigate to Travel Agency Registration Form

# === HELPER KEYWORDS ===

Fill First Page With Valid Data Driver
    [Documentation]    Fills first page of Driver registration with valid data (without clicking Next)
    ${first_name}=    FakerLibrary.First Name
    ${last_name}=    FakerLibrary.Last Name
    ${email}=    FakerLibrary.Email
    ${password}=    Set Variable    TestPassword1!
    Log Data    First Name    ${first_name}
    Log Data    Last Name    ${last_name}
    Log Data    Email    ${email}
    Fill Text    ${FIRST_PAGE_REGISTER_DRIVER_NAME_INPUT}    ${first_name}
    Fill Text    ${FIRST_PAGE_REGISTER_DRIVER_LAST_NAME_INPUT}    ${last_name}
    Select Options By    ${FIRST_PAGE_REGISTER_DRIVER_DIAL_DROPDOWN}    label    +420
    Fill Text    xpath=//label[contains(text(), "Phone")]/preceding-sibling::input    123456789
    Fill Text    ${FIRST_PAGE_REGISTER_DRIVER_EMAIL_INPUT}    ${email}
    Fill Text    ${FIRST_PAGE_REGISTER_DRIVER_PASSWORD_INPUT}    ${password}
    Fill Text    ${FIRST_PAGE_REGISTER_DRIVER_CONFIRMED_PASSWORD_INPUT}    ${password}
    ${checkbox}=    Get Element    ${FIRST_PAGE_REGISTER_DRIVER_TERMS_OF_USE_CHECKBOX}
    Click    ${checkbox}
    RETURN    ${first_name}    ${last_name}    ${email}

Navigate To Second Page Driver
    [Documentation]    Navigates to second page of Driver registration (Languages)
    Fill First Page With Valid Data Driver
    Click    ${FIRST_PAGE_REGISTER_DRIVER_NEXT_BUTTON}
    Wait Element State    ${SECOND_PAGE_REGISTER_DRIVER_LANGUAGE_DROPDOWN}

Navigate To Third Page Driver
    [Documentation]    Navigates to third page of Driver registration (Business Details)
    Navigate To Second Page Driver
    Select Options By    ${SECOND_PAGE_REGISTER_DRIVER_LANGUAGE_DROPDOWN}    label    Czech
    Select Options By    ${SECOND_PAGE_REGISTER_DRIVER_LEVEL_OF_ENGLISH_DROPDOWN}    label    Advanced
    Select Options By    ${SECOND_PAGE_REGISTER_DRIVER_DRIVING_EXPERIENCE_DROPDOWN}    label    5-10 years
    Click    ${SECOND_PAGE_REGISTER_DRIVER_NEXT_BUTTON}
    Wait Element State    ${THIRD_PAGE_REGISTER_DRIVER_COUNTRY_DROPDOWN}

Navigate To Second Page Shuttle
    [Documentation]    Navigates to second page of Shuttle registration (Business Details - skip Languages)
    ${data}=    Fill First Page With Valid Data Shuttle
    Click    ${FIRST_PAGE_REGISTER_SH_NEXT_BUTTON}
    Wait Element State    ${THIRD_PAGE_REGISTER_SH_COUNTRY_DROPDOWN}

Fill First Page With Valid Data Shuttle
    [Documentation]    Fills first page of Shuttle registration with valid data
    ${first_name}=    FakerLibrary.First Name
    ${last_name}=    FakerLibrary.Last Name
    ${email}=    FakerLibrary.Email
    ${password}=    Set Variable    TestPassword1!
    Log Data    First Name    ${first_name}
    Log Data    Last Name    ${last_name}
    Log Data    Email    ${email}
    Fill Text    ${FIRST_PAGE_REGISTER_SH_NAME_INPUT}    ${first_name}
    Fill Text    ${FIRST_PAGE_REGISTER_SH_LAST_NAME_INPUT}    ${last_name}
    Select Options By    ${FIRST_PAGE_REGISTER_SH_DIAL_DROPDOWN}    label    +420
    Fill Text    xpath=//label[contains(text(), "Phone")]/preceding-sibling::input    123456789
    Fill Text    ${FIRST_PAGE_REGISTER_SH_EMAIL_INPUT}    ${email}
    Fill Text    ${FIRST_PAGE_REGISTER_SH_PASSWORD_INPUT}    ${password}
    Fill Text    ${FIRST_PAGE_REGISTER_SH_CONFIRMED_PASSWORD_INPUT}    ${password}
    ${checkbox}=    Get Element    ${FIRST_PAGE_REGISTER_SH_TERMS_OF_USE_CHECKBOX}
    Click    ${checkbox}
    RETURN    ${first_name}    ${last_name}    ${email}

# === VALIDATION KEYWORDS ===

Clear And Fill Registration Field
    [Documentation]    Clears field and fills new value, triggers validation with Tab
    [Arguments]    ${locator}    ${value}
    Wait Element State    ${locator}
    Click    ${locator}
    Clear Text    ${locator}
    IF    "${value}" != "${EMPTY}"
        Log Data    Field value    ${value}
        Fill Text    ${locator}    ${value}
    END
    Press Keys    ${locator}    Tab

Fill Register Field With Generated Text
    [Documentation]    Fills field with random text of specified length
    [Arguments]    ${locator}    ${length}
    ${text}=    Generate Random String    ${length}    [LETTERS]
    Log Action    Filling field with generated text (${length} chars)
    Clear And Fill Registration Field    ${locator}    ${text}

Verify Register Validation Error Is Visible
    [Documentation]    Verifies that validation error is visible and contains expected text
    [Arguments]    ${validation_locator}    ${expected_text}=${EMPTY}
    TRY
        Wait Element State    ${validation_locator}
        ${text}=    Get Text    ${validation_locator}
        Should Not Be Empty    ${text}    Validation error should contain text
        IF    "${expected_text}" != "${EMPTY}"
            Should Contain    ${text}    ${expected_text}    Validation message should contain expected text
        END
        Log    Validation error displayed: ${text}    console=${LOG_TO_CONSOLE}
        Log Verification    Validation error displayed
    EXCEPT    AS    ${err}
        Take Screenshot
        Fail    Validation error was not displayed for ${validation_locator}: ${err}
    END

Verify Register Field Has Invalid State
    [Documentation]    Verifies that registration field has is-invalid class (Blazorise pattern)
    [Arguments]    ${field_locator}
    Wait Element State    ${field_locator}
    ${classes}=    Get Attribute    ${field_locator}    class
    Should Contain    ${classes}    ${VALIDATION_INVALID_CLASS}    Field should have is-invalid class
    Log Verification    Field has invalid state

Verify No Validation Error
    [Documentation]    Verifies that validation error is NOT visible
    [Arguments]    ${validation_locator}
    ${state}=    Get Element States    ${validation_locator}
    Should Not Contain    ${state}    visible
    Log Verification    No validation error (field is valid)

Verify Register Field MaxLength Truncation
    [Documentation]    Verifies that field value was truncated to max length
    [Arguments]    ${locator}    ${expected_length}
    Wait Element State    ${locator}
    ${value}=    Get Property    ${locator}    value
    ${length}=    Get Length    ${value}
    Should Be Equal As Integers    ${length}    ${expected_length}    Field value should be truncated to ${expected_length} characters
    Log Verification    Field value truncated to ${expected_length} chars

Click Next Button Driver
    [Documentation]    Clicks Next button on Driver registration form to trigger validation
    Log Action    Clicking Next button to trigger validation
    Click    ${FIRST_PAGE_REGISTER_DRIVER_NEXT_BUTTON}

Click Next Button Shuttle
    [Documentation]    Clicks Next button on Shuttle registration form to trigger validation
    Log Action    Clicking Next button to trigger validation
    Click    ${FIRST_PAGE_REGISTER_SH_NEXT_BUTTON}

Click Submit Button Travel Agency
    [Documentation]    Clicks Submit button on Travel Agency registration form to trigger validation
    Log Action    Clicking Submit button to trigger validation
    Click    ${FIRST_PAGE_REGISTER_TA_SUBMIT_BUTTON}

Click Finish Button Driver
    [Documentation]    Clicks Finish button on Driver Business Details form to trigger validation
    Log Action    Clicking Finish button to trigger validation
    Click    ${THIRD_PAGE_REGISTER_DRIVER_FINISH_BUTTON}

Click Finish Button Shuttle
    [Documentation]    Clicks Finish button on Shuttle Business Details form to trigger validation
    Log Action    Clicking Finish button to trigger validation
    Click    ${THIRD_PAGE_REGISTER_SH_FINISH_BUTTON}

# === PASSWORD VALIDATION KEYWORDS ===
# These keywords fill the complete form with custom passwords for validation tests

Fill First Page With Password Driver
    [Documentation]    Fills first page with custom password for Driver validation tests
    ...                Blazor validation requires complete form before showing password errors
    [Arguments]    ${password}    ${confirmed_password}
    ${first_name}=    FakerLibrary.First Name
    ${last_name}=    FakerLibrary.Last Name
    ${email}=    FakerLibrary.Email
    Log Data    First Name    ${first_name}
    Log Data    Last Name    ${last_name}
    Log Data    Email    ${email}
    Log Data    Password    ${password}
    Fill Text    ${FIRST_PAGE_REGISTER_DRIVER_NAME_INPUT}    ${first_name}
    Fill Text    ${FIRST_PAGE_REGISTER_DRIVER_LAST_NAME_INPUT}    ${last_name}
    Select Options By    ${FIRST_PAGE_REGISTER_DRIVER_DIAL_DROPDOWN}    label    +420
    Fill Text    xpath=//label[contains(text(), "Phone")]/preceding-sibling::input    123456789
    Fill Text    ${FIRST_PAGE_REGISTER_DRIVER_EMAIL_INPUT}    ${email}
    Fill Text    ${FIRST_PAGE_REGISTER_DRIVER_PASSWORD_INPUT}    ${password}
    Fill Text    ${FIRST_PAGE_REGISTER_DRIVER_CONFIRMED_PASSWORD_INPUT}    ${confirmed_password}
    ${checkbox}=    Get Element    ${FIRST_PAGE_REGISTER_DRIVER_TERMS_OF_USE_CHECKBOX}
    Click    ${checkbox}

Fill First Page With Phone Driver
    [Documentation]    Fills first page with custom phone for Driver validation tests
    ...                Blazor validation requires complete form, but terms unchecked prevents navigation
    [Arguments]    ${phone_value}
    ${first_name}=    FakerLibrary.First Name
    ${last_name}=    FakerLibrary.Last Name
    ${email}=    FakerLibrary.Email
    ${password}=    Set Variable    TestPassword1!
    Log Data    First Name    ${first_name}
    Log Data    Last Name    ${last_name}
    Log Data    Email    ${email}
    Log Data    Phone    ${phone_value}
    Fill Field    ${FIRST_PAGE_REGISTER_DRIVER_NAME_INPUT}    ${first_name}    First name input
    Fill Field    ${FIRST_PAGE_REGISTER_DRIVER_LAST_NAME_INPUT}    ${last_name}    Last name input
    Select From Dropdown    ${FIRST_PAGE_REGISTER_DRIVER_DIAL_DROPDOWN}    +420    label    Dial dropdown
    Fill Field    ${FIRST_PAGE_REGISTER_DRIVER_PHONE_INPUT}    ${phone_value}    Phone input
    Fill Field    ${FIRST_PAGE_REGISTER_DRIVER_EMAIL_INPUT}    ${email}    Email input
    Fill Field    ${FIRST_PAGE_REGISTER_DRIVER_PASSWORD_INPUT}    ${password}    Password input
    Fill Field    ${FIRST_PAGE_REGISTER_DRIVER_CONFIRMED_PASSWORD_INPUT}    ${password}    Confirm password input
    # Intentionally NOT clicking terms checkbox to prevent navigation

Fill First Page With Password Shuttle
    [Documentation]    Fills first page with custom password for Shuttle validation tests
    ...                Blazor validation requires complete form before showing password errors
    [Arguments]    ${password}    ${confirmed_password}
    ${first_name}=    FakerLibrary.First Name
    ${last_name}=    FakerLibrary.Last Name
    ${email}=    FakerLibrary.Email
    Log Data    First Name    ${first_name}
    Log Data    Last Name    ${last_name}
    Log Data    Email    ${email}
    Log Data    Password    ${password}
    Fill Text    ${FIRST_PAGE_REGISTER_SH_NAME_INPUT}    ${first_name}
    Fill Text    ${FIRST_PAGE_REGISTER_SH_LAST_NAME_INPUT}    ${last_name}
    Select Options By    ${FIRST_PAGE_REGISTER_SH_DIAL_DROPDOWN}    label    +420
    Fill Text    xpath=//label[contains(text(), "Phone")]/preceding-sibling::input    123456789
    Fill Text    ${FIRST_PAGE_REGISTER_SH_EMAIL_INPUT}    ${email}
    Fill Text    ${FIRST_PAGE_REGISTER_SH_PASSWORD_INPUT}    ${password}
    Fill Text    ${FIRST_PAGE_REGISTER_SH_CONFIRMED_PASSWORD_INPUT}    ${confirmed_password}
    ${checkbox}=    Get Element    ${FIRST_PAGE_REGISTER_SH_TERMS_OF_USE_CHECKBOX}
    Click    ${checkbox}

Fill First Page With Password Travel Agency
    [Documentation]    Fills first page with custom password for Travel Agency validation tests
    ...                Blazor validation requires complete form before showing password errors
    [Arguments]    ${password}    ${confirmed_password}
    ${first_name}=    FakerLibrary.First Name
    ${last_name}=    FakerLibrary.Last Name
    ${email}=    FakerLibrary.Email
    Log Data    First Name    ${first_name}
    Log Data    Last Name    ${last_name}
    Log Data    Email    ${email}
    Log Data    Password    ${password}
    Fill Text    ${FIRST_PAGE_REGISTER_TA_NAME_INPUT}    ${first_name}
    Fill Text    ${FIRST_PAGE_REGISTER_TA_LAST_NAME_INPUT}    ${last_name}
    Select Options By    ${FIRST_PAGE_REGISTER_TA_DIAL_DROPDOWN}    label    +420
    Fill Text    xpath=//label[contains(text(), "Phone")]/preceding-sibling::input    123456789
    Fill Text    ${FIRST_PAGE_REGISTER_TA_EMAIL_INPUT}    ${email}
    Fill Text    ${FIRST_PAGE_REGISTER_TA_PASSWORD_INPUT}    ${password}
    Fill Text    ${FIRST_PAGE_REGISTER_TA_CONFIRMED_PASSWORD_INPUT}    ${confirmed_password}
    ${checkbox}=    Get Element    ${FIRST_PAGE_REGISTER_TA_TERMS_OF_USE_CHECKBOX}
    Click    ${checkbox}

# === WHATSAPP VALIDATION WORKFLOW ===
# These keywords are needed because WhatsApp validation has multiple states
# and requires waiting for async response

Verify WhatsApp Phone Required Message
    [Documentation]    Verifies "Phone number must be filled in first" message appears
    ...                Uses: Verify Element Visible (from common.resource)
    Verify Element Visible    ${REGISTER_WHATSAPP_PHONE_REQUIRED_MESSAGE}    WhatsApp phone required message

Verify WhatsApp Verified Message
    [Documentation]    Verifies "WhatsApp verified" (green) message appears
    Verify Element Visible    ${REGISTER_WHATSAPP_VERIFIED_MESSAGE}    WhatsApp verified message

Verify WhatsApp Not Verified Message
    [Documentation]    Verifies "WhatsApp not verified" (red) message appears
    Verify Element Visible    ${REGISTER_WHATSAPP_NOT_VERIFIED_MESSAGE}    WhatsApp not verified message

Verify WhatsApp Checkbox Unchecked
    [Documentation]    Verifies checkbox is unchecked after failed validation
    ${checked}=    Get Checkbox State    ${REGISTER_WHATSAPP_CHECKBOX}
    Should Be Equal    ${checked}    ${FALSE}
    Log Verification    WhatsApp checkbox is unchecked

# === TYPE SELECTION PAGE KEYWORDS ===

Verify Navigation To LoginPage
    [Documentation]    Verifies navigation to /login page
    ${url}=    Get Url
    Should Contain    ${url}    /login
    Log Verification    Navigated to login page

Verify Still On Type Selection Page
    [Documentation]    Verifies user stayed on type selection page (silent failure case)
    Verify Element Visible    ${SIGN_UP_DRIVER_CHECKBOX}    Driver checkbox

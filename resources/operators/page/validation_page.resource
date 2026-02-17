*** Settings ***
Documentation    Page object for form validation - shared keywords for negative tests
Resource         ../../../common.resource
Resource         invoices_page.resource

*** Keywords ***
# === SETUP/TEARDOWN KEYWORDS ===

Open Browser And Navigate To Journey Form
    [Documentation]    Opens browser, logs in as admin and navigates to Journey form
    Log Workflow Start    Navigate to Journey Form
    Initialize Browser Session    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}
    Enter Admin Email    ${ADMIN_EMAIL}
    Enter Admin Password    ${ADMIN_PASSWORD}
    Click Login Button
    Verify Admin Login Success
    Log Action    Navigating to Journeys page
    Navigate To Journeys Page
    Wait Element State    ${JOURNEYS_CREATE_NEW_JOURNEY_BUTTON}
    Log Action    Opening new journey form
    Open New Journey Form
    Wait Element State    ${JOURNEYS_EDIT_ALL_BUTTON}
    Log Action    Clicking Edit All button
    Click Edit All Button
    Wait Element State    ${JOURNEYS_FORM_REQUEST_PASSENGERS_INPUT}
    Log Workflow End    Navigate to Journey Form

Close Journey Form Safely
    [Documentation]    Safely closes Journey form if open
    Log Action    Closing journey form
    TRY
        ${state}=    Get Element States    ${JOURNEYS_CLOSE_NEW_JOURNEY_BUTTON}
        IF    "visible" in $state
            Click    ${JOURNEYS_CLOSE_NEW_JOURNEY_BUTTON}
            Wait Element State    ${JOURNEYS_CLOSE_NEW_JOURNEY_BUTTON}    hidden
        END
    EXCEPT
        Log    Form is not open or already closed    console=${LOG_TO_CONSOLE}
    END

# === VALIDATION KEYWORDS ===

Clear And Fill Field
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

Fill Field With Generated Text
    [Documentation]    Fills field with random text of specified length
    [Arguments]    ${locator}    ${length}
    ${text}=    Generate Random String    ${length}    [LETTERS]
    Log Action    Filling field with generated text (${length} chars)
    Clear And Fill Field    ${locator}    ${text}

Verify Validation Error Is Visible
    [Documentation]    Verifies that validation error is visible and contains text
    [Arguments]    ${validation_locator}
    TRY
        Wait Element State    ${validation_locator}
        ${text}=    Get Text    ${validation_locator}
        Should Not Be Empty    ${text}    Validation error should contain text
        Log    Validation error displayed: ${text}    console=${LOG_TO_CONSOLE}
        Log Verification    Validation error displayed
    EXCEPT    AS    ${err}
        Take Screenshot
        Fail    Validation error was not displayed for ${validation_locator}: ${err}
    END

Verify Field Has Invalid State
    [Documentation]    Verifies that field has is-invalid class (Blazorise pattern)
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

Click Save And Trigger Validation
    [Documentation]    Clicks Save All button to trigger full form validation
    Log Action    Saving form to trigger validation
    Click Element    ${JOURNEYS_FORM_REQUEST_SAVE_ALL_BUTTON}    Saving form to trigger validation

Navigate To Journeys Page Without Opening Form
    [Documentation]    Opens browser, logs in as admin and navigates to Journey page without opening form
    Log Workflow Start    Navigate to Journeys Page (no form)
    Initialize Browser Session    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}
    Enter Admin Email    ${ADMIN_EMAIL}
    Enter Admin Password    ${ADMIN_PASSWORD}
    Click Login Button
    Verify Admin Login Success
    Log Action    Navigating to Journeys page
    Navigate To Journeys Page
    Wait Element State    ${JOURNEYS_CREATE_NEW_JOURNEY_BUTTON}
    Log Action    Opening new journey form
    Open New Journey Form
    Wait Element State    ${JOURNEYS_EDIT_ALL_BUTTON}
    Log Workflow End    Navigate to Journeys Page (no form)

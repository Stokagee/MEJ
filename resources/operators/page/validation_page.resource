*** Settings ***
Documentation    Page object for form validation - shared keywords for negative tests
Resource         ../../../common.resource
Resource         invoices_page.resource

*** Keywords ***
# === SETUP/TEARDOWN KEYWORDS ===

Open Browser And Navigate To Journey Form
    [Documentation]    Opens browser, logs in as admin and navigates to Journey form
    Initialize Browser Session    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}
    Enter Admin Email    ${ADMIN_EMAIL}
    Enter Admin Password    ${ADMIN_PASSWORD}
    Click Login Button
    Verify Admin Login Success
    Navigate To Journeys Page
    Wait For Elements State    ${JOURNEYS_CREATE_NEW_JOURNEY_BUTTON}    visible    timeout=${TIMEOUT}
    Open New Journey Form
    Wait For Elements State    ${JOURNEYS_EDIT_ALL_BUTTON}    visible    timeout=${TIMEOUT}
    Click Edit All Button
    Wait For Elements State    ${JOURNEYS_FORM_REQUEST_PASSENGERS_INPUT}    visible    timeout=${TIMEOUT}

Close Journey Form Safely
    [Documentation]    Safely closes Journey form if open
    TRY
        ${state}=    Get Element States    ${JOURNEYS_CLOSE_NEW_JOURNEY_BUTTON}
        IF    "visible" in $state
            Click    ${JOURNEYS_CLOSE_NEW_JOURNEY_BUTTON}
            Wait For Elements State    ${JOURNEYS_CLOSE_NEW_JOURNEY_BUTTON}    hidden    timeout=3s
        END
    EXCEPT
        Log    Form is not open or already closed    console=${LOG_TO_CONSOLE}
    END

# === VALIDATION KEYWORDS ===

Clear And Fill Field
    [Documentation]    Clears field and fills new value, triggers validation with Tab
    [Arguments]    ${locator}    ${value}
    Wait For Elements State    ${locator}    visible    timeout=${TIMEOUT}
    Click    ${locator}
    Clear Text    ${locator}
    IF    "${value}" != "${EMPTY}"
        Fill Text    ${locator}    ${value}
    END
    Press Keys    ${locator}    Tab

Fill Field With Generated Text
    [Documentation]    Fills field with random text of specified length
    [Arguments]    ${locator}    ${length}
    ${text}=    Generate Random String    ${length}    [LETTERS]
    Clear And Fill Field    ${locator}    ${text}

Verify Validation Error Is Visible
    [Documentation]    Verifies that validation error is visible and contains text
    [Arguments]    ${validation_locator}
    TRY
        Wait For Elements State    ${validation_locator}    visible    timeout=5s
        ${text}=    Get Text    ${validation_locator}
        Should Not Be Empty    ${text}    Validation error should contain text
        Log    Validation error displayed: ${text}    console=${LOG_TO_CONSOLE}
    EXCEPT    AS    ${err}
        Take Screenshot
        Fail    Validation error was not displayed for ${validation_locator}: ${err}
    END

Verify Field Has Invalid State
    [Documentation]    Verifies that field has is-invalid class (Blazorise pattern)
    [Arguments]    ${field_locator}
    Wait For Elements State    ${field_locator}    visible    timeout=${TIMEOUT}
    ${classes}=    Get Attribute    ${field_locator}    class
    Should Contain    ${classes}    ${VALIDATION_INVALID_CLASS}    Field should have is-invalid class

Verify No Validation Error
    [Documentation]    Verifies that validation error is NOT visible
    [Arguments]    ${validation_locator}
    ${state}=    Get Element States    ${validation_locator}
    Should Not Contain    ${state}    visible

Click Save And Trigger Validation
    [Documentation]    Clicks Save All button to trigger full form validation
    Click Element    ${JOURNEYS_FORM_REQUEST_SAVE_ALL_BUTTON}    Saving form to trigger validation

Navigate To Journeys Page Without Opening Form
    [Documentation]    Opens browser, logs in as admin and navigates to Journey page without opening form
    Initialize Browser Session    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}
    Enter Admin Email    ${ADMIN_EMAIL}
    Enter Admin Password    ${ADMIN_PASSWORD}
    Click Login Button
    Verify Admin Login Success
    Navigate To Journeys Page
    Wait For Elements State    ${JOURNEYS_CREATE_NEW_JOURNEY_BUTTON}    visible    timeout=${TIMEOUT}
    Open New Journey Form
    Wait For Elements State    ${JOURNEYS_EDIT_ALL_BUTTON}    visible    timeout=${TIMEOUT}



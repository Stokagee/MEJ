*** Settings ***
Documentation    Page object for Invoice page - keywords for validation tests
Resource         ../../../common.resource

*** Keywords ***
# === SETUP/TEARDOWN ===
Open Browser And Navigate To Invoices Page
    [Documentation]    Opens browser, logs in as admin and navigates to Invoices page
    Log Workflow Start    Navigate to Invoices Page
    Initialize Browser Session    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}
    Enter Admin Email    ${ADMIN_EMAIL}
    Enter Admin Password    ${ADMIN_PASSWORD}
    Click Login Button
    Verify Admin Login Success
    Log Action    Navigating to Invoices page
    Go To    ${URL}invoices
    Wait For Elements State    ${ADMIN_INVOICES_FILTER_PANEL}    visible    timeout=${TIMEOUT}
    Log Workflow End    Navigate to Invoices Page

Open New Invoice Form
    [Documentation]    Opens new invoice form
    Log Action    Opening new invoice form
    Click Element    ${ADMIN_INVOICES_NEW_BUTTON}    Clicking New Invoice
    Wait For Elements State    ${ADMIN_INVOICES_FORM_SAVE_BUTTON}    visible    timeout=${TIMEOUT}

# === VALIDATION KEYWORDS ===
Clear And Fill Invoice Field
    [Documentation]    Clears field and fills new value, triggers validation with Tab
    [Arguments]    ${locator}    ${value}
    Wait For Elements State    ${locator}    visible    timeout=${TIMEOUT}
    Click    ${locator}
    Clear Text    ${locator}
    IF    "${value}" != "${EMPTY}"
        Log Data    Filling invoice field    ${value}
        Fill Text    ${locator}    ${value}
    END
    Press Keys    ${locator}    Tab

Fill Invoice Field With Generated Text
    [Documentation]    Fills field with random text of specified length
    [Arguments]    ${locator}    ${length}
    ${text}=    Generate Random String    ${length}    [LETTERS]
    Log Action    Filling field with generated text (${length} chars)
    Clear And Fill Invoice Field    ${locator}    ${text}

Verify Invoice ValidationError Is Visible
    [Documentation]    Verifies that validation error is visible
    [Arguments]    ${validation_locator}=${ADMIN_INVOICES_VALIDATION_ERROR_TEXTAREA}
    TRY
        Wait For Elements State    ${validation_locator}    visible    timeout=5s
        ${text}=    Get Text    ${validation_locator}
        Should Not Be Empty    ${text}    Validation error should contain text
        Log    Validation error displayed: ${text}    console=${LOG_TO_CONSOLE}
        Log Verification    Invoice validation error displayed
    EXCEPT    AS    ${err}
        Take Screenshot
        Fail    Validation error was not displayed: ${err}
    END

Verify Field Value MaxLength Truncation
    [Documentation]    Verifies that field value is truncated to expected max length.
    ...                Used for fields with HTML maxlength attribute that truncate input.
    [Arguments]    ${locator}    ${expected_max_length}
    ${actual_value}=    Get Property    ${locator}    value
    ${actual_length}=    Get Length    ${actual_value}
    Should Be Equal As Integers    ${actual_length}    ${expected_max_length}
    ...    Field value length (${actual_length}) does not match expected max length (${expected_max_length})
    Log    Field correctly truncated to ${actual_length} characters    console=${LOG_TO_CONSOLE}
    Log Verification    Field truncated to max length    ${actual_length} chars

Click Invoice Save And Trigger Validation
    [Documentation]    Clicks Save button to trigger validation
    Log Action    Saving invoice form to trigger validation
    Click Element    ${ADMIN_INVOICES_FORM_SAVE_BUTTON}    Saving invoice form

# === FILTER KEYWORDS ===
Apply Invoice Filter
    [Documentation]    Applies filter
    Log Action    Applying invoice filter
    Click Element    ${ADMIN_INVOICES_FILTER_SEARCH_BUTTON}    Applying filter
    Sleep    1s    # Wait for results to load

Fill Invoice VAT Number Filter
    [Documentation]    Fills VAT number into filter
    [Arguments]    ${vat_number}
    Log Data    VAT number filter    ${vat_number}
    Fill Field    ${ADMIN_INVOICES_FILTER_VAT_NUMBER_INPUT}    ${vat_number}    VAT Number filter

# === EXPORT KEYWORDS ===
Download Invoices As ZIP
    [Documentation]    Downloads invoices as ZIP
    Log Action    Downloading invoices as ZIP
    Click Element    ${ADMIN_INVOICES_FILTER_DOWNLOAD_ZIP_BUTTON}    Downloading ZIP

Download Invoices As XML
    [Documentation]    Downloads invoices as Pohoda XML
    Log Action    Downloading invoices as XML (Pohoda)
    Click Element    ${ADMIN_INVOICES_FILTER_DOWNLOAD_XML_BUTTON}    Downloading XML

Download Invoices As CSV
    [Documentation]    Downloads invoices as CSV
    Log Action    Downloading invoices as CSV
    Click Element    ${ADMIN_INVOICES_FILTER_DOWNLOAD_CSV_BUTTON}    Downloading CSV

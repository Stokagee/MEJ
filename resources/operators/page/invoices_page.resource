*** Settings ***
Documentation    Page object for Invoice page - keywords for validation tests
Resource         ../../../common.resource

*** Keywords ***
# === SETUP/TEARDOWN ===
Open Browser And Navigate To Invoices Page
    [Documentation]    Opens browser, logs in as admin and navigates to Invoices page
    Initialize Browser Session    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}
    Enter Admin Email    ${ADMIN_EMAIL}
    Enter Admin Password    ${ADMIN_PASSWORD}
    Click Login Button
    Verify Admin Login Success
    Go To    ${URL}invoices
    Wait For Elements State    ${ADMIN_INVOICES_FILTER_PANEL}    visible    timeout=${TIMEOUT}

Open New Invoice Form
    [Documentation]    Opens new invoice form
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
        Fill Text    ${locator}    ${value}
    END
    Press Keys    ${locator}    Tab

Fill Invoice Field With Generated Text
    [Documentation]    Fills field with random text of specified length
    [Arguments]    ${locator}    ${length}
    ${text}=    Generate Random String    ${length}    [LETTERS]
    Clear And Fill Invoice Field    ${locator}    ${text}

Verify Invoice ValidationError Is Visible
    [Documentation]    Verifies that validation error is visible
    [Arguments]    ${validation_locator}=${ADMIN_INVOICES_VALIDATION_ERROR_TEXTAREA}
    TRY
        Wait For Elements State    ${validation_locator}    visible    timeout=5s
        ${text}=    Get Text    ${validation_locator}
        Should Not Be Empty    ${text}    Validation error should contain text
        Log    Validation error displayed: ${text}
    EXCEPT    AS    ${err}
        Take Screenshot
        Fail    Validation error was not displayed: ${err}
    END

Click Invoice Save And Trigger Validation
    [Documentation]    Clicks Save button to trigger validation
    Click Element    ${ADMIN_INVOICES_FORM_SAVE_BUTTON}    Saving invoice form

# === FILTER KEYWORDS ===
Apply Invoice Filter
    [Documentation]    Applies filter
    Click Element    ${ADMIN_INVOICES_FILTER_SEARCH_BUTTON}    Applying filter
    Sleep    1s    # Wait for results to load

Reset Invoice Filter
    [Documentation]    Resets filter
    Click Element    ${ADMIN_INVOICES_FILTER_RESET_BUTTON}    Resetting filter

Fill Invoice VAT Number Filter
    [Documentation]    Fills VAT number into filter
    [Arguments]    ${vat_number}
    Fill Field    ${ADMIN_INVOICES_FILTER_VAT_NUMBER_INPUT}    ${vat_number}    VAT Number filter

# === EXPORT KEYWORDS ===
Download Invoices As ZIP
    [Documentation]    Downloads invoices as ZIP
    Click Element    ${ADMIN_INVOICES_FILTER_DOWNLOAD_ZIP_BUTTON}    Downloading ZIP

Download Invoices As XML
    [Documentation]    Downloads invoices as Pohoda XML
    Click Element    ${ADMIN_INVOICES_FILTER_DOWNLOAD_XML_BUTTON}    Downloading XML

Download Invoices As CSV
    [Documentation]    Downloads invoices as CSV
    Click Element    ${ADMIN_INVOICES_FILTER_DOWNLOAD_CSV_BUTTON}    Downloading CSV

# === TABLE KEYWORDS ===
Enter Order Name In Invoice Form
    [Documentation]    Enters Order Name in invoice form
    [Arguments]    ${order_name}
    Fill Field    ${ADMIN_INVOICES_FORM_ORDER_NAME_INPUT}    ${order_name}    entering Order Name

Enter Product Name In Invoice Form
    [Documentation]    Enters Product Name in invoice form
    [Arguments]    ${product_name}
    Fill Field    ${ADMIN_INVOICES_FORM_PRODUCT_NAME_INPUT}    ${product_name}    entering Product Name

Enter Profit For MEJ In Invoice Form
    [Documentation]    Enters Profit For MEJ in invoice form
    [Arguments]    ${profit_mej}
    Fill Field    ${ADMIN_INVOICES_FORM_PROFIT_FOR_MEJ_INPUT}    ${profit_mej}    entering Profit For MEJ

Enter Received Payment In Invoice Form
    [Documentation]    Enters Received Payment in invoice form
    [Arguments]    ${received_payment}
    Fill Field    ${ADMIN_INVOICES_FORM_RECEIVED_PAYMENT_INPUT}    ${received_payment}    entering Received Payment

Select Driver In Invoice Form
    [Documentation]    Selects driver in invoice form
    Select Random Dropdown Value   ${ADMIN_INVOICES_FORM_DRIVER_DROPDOWN}    attribute=value    skip_first=${True}    context_name=selecting driver

Save Invoice Form
    [Documentation]    Saves invoice form
    Click Invoice Save And Trigger Validation

Verify Invoice Created In UI
    [Documentation]    Verifies that invoice was created in UI
    Verify Element Visible    ${ADMIN_INVOICES_FORM_REMOVE_INVOICE_BUTTON}    Invoice probably not created correctly - Remove button not found

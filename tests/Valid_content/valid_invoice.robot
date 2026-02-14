*** Settings ***
Documentation    Positive tests for validating content on the Invoice page.
...              Tests proper display of components, filters and form.
Resource    ../../common.resource

*** Variables ***
${TEST_VAT_NUMBER}       CZ12345678
${TEST_BUSINESS_NO}      12345678
${TEST_BUSINESS_NAME}    Test Company s.r.o.
${TEST_EMAIL}            test@example.com
${TEST_AMOUNT}           100

*** Test Cases ***

### *** Filter Panel Validation ***

Validate Filter Panel Display
    [Documentation]    Verify that filter panel is properly displayed on the invoices page.
    [Tags]    ui    invoice    positive    p2    filter
    [Setup]    Open Browser And Navigate To Invoices Page
    Wait For Elements State    ${ADMIN_INVOICES_FILTER_PANEL}    visible    timeout=${TIMEOUT}
    Wait For Elements State    ${ADMIN_INVOICES_FILTER_DATE_DROPDOWN}    visible    timeout=${TIMEOUT}
    Wait For Elements State    ${ADMIN_INVOICES_FILTER_VIES_STATE_DROPDOWN}    visible    timeout=${TIMEOUT}
    Wait For Elements State    ${ADMIN_INVOICES_FILTER_VAT_NUMBER_INPUT}    visible    timeout=${TIMEOUT}
    Wait For Elements State    ${ADMIN_INVOICES_FILTER_SHOW_DUPLICITIES_CHECKBOX}    visible    timeout=${TIMEOUT}
    [Teardown]    Close Browser

Validate Filter Buttons Display
    [Documentation]    Verify that filter buttons (Search, Reset) are properly displayed.
    [Tags]    ui    invoice    positive    p2    filter    buttons
    [Setup]    Open Browser And Navigate To Invoices Page
    Wait For Elements State    ${ADMIN_INVOICES_FILTER_SEARCH_BUTTON}    visible    timeout=${TIMEOUT}
    Wait For Elements State    ${ADMIN_INVOICES_FILTER_RESET_BUTTON}    visible    timeout=${TIMEOUT}
    [Teardown]    Close Browser

Validate Export Buttons Display
    [Documentation]    Verify that export buttons (ZIP, XML, CSV) are properly displayed.
    [Tags]    ui    invoice    positive    p2    export    buttons
    [Setup]    Open Browser And Navigate To Invoices Page
    Wait For Elements State    ${ADMIN_INVOICES_FILTER_DOWNLOAD_ZIP_BUTTON}    visible    timeout=${TIMEOUT}
    Wait For Elements State    ${ADMIN_INVOICES_FILTER_DOWNLOAD_XML_BUTTON}    visible    timeout=${TIMEOUT}
    Wait For Elements State    ${ADMIN_INVOICES_FILTER_DOWNLOAD_CSV_BUTTON}    visible    timeout=${TIMEOUT}
    [Teardown]    Close Browser

### *** Filter Functionality Validation ***

Validate VAT Number Filter Filling
    [Documentation]    Test that VAT number filter correctly accepts values.
    [Tags]    ui    invoice    positive    p2    filter    vat_number
    [Setup]    Open Browser And Navigate To Invoices Page
    Fill Invoice VAT Number Filter    ${TEST_VAT_NUMBER}
    ${value}=    Get Attribute    ${ADMIN_INVOICES_FILTER_VAT_NUMBER_INPUT}    value
    Should Be Equal    ${value}    ${TEST_VAT_NUMBER}    msg=VAT Number was not filled correctly!
    [Teardown]    Close Browser

Validate Filter Search Function
    [Documentation]    Test that search button works without error.
    [Tags]    ui    invoice    positive    p2    filter    search
    [Setup]    Open Browser And Navigate To Invoices Page
    Fill Invoice VAT Number Filter    ${TEST_VAT_NUMBER}
    Apply Invoice Filter
    # Verify that page still shows filter panel (no error occurred)
    Wait For Elements State    ${ADMIN_INVOICES_FILTER_PANEL}    visible    timeout=${TIMEOUT}
    [Teardown]    Close Browser

Validate Filter Reset Function
    [Documentation]    Test that reset button clears filled fields.
    [Tags]    ui    invoice    positive    p2    filter    reset
    [Setup]    Open Browser And Navigate To Invoices Page
    Fill Invoice VAT Number Filter    ${TEST_VAT_NUMBER}
    Reset Invoice Filter
    Sleep    1s
    ${value}=    Get Attribute    ${ADMIN_INVOICES_FILTER_VAT_NUMBER_INPUT}    value
    Should Be Empty    ${value}    msg=Filter reset did not clear VAT Number!
    [Teardown]    Close Browser

### *** Invoice Table Validation ***

Validate Invoice Table Display
    [Documentation]    Verify that invoice table is properly displayed.
    [Tags]    ui    invoice    positive    p2    table
    [Setup]    Open Browser And Navigate To Invoices Page
    Wait For Elements State    ${ADMIN_INVOICES_TABLE}    visible    timeout=${TIMEOUT}
    [Teardown]    Close Browser

Validate New Invoice Button Display
    [Documentation]    Verify that button for creating new invoice is visible.
    [Tags]    ui    invoice    positive    p2    new    button
    [Setup]    Open Browser And Navigate To Invoices Page
    Wait For Elements State    ${ADMIN_INVOICES_NEW_BUTTON}    visible    timeout=${TIMEOUT}
    [Teardown]    Close Browser

### *** Invoice Form Validation ***

Validate Invoice Form Opening
    [Documentation]    Verify that form for new invoice opens properly.
    [Tags]    ui    invoice    positive    p2    form    open
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Wait For Elements State    ${ADMIN_INVOICES_FORM_SAVE_BUTTON}    visible    timeout=${TIMEOUT}
    Wait For Elements State    ${ADMIN_INVOICES_FORM_CANCEL_BUTTON}    visible    timeout=${TIMEOUT}
    [Teardown]    Close Browser

Validate Invoice Detail Fields Display
    [Documentation]    Verify that Invoice Detail fields are properly displayed in the form.
    [Tags]    ui    invoice    positive    p2    form    detail
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Wait For Elements State    ${ADMIN_INVOICES_FORM_ORDER_INPUT}    visible    timeout=${TIMEOUT}
    Wait For Elements State    ${ADMIN_INVOICES_FORM_DATE_PICKER}    visible    timeout=${TIMEOUT}
    [Teardown]    Close Browser

Validate Driver Detail Fields Display
    [Documentation]    Verify that Driver Detail fields are properly displayed in the form.
    [Tags]    ui    invoice    positive    p2    form    driver
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Wait For Elements State    ${ADMIN_INVOICES_FORM_BUSINESS_NO_INPUT}    visible    timeout=${TIMEOUT}
    Wait For Elements State    ${ADMIN_INVOICES_FORM_VAT_NO_INPUT}    visible    timeout=${TIMEOUT}
    Wait For Elements State    ${ADMIN_INVOICES_FORM_BUSINESS_NAME_INPUT}    visible    timeout=${TIMEOUT}
    Wait For Elements State    ${ADMIN_INVOICES_FORM_NAME_INPUT}    visible    timeout=${TIMEOUT}
    Wait For Elements State    ${ADMIN_INVOICES_FORM_EMAIL_INPUT}    visible    timeout=${TIMEOUT}
    [Teardown]    Close Browser

Validate Address Fields Display
    [Documentation]    Verify that address fields are properly displayed in the form.
    [Tags]    ui    invoice    positive    p2    form    address
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Wait For Elements State    ${ADMIN_INVOICES_FORM_STREET_INPUT}    visible    timeout=${TIMEOUT}
    Wait For Elements State    ${ADMIN_INVOICES_FORM_CITY_INPUT}    visible    timeout=${TIMEOUT}
    Wait For Elements State    ${ADMIN_INVOICES_FORM_ZIP_INPUT}    visible    timeout=${TIMEOUT}
    Wait For Elements State    ${ADMIN_INVOICES_FORM_COUNTRY_DROPDOWN}    visible    timeout=${TIMEOUT}
    [Teardown]    Close Browser

### *** Form Input Validation ***

Validate Business Number Filling
    [Documentation]    Test that Business Number field correctly accepts values.
    [Tags]    ui    invoice    positive    p2    form    business_no
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Clear And Fill Invoice Field    ${ADMIN_INVOICES_FORM_BUSINESS_NO_INPUT}    ${TEST_BUSINESS_NO}
    ${value}=    Get Attribute    ${ADMIN_INVOICES_FORM_BUSINESS_NO_INPUT}    value
    Should Be Equal    ${value}    ${TEST_BUSINESS_NO}    msg=Business Number was not filled correctly!
    [Teardown]    Close Browser

Validate VAT Number Filling
    [Documentation]    Test that VAT Number field correctly accepts values.
    [Tags]    ui    invoice    positive    p2    form    vat_no
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Clear And Fill Invoice Field    ${ADMIN_INVOICES_FORM_VAT_NO_INPUT}    ${TEST_VAT_NUMBER}
    ${value}=    Get Attribute    ${ADMIN_INVOICES_FORM_VAT_NO_INPUT}    value
    Should Be Equal    ${value}    ${TEST_VAT_NUMBER}    msg=VAT Number was not filled correctly!
    [Teardown]    Close Browser

Validate Business Name Filling
    [Documentation]    Test that Business Name field correctly accepts values.
    [Tags]    ui    invoice    positive    p2    form    business_name
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Clear And Fill Invoice Field    ${ADMIN_INVOICES_FORM_BUSINESS_NAME_INPUT}    ${TEST_BUSINESS_NAME}
    ${value}=    Get Attribute    ${ADMIN_INVOICES_FORM_BUSINESS_NAME_INPUT}    value
    Should Be Equal    ${value}    ${TEST_BUSINESS_NAME}    msg=Business Name was not filled correctly!
    [Teardown]    Close Browser

Validate Email Filling
    [Documentation]    Test that Email field correctly accepts values.
    [Tags]    ui    invoice    positive    p2    form    email
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Clear And Fill Invoice Field    ${ADMIN_INVOICES_FORM_EMAIL_INPUT}    ${TEST_EMAIL}
    ${value}=    Get Attribute    ${ADMIN_INVOICES_FORM_EMAIL_INPUT}    value
    Should Be Equal    ${value}    ${TEST_EMAIL}    msg=Email was not filled correctly!
    [Teardown]    Close Browser

### *** Form Cancel Validation ***

Validate Form Closing Using Cancel
    [Documentation]    Test that Cancel button properly closes the form.
    [Tags]    ui    invoice    positive    p2    form    cancel
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Click Element    ${ADMIN_INVOICES_FORM_CANCEL_BUTTON}    Clicking Cancel
    Sleep    1s
    # Verify that form is closed (Save button is no longer visible)
    ${states}=    Get Element States    ${ADMIN_INVOICES_FORM_SAVE_BUTTON}
    Should Not Contain    ${states}    visible
    [Teardown]    Close Browser

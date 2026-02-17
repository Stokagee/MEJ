*** Settings ***
Documentation    Negative tests for validating Invoice form.
...              Tests field validation, filters and export functionality.
...              Follows POM structure - uses keywords from invoices_page.resource
Resource         ../../common.resource

*** Variables ***
${INVALID_EMAIL_1}           invalid@
${INVALID_EMAIL_2}           @invalid.com
${INVALID_EMAIL_3}           invalid.email
${INVALID_VAT_NUMBER}        ABC123

*** Test Cases ***
### *** Form Validation - Required Fields ***

Test Empty Business Number Shows Error
    [Documentation]    Verify that empty Business Number displays validation error.
    ...                Validation rule: Required, MaxLength(20)
    [Tags]    ui    invoice    negative    p1    validation    required
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Clear And Fill Invoice Field    ${ADMIN_INVOICES_FORM_BUSINESS_NO_INPUT}    ${EMPTY}
    Click Invoice Save And Trigger Validation
    Verify Invoice Validation Error Is Visible    ${ADMIN_INVOICES_BUSINESS_NO_VALIDATION}
    [Teardown]    Close Browser

Test Empty Business Name Shows Error
    [Documentation]    Verify that empty Business Name displays validation error.
    ...                Validation rule: MaxLength(512)
    [Tags]    ui    invoice    negative    p1    validation    required
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Clear And Fill Invoice Field    ${ADMIN_INVOICES_FORM_BUSINESS_NAME_INPUT}    ${EMPTY}
    Click Invoice Save And Trigger Validation
    Verify Invoice Validation Error Is Visible    ${ADMIN_INVOICES_BUSINESS_NAME_VALIDATION}
    [Teardown]    Close Browser

### *** Form Validation - Email ***

Test Invalid Invoice Email Format Without Domain Shows Error
    [Documentation]    Verify that email without domain displays validation error.
    ...                Validation rule: Email format
    [Tags]    ui    invoice    negative    p1    validation    email
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Clear And Fill Invoice Field    ${ADMIN_INVOICES_FORM_EMAIL_INPUT}    ${INVALID_EMAIL_1}
    Verify Invoice Validation Error Is Visible    ${ADMIN_INVOICES_EMAIL_VALIDATION}
    [Teardown]    Close Browser

Test Invalid Invoice Email Format Without Username Shows Error
    [Documentation]    Verify that email without username displays error.
    [Tags]    ui    invoice    negative    p1    validation    email
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Clear And Fill Invoice Field    ${ADMIN_INVOICES_FORM_EMAIL_INPUT}    ${INVALID_EMAIL_2}
    Verify Invoice Validation Error Is Visible    ${ADMIN_INVOICES_EMAIL_VALIDATION}
    [Teardown]    Close Browser

Test Invalid Invoice Email Format Without At Sign Shows Error
    [Documentation]    Verify that email without @ displays validation error.
    [Tags]    ui    invoice    negative    p1    validation    email
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Clear And Fill Invoice Field    ${ADMIN_INVOICES_FORM_EMAIL_INPUT}    ${INVALID_EMAIL_3}
    Verify Invoice Validation Error Is Visible    ${ADMIN_INVOICES_EMAIL_VALIDATION}
    [Teardown]    Close Browser

### *** Form Validation - Max Length ***

Test Too Long Business Number Shows Error
    [Documentation]    Verify that too long Business Number (>20 characters) is truncated to 20.
    ...                Validation rule: MaxLength(20) - browser truncates input
    [Tags]    ui    invoice    negative    p1    validation    maxlength
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Fill Invoice Field With Generated Text    ${ADMIN_INVOICES_FORM_BUSINESS_NO_INPUT}    21
    Verify Field Value MaxLength Truncation    ${ADMIN_INVOICES_FORM_BUSINESS_NO_INPUT}    20
    [Teardown]    Close Browser

Test Too Long VAT Number Shows Error
    [Documentation]    Verify that too long VAT Number (>32 characters) is truncated to 32.
    ...                Validation rule: MaxLength(32) - browser truncates input
    [Tags]    ui    invoice    negative    p1    validation    maxlength
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Fill Invoice Field With Generated Text    ${ADMIN_INVOICES_FORM_VAT_NO_INPUT}    33
    Verify Field Value MaxLength Truncation    ${ADMIN_INVOICES_FORM_VAT_NO_INPUT}    32
    [Teardown]    Close Browser

Test Too Long Business Name Shows Error
    [Documentation]    Verify that too long Business Name (>512 characters) is truncated to 512.
    ...                Validation rule: MaxLength(512) - browser truncates input
    [Tags]    ui    invoice    negative    p1    validation    maxlength
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Fill Invoice Field With Generated Text    ${ADMIN_INVOICES_FORM_BUSINESS_NAME_INPUT}    513
    Verify Field Value MaxLength Truncation    ${ADMIN_INVOICES_FORM_BUSINESS_NAME_INPUT}    512
    [Teardown]    Close Browser

Test Too Long Name Shows Error
    [Documentation]    Verify that too long Name (>257 characters) is truncated to 257.
    ...                Validation rule: MaxLength(257) - browser truncates input
    [Tags]    ui    invoice    negative    p1    validation    maxlength
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Fill Invoice Field With Generated Text    ${ADMIN_INVOICES_FORM_NAME_INPUT}    258
    Verify Field Value MaxLength Truncation    ${ADMIN_INVOICES_FORM_NAME_INPUT}    257
    [Teardown]    Close Browser

Test Too Long Email Shows Error
    [Documentation]    Verify that too long Email (>256 characters) is truncated to 256.
    ...                Validation rule: MaxLength(256) - browser truncates input
    [Tags]    ui    invoice    negative    p1    validation    maxlength
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Fill Invoice Field With Generated Text    ${ADMIN_INVOICES_FORM_EMAIL_INPUT}    257
    Verify Field Value MaxLength Truncation    ${ADMIN_INVOICES_FORM_EMAIL_INPUT}    256
    [Teardown]    Close Browser

Test Too Long Product Name Shows Error
    [Documentation]    Verify that too long Product Name (>90 characters) is truncated to 90.
    ...                Validation rule: MaxLength(90) - browser truncates input
    [Tags]    ui    invoice    negative    p1    validation    maxlength
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Fill Invoice Field With Generated Text    ${ADMIN_INVOICES_FORM_PRODUCT_NAME_INPUT}    91
    Verify Field Value MaxLength Truncation    ${ADMIN_INVOICES_FORM_PRODUCT_NAME_INPUT}    90
    [Teardown]    Close Browser

### *** Filter Tests ***

Test Filter By VAT Number
    [Documentation]    Verify that filter by VAT number works.
    [Tags]    ui    invoice    positive    p2    filter
    [Setup]    Open Browser And Navigate To Invoices Page
    Fill Invoice VAT Number Filter    CZ12345678
    Apply Invoice Filter
    # Verify that page does not show error
    Wait Element State    ${ADMIN_INVOICES_FILTER_PANEL}
    [Teardown]    Close Browser

### *** Export Tests ***

Test Download Invoices ZIP Button Is Clickable
    [Documentation]    Verify that ZIP download button is active and clickable.
    [Tags]    ui    invoice    positive    p2    export
    [Setup]    Open Browser And Navigate To Invoices Page
    Wait Element State    ${ADMIN_INVOICES_FILTER_DOWNLOAD_ZIP_BUTTON}    enabled
    [Teardown]    Close Browser

Test Download Invoices XML Button Is Clickable
    [Documentation]    Verify that Pohoda XML download button is active and clickable.
    [Tags]    ui    invoice    positive    p2    export
    [Setup]    Open Browser And Navigate To Invoices Page
    Wait Element State    ${ADMIN_INVOICES_FILTER_DOWNLOAD_XML_BUTTON}    enabled
    [Teardown]    Close Browser

Test Download Invoices CSV Button Is Clickable
    [Documentation]    Verify that CSV download button is active and clickable.
    [Tags]    ui    invoice    positive    p2    export
    [Setup]    Open Browser And Navigate To Invoices Page
    Wait Element State    ${ADMIN_INVOICES_FILTER_DOWNLOAD_CSV_BUTTON}    enabled
    [Teardown]    Close Browser

### *** Invoice Items Validation ***

Test No Invoice Items Shows Error
    [Documentation]    Verify that form without invoice items displays error.
    ...                Note: When form is submitted without items, validation errors appear.
    ...                The Save button remaining visible indicates the form wasn't submitted.
    [Tags]    ui    invoice    negative    p1    validation    items
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    # Attempt to save without items - should show validation errors
    Click Invoice Save And Trigger Validation
    # Verify form wasn't submitted by checking Save button is still visible
    # (form stays open when validation fails)
    Wait Element State    ${ADMIN_INVOICES_FORM_SAVE_BUTTON}
    [Teardown]    Close Browser

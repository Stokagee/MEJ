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
    Verify Invoice Validation Error Is Visible
    [Teardown]    Close Browser

Test Empty Business Name Shows Error
    [Documentation]    Verify that empty Business Name displays validation error.
    ...                Validation rule: MaxLength(512)
    [Tags]    ui    invoice    negative    p1    validation    required
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Clear And Fill Invoice Field    ${ADMIN_INVOICES_FORM_BUSINESS_NAME_INPUT}    ${EMPTY}
    Click Invoice Save And Trigger Validation
    Verify Invoice Validation Error Is Visible
    [Teardown]    Close Browser

### *** Form Validation - Email ***

Test Invalid Invoice Email Format Without Domain Shows Error
    [Documentation]    Verify that email without domain displays validation error.
    ...                Validation rule: Email format
    [Tags]    ui    invoice    negative    p1    validation    email
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Clear And Fill Invoice Field    ${ADMIN_INVOICES_FORM_EMAIL_INPUT}    ${INVALID_EMAIL_1}
    Verify Invoice Validation Error Is Visible
    [Teardown]    Close Browser

Test Invalid Invoice Email Format Without Username Shows Error
    [Documentation]    Verify that email without username displays error.
    [Tags]    ui    invoice    negative    p1    validation    email
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Clear And Fill Invoice Field    ${ADMIN_INVOICES_FORM_EMAIL_INPUT}    ${INVALID_EMAIL_2}
    Verify Invoice Validation Error Is Visible
    [Teardown]    Close Browser

Test Invalid Invoice Email Format Without At Sign Shows Error
    [Documentation]    Verify that email without @ displays validation error.
    [Tags]    ui    invoice    negative    p1    validation    email
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Clear And Fill Invoice Field    ${ADMIN_INVOICES_FORM_EMAIL_INPUT}    ${INVALID_EMAIL_3}
    Verify Invoice Validation Error Is Visible
    [Teardown]    Close Browser

### *** Form Validation - Max Length ***

Test Too Long Business Number Shows Error
    [Documentation]    Verify that too long Business Number (>20 characters) displays error.
    ...                Validation rule: MaxLength(20)
    [Tags]    ui    invoice    negative    p1    validation    maxlength
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Fill Invoice Field With Generated Text    ${ADMIN_INVOICES_FORM_BUSINESS_NO_INPUT}    21
    Click Invoice Save And Trigger Validation
    Verify Invoice Validation Error Is Visible
    [Teardown]    Close Browser

Test Too Long VAT Number Shows Error
    [Documentation]    Verify that too long VAT Number (>32 characters) displays error.
    ...                Validation rule: MaxLength(32)
    [Tags]    ui    invoice    negative    p1    validation    maxlength
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Fill Invoice Field With Generated Text    ${ADMIN_INVOICES_FORM_VAT_NO_INPUT}    33
    Click Invoice Save And Trigger Validation
    Verify Invoice Validation Error Is Visible
    [Teardown]    Close Browser

Test Too Long Business Name Shows Error
    [Documentation]    Verify that too long Business Name (>512 characters) displays error.
    ...                Validation rule: MaxLength(512)
    [Tags]    ui    invoice    negative    p1    validation    maxlength
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Fill Invoice Field With Generated Text    ${ADMIN_INVOICES_FORM_BUSINESS_NAME_INPUT}    513
    Click Invoice Save And Trigger Validation
    Verify Invoice Validation Error Is Visible
    [Teardown]    Close Browser

Test Too Long Name Shows Error
    [Documentation]    Verify that too long Name (>257 characters) displays error.
    ...                Validation rule: MaxLength(257)
    [Tags]    ui    invoice    negative    p1    validation    maxlength
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Fill Invoice Field With Generated Text    ${ADMIN_INVOICES_FORM_NAME_INPUT}    258
    Click Invoice Save And Trigger Validation
    Verify Invoice Validation Error Is Visible
    [Teardown]    Close Browser

Test Too Long Email Shows Error
    [Documentation]    Verify that too long Email (>256 characters) displays error.
    ...                Validation rule: MaxLength(256)
    [Tags]    ui    invoice    negative    p1    validation    maxlength
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Fill Invoice Field With Generated Text    ${ADMIN_INVOICES_FORM_EMAIL_INPUT}    257
    Click Invoice Save And Trigger Validation
    Verify Invoice Validation Error Is Visible
    [Teardown]    Close Browser

Test Too Long Product Name Shows Error
    [Documentation]    Verify that too long Product Name (>90 characters) displays error.
    ...                Validation rule: MaxLength(90)
    [Tags]    ui    invoice    negative    p1    validation    maxlength
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    Fill Invoice Field With Generated Text    ${ADMIN_INVOICES_FORM_PRODUCT_NAME_INPUT}    91
    Click Invoice Save And Trigger Validation
    Verify Invoice Validation Error Is Visible
    [Teardown]    Close Browser

### *** Filter Tests ***

Test Filter By VAT Number
    [Documentation]    Verify that filter by VAT number works.
    [Tags]    ui    invoice    positive    p2    filter
    [Setup]    Open Browser And Navigate To Invoices Page
    Fill Invoice VAT Number Filter    CZ12345678
    Apply Invoice Filter
    # Verify that page does not show error
    Wait For Elements State    ${ADMIN_INVOICES_FILTER_PANEL}    visible    timeout=${TIMEOUT}
    [Teardown]    Close Browser

Test Filter Reset Clears All Fields
    [Documentation]    Verify that filter reset clears all fields.
    [Tags]    ui    invoice    positive    p2    filter
    [Setup]    Open Browser And Navigate To Invoices Page
    Fill Invoice VAT Number Filter    CZ12345678
    Reset Invoice Filter
    ${value}=    Get Attribute    ${ADMIN_INVOICES_FILTER_VAT_NUMBER_INPUT}    value
    Should Be Empty    ${value}
    [Teardown]    Close Browser

### *** Export Tests ***

Test Download Invoices ZIP Button Is Clickable
    [Documentation]    Verify that ZIP download button is active and clickable.
    [Tags]    ui    invoice    positive    p2    export
    [Setup]    Open Browser And Navigate To Invoices Page
    Wait For Elements State    ${ADMIN_INVOICES_FILTER_DOWNLOAD_ZIP_BUTTON}    enabled    timeout=${TIMEOUT}
    [Teardown]    Close Browser

Test Download Invoices XML Button Is Clickable
    [Documentation]    Verify that Pohoda XML download button is active and clickable.
    [Tags]    ui    invoice    positive    p2    export
    [Setup]    Open Browser And Navigate To Invoices Page
    Wait For Elements State    ${ADMIN_INVOICES_FILTER_DOWNLOAD_XML_BUTTON}    enabled    timeout=${TIMEOUT}
    [Teardown]    Close Browser

Test Download Invoices CSV Button Is Clickable
    [Documentation]    Verify that CSV download button is active and clickable.
    [Tags]    ui    invoice    positive    p2    export
    [Setup]    Open Browser And Navigate To Invoices Page
    Wait For Elements State    ${ADMIN_INVOICES_FILTER_DOWNLOAD_CSV_BUTTON}    enabled    timeout=${TIMEOUT}
    [Teardown]    Close Browser

### *** Invoice Items Validation ***

Test No Invoice Items Shows Error
    [Documentation]    Verify that form without invoice items displays error.
    [Tags]    ui    invoice    negative    p1    validation    items
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    # Attempt to save without items
    Click Invoice Save And Trigger Validation
    Wait For Elements State    ${ADMIN_INVOICES_FORM_NO_ITEMS_ERROR_TEXTAREA}    visible    timeout=5s
    [Teardown]    Close Browser

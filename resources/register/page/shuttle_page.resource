*** Settings ***
Documentation     Page object for shuttle company registration
Resource          ../../../common.resource

*** Keywords ***

# === NAVIGATION ===
# NOTE: Navigate To Sign Up Page is defined in driver_page.resource and reused here

Select Shuttle Company Role
    [Documentation]    Selects Shuttle Company role and proceeds to registration form.
    ...
    ...    Clicks the Shuttle Company checkbox and then the Select button
    ...    to start the shuttle company registration process.
    Log Action    Selecting Shuttle Company role
    Click Element    ${SIGN_UP_SHUTTLE_COMPANY_CHECKBOX}    Shuttle Company checkbox
    Click Element    ${SIGN_UP_SELECT_BUTTON}    Select button
    Wait For Load State    networkidle
    Wait Element Ready    ${FIRST_PAGE_REGISTER_SH_NAME_INPUT}

# === FIRST PAGE - Personal Information ===

Fill SH First Name
    [Documentation]    Fills the shuttle company representative's first name using FakerLibrary.
    ...
    ...    Returns:
    ...        ${first_name} - Generated first name (e.g., "John", "Marie")
    Log Action    Filling first name
    ${first_name}=    Name
    Fill Field    ${FIRST_PAGE_REGISTER_SH_NAME_INPUT}    ${first_name}    First name input
    Log Data    Generated first name    ${first_name}
    RETURN    ${first_name}

Fill SH Last Name
    [Documentation]    Fills the shuttle company representative's last name using FakerLibrary.
    ...
    ...    Returns:
    ...        ${last_name} - Generated last name (e.g., "Smith", "Johnson")
    Log Action    Filling last name
    ${last_name}=    Last Name
    Fill Field    ${FIRST_PAGE_REGISTER_SH_LAST_NAME_INPUT}    ${last_name}    Last name input
    Log Data    Generated last name    ${last_name}
    RETURN    ${last_name}

Select Random Dial Code SH
    [Documentation]    Selects a random country dial code from the dropdown.
    ...
    ...    Returns:
    ...        ${dial} - Selected dial code (e.g., "+420", "+1", "+49")
    Log Action    Selecting random dial code
    ${dial}=    Select Random Dropdown Value    ${FIRST_PAGE_REGISTER_SH_DIAL_DROPDOWN}    label    ${FALSE}    Dial dropdown
    Log Data    Selected dial code    ${dial}
    RETURN    ${dial}

Fill SH Phone
    [Documentation]    Fills the shuttle company phone number using FakerLibrary.
    ...
    ...    Returns:
    ...        ${phone} - Generated phone number
    Log Action    Filling phone number
    ${phone}=    Phone Number
    Fill Field    ${FIRST_PAGE_REGISTER_SH_PHONE_INPUT}    ${phone}    Phone input
    Log Data    Generated phone    ${phone}
    RETURN    ${phone}

Fill SH Email
    [Documentation]    Fills the shuttle company email address using FakerLibrary.
    ...
    ...    Returns:
    ...        ${email} - Generated email address (e.g., "john.smith@example.com")
    Log Action    Filling email
    ${email}=    Email
    Fill Field    ${FIRST_PAGE_REGISTER_SH_EMAIL_INPUT}    ${email}    Email input
    Log Data    Generated email    ${email}
    RETURN    ${email}

Fill SH Password
    [Documentation]    Fills the password field.
    ...
    ...    Arguments:
    ...        ${password} - Password to use for registration
    [Arguments]    ${password}
    Log Action    Filling password
    Fill Field    ${FIRST_PAGE_REGISTER_SH_PASSWORD_INPUT}    ${password}    Password input

Fill SH Confirm Password
    [Documentation]    Fills the password confirmation field.
    ...
    ...    Arguments:
    ...        ${password} - Password to confirm (must match password)
    [Arguments]    ${password}
    Log Action    Filling confirm password
    Fill Field    ${FIRST_PAGE_REGISTER_SH_CONFIRMED_PASSWORD_INPUT}    ${password}    Confirm password input

Accept Terms Of Use SH
    [Documentation]    Checks the Terms of Use checkbox to accept the terms.
    Log Action    Accepting terms of use
    Wait Element Ready    ${FIRST_PAGE_REGISTER_SH_TERMS_OF_USE_CHECKBOX}
    Check Checkbox    ${FIRST_PAGE_REGISTER_SH_TERMS_OF_USE_CHECKBOX}

Click First Page Next Button SH
    [Documentation]    Clicks Next button on the first page and waits for third page
    ...    Note: Shuttle Company skips second page (Languages) and goes directly to Business Details
    Log Action    Clicking Next button on first page
    Click Element    ${FIRST_PAGE_REGISTER_SH_NEXT_BUTTON}    Next button
    Wait For Load State    networkidle
    # Wait for third page (Business Details) to load - Shuttle Company has no second page
    Wait Element Ready    ${THIRD_PAGE_REGISTER_SH_COUNTRY_DROPDOWN}

Fill First Page Registration SH
    [Documentation]    Complete filling of the first registration page for Shuttle Company
    [Arguments]    ${password}
    Log Workflow Start    First Page Registration - Shuttle Company
    ${first_name}=    Fill SH First Name
    ${last_name}=    Fill SH Last Name
    ${dial}=    Select Random Dial Code SH
    ${phone}=    Fill SH Phone
    ${email}=    Fill SH Email
    Fill SH Password    ${password}
    Fill SH Confirm Password    ${password}
    Accept Terms Of Use SH
    Click First Page Next Button SH
    Log Workflow End    First Page Registration - Shuttle Company
    RETURN    ${first_name}    ${last_name}    ${email}    ${dial}    ${phone}

# === SECOND PAGE - SKIPPED for Shuttle Company ===
# Shuttle Company does NOT have Languages & Experience page
# Goes directly from Page 1 (Personal) to Page 3 (Business)

# === THIRD PAGE - Business Details ===

Select Random Country SH
    [Documentation]    Selects random country from dropdown
    Log Action    Selecting random country
    ${country}=    Select Random Dropdown Value    ${THIRD_PAGE_REGISTER_SH_COUNTRY_DROPDOWN}    label    ${TRUE}    Country dropdown
    Log Data    Selected country    ${country}
    RETURN    ${country}

Fill Business Number SH
    [Documentation]    Fills business number (IČO) using Python function generate_ico()
    Log Action    Filling business number (IČO)
    ${ico}=    generate_ico
    Fill Field    ${THIRD_PAGE_REGISTER_SH_BUSINESS_NUMBER_INPUT}    ${ico}    Business number input
    RETURN    ${ico}

Check VAT Payer SH
    [Documentation]    Checks the VAT payer checkbox
    Log Action    Checking VAT payer checkbox
    Click Element    ${THIRD_PAGE_REGISTER_SH_VAT_PAYER_CHECKBOX}    VAT payer checkbox

Fill VAT Number SH
    [Documentation]    Fills VAT number (DIČ) using Python function generate_vat_number()
    [Arguments]    ${country_code}=CZ
    Log Action    Filling VAT number (DIČ)
    ${vat}=    generate_vat_number    ${country_code}
    Fill Field    ${THIRD_PAGE_REGISTER_SH_VAT_NUMBER_INPUT}    ${vat}    VAT number input
    Log Data    Generated VAT number    ${vat}
    RETURN    ${vat}

Fill Business Name SH
    [Documentation]    Fills business name using FakerLibrary
    Log Action    Filling business name
    ${business_name}=    Company
    Fill Field    ${THIRD_PAGE_REGISTER_SH_BUSINESS_NAME_INPUT}    ${business_name}    Business name input
    Log Data    Generated business name    ${business_name}
    RETURN    ${business_name}

Fill Business Address SH
    [Documentation]    Fills business address using FakerLibrary
    Log Action    Filling business address
    ${address}=    Street Address
    Fill Field    ${THIRD_PAGE_REGISTER_SH_BUSINESS_ADDRESS_INPUT}    ${address}    Business address input
    Log Data    Generated address    ${address}
    RETURN    ${address}

Fill Business City SH
    [Documentation]    Fills business city using FakerLibrary
    Log Action    Filling business city
    ${city}=    City
    Fill Field    ${THIRD_PAGE_REGISTER_SH_BUSINESS_CITY_INPUT}    ${city}    Business city input
    Log Data    Generated city    ${city}
    RETURN    ${city}

Fill Zip Code SH
    [Documentation]    Fills zip code using FakerLibrary
    Log Action    Filling zip code
    ${zip}=    Zipcode
    Fill Field    ${THIRD_PAGE_REGISTER_SH_ZIP_CODE_INPUT}    ${zip}    Zip code input
    Log Data    Generated zip code    ${zip}
    RETURN    ${zip}

Fill IBAN SH
    [Documentation]    Fills IBAN using Python function generate_valid_czech_iban()
    Log Action    Filling IBAN
    ${iban}=    generate_valid_czech_iban
    Fill Field    ${THIRD_PAGE_REGISTER_SH_IBAN_INPUT}    ${iban}    IBAN input
    RETURN    ${iban}

Fill BIC SH
    [Documentation]    Fills BIC using FakerLibrary
    Log Action    Filling BIC
    ${bic}=    Pystr
    Fill Field    ${THIRD_PAGE_REGISTER_SH_BIC_INPUT}    ${bic}    BIC input
    Log Data    Generated BIC    ${bic}
    RETURN    ${bic}

Click Finish Button SH
    [Documentation]    Clicks Finish button
    Log Action    Clicking Finish button
    Click Element    ${THIRD_PAGE_REGISTER_SH_FINISH_BUTTON}    Finish button

Fill Third Page Registration SH
    [Documentation]    Complete filling of the third registration page for Shuttle Company
    Log Workflow Start    Third Page Registration - Shuttle Company
    ${country}=    Select Random Country SH
    ${ico}=    Fill Business Number SH
    Log Data    Generated IČO    ${ico}
    ${business_name}=    Fill Business Name SH
    ${address}=    Fill Business Address SH
    ${city}=    Fill Business City SH
    ${zip}=    Fill Zip Code SH
    ${iban}=    Fill IBAN SH
    Log Data    Generated IBAN    ${iban}
    ${bic}=    Fill BIC SH
    Click Finish Button SH
    Log Workflow End    Third Page Registration - Shuttle Company
    RETURN    ${ico}    ${business_name}    ${iban}

# === VERIFICATION ===

Verify Registration Success SH
    [Documentation]    Verifies successful registration - message about verification email sent
    Log Action    Verifying registration success
    Wait Element Ready    ${REGISTER_SH_FINISH_PAGE_EMAIL_TEXTAREA}
    ${message}=    Get Element Text    ${REGISTER_SH_FINISH_PAGE_EMAIL_TEXTAREA}    Success message
    Should Contain    ${message}    ${REGISTER_SH_FINISH_PAGE_EMAIL_TEXT_FOR_VERIFY}
    Log Verification    Registration completed - verification email sent

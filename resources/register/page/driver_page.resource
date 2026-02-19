*** Settings ***
Documentation     Page object for driver registration
Resource    ../../../common.resource

*** Keywords ***

# === NAVIGATION ===

Navigate To Sign Up Page
    [Documentation]    Navigates to the Sign Up page.
    ...
    ...    Clicks the Sign Up button on the login page to open registration.
    Log Action    Navigating to Sign Up page
    Click Element    ${MAIN_REGISTER_BUTTON}    Sign Up button

Select Driver Role
    [Documentation]    Selects Driver role and proceeds to registration form.
    ...
    ...    Clicks the Driver checkbox and then the Select button
    ...    to start the driver registration process.
    Log Action    Selecting Driver role
    Click Element    ${SIGN_UP_DRIVER_CHECKBOX}    Driver checkbox
    Click Element    ${SIGN_UP_SELECT_BUTTON}    Select button
    Wait For Load State    networkidle
    Wait Element Ready    ${FIRST_PAGE_REGISTER_DRIVER_NAME_INPUT}

# === FIRST PAGE - Personal Information ===

Fill Driver First Name
    [Documentation]    Fills the driver's first name using FakerLibrary.
    ...
    ...    Returns:
    ...        ${first_name} - Generated first name (e.g., "John", "Marie")
    Log Action    Filling first name
    ${first_name}=    Name
    Fill Field    ${FIRST_PAGE_REGISTER_DRIVER_NAME_INPUT}    ${first_name}    First name input
    Log Data    Generated first name    ${first_name}
    RETURN    ${first_name}

Fill Driver Last Name
    [Documentation]    Fills the driver's last name using FakerLibrary.
    ...
    ...    Returns:
    ...        ${last_name} - Generated last name (e.g., "Smith", "Johnson")
    Log Action    Filling last name
    ${last_name}=    Last Name
    Fill Field    ${FIRST_PAGE_REGISTER_DRIVER_LAST_NAME_INPUT}    ${last_name}    Last name input
    Log Data    Generated last name    ${last_name}
    RETURN    ${last_name}

Select Random Dial Code
    [Documentation]    Selects a random country dial code from the dropdown.
    ...
    ...    Returns:
    ...        ${dial} - Selected dial code (e.g., "+420", "+1", "+49")
    Log Action    Selecting random dial code
    ${dial}=    Select Random Dropdown Value    ${FIRST_PAGE_REGISTER_DRIVER_DIAL_DROPDOWN}    label    ${FALSE}    Dial dropdown
    Log Data    Selected dial code    ${dial}
    RETURN    ${dial}

Fill Driver Phone
    [Documentation]    Fills the driver's phone number using FakerLibrary.
    ...
    ...    Returns:
    ...        ${phone} - Generated phone number
    Log Action    Filling phone number
    ${phone}=    Phone Number
    Fill Field    ${FIRST_PAGE_REGISTER_DRIVER_PHONE_INPUT}    ${phone}    Phone input
    Log Data    Generated phone    ${phone}
    RETURN    ${phone}

Fill Driver Email
    [Documentation]    Fills the driver's email address using FakerLibrary.
    ...
    ...    Returns:
    ...        ${email} - Generated email address (e.g., "john.smith@example.com")
    Log Action    Filling email
    ${email}=    Email
    Fill Field    ${FIRST_PAGE_REGISTER_DRIVER_EMAIL_INPUT}    ${email}    Email input
    Log Data    Generated email    ${email}
    RETURN    ${email}

Fill Driver Password
    [Documentation]    Fills the password field.
    ...
    ...    Arguments:
    ...        ${password} - Password to use for registration
    [Arguments]    ${password}
    Log Action    Filling password
    Fill Field    ${FIRST_PAGE_REGISTER_DRIVER_PASSWORD_INPUT}    ${password}    Password input

Fill Driver Confirm Password
    [Documentation]    Fills the password confirmation field.
    ...
    ...    Arguments:
    ...        ${password} - Password to confirm (must match password)
    [Arguments]    ${password}
    Log Action    Filling confirm password
    Fill Field    ${FIRST_PAGE_REGISTER_DRIVER_CONFIRMED_PASSWORD_INPUT}    ${password}    Confirm password input

Accept Terms Of Use
    [Documentation]    Checks the Terms of Use checkbox to accept the terms.
    Log Action    Accepting terms of use
    Wait Element Ready    ${FIRST_PAGE_REGISTER_DRIVER_TERMS_OF_USE_CHECKBOX}
    Check Checkbox    ${FIRST_PAGE_REGISTER_DRIVER_TERMS_OF_USE_CHECKBOX}

Click First Page Next Button
    [Documentation]    Clicks Next button on the first page
    Log Action    Clicking Next button on first page
    Click Element    ${FIRST_PAGE_REGISTER_DRIVER_NEXT_BUTTON}    Next button
    Wait For Load State    networkidle

Fill First Page Registration
    [Documentation]    Complete filling of the first registration page
    [Arguments]    ${password}
    Log Workflow Start    First Page Registration
    ${first_name}=    Fill Driver First Name
    ${last_name}=    Fill Driver Last Name
    ${dial}=    Select Random Dial Code
    ${phone}=    Fill Driver Phone
    ${email}=    Fill Driver Email
    Fill Driver Password    ${password}
    Fill Driver Confirm Password    ${password}
    Accept Terms Of Use
    Click First Page Next Button
    Log Workflow End    First Page Registration
    RETURN    ${first_name}    ${last_name}    ${email}    ${dial}    ${phone}

# === SECOND PAGE ===

Select Random Native Language
    [Documentation]    Selects random native language from dropdown
    Log Action    Selecting random native language
    ${language}=    Select Random Dropdown Value    ${SECOND_PAGE_REGISTER_DRIVER_LANGUAGE_DROPDOWN}    label    ${TRUE}    Language dropdown
    Log Data    Selected native language    ${language}
    RETURN    ${language}

Select Random English Level
    [Documentation]    Selects random English level from dropdown (appears after native language selection)
    Log Action    Selecting random English level
    Wait For Load State    networkidle
    ${level}=    Select Random Dropdown Value    ${SECOND_PAGE_REGISTER_DRIVER_LEVEL_OF_ENGLISH_DROPDOWN}    label    ${TRUE}    English level dropdown
    Log Data    Selected English level    ${level}
    RETURN    ${level}

Click Add New Language Button
    [Documentation]    Clicks the Add New Language button
    Log Action    Clicking Add New Language button
    Click Element    ${SECOND_PAGE_REGISTER_DRIVER_ADD_NEW_LANGUAGE_BUTTON}    Add language button

Select Random Another Language
    [Documentation]    Selects random additional language from dropdown
    Log Action    Selecting random additional language
    Click Add New Language Button
    ${language}=    Select Random Dropdown Value    ${SECOND_PAGE_REGISTER_DRIVER_ANOTHER_LANGUAGE_DROPDOWN}    label    ${TRUE}    Another language dropdown
    Log Data    Selected additional language    ${language}
    RETURN    ${language}

Select Random Driving Experience
    [Documentation]    Selects random driving experience from dropdown
    Log Action    Selecting random driving experience
    ${experience}=    Select Random Dropdown Value    ${SECOND_PAGE_REGISTER_DRIVER_DRIVING_EXPERIENCE_DROPDOWN}    label    ${TRUE}    Driving experience dropdown
    Log Data    Selected driving experience    ${experience}
    RETURN    ${experience}

Fill About Me
    [Documentation]    Fills About Me field using FakerLibrary
    Log Action    Filling About Me
    @{sentences}=    Sentences    nb=3
    ${about_me}=    Catenate    SEPARATOR=${SPACE}    @{sentences}
    Fill Field    ${SECOND_PAGE_REGISTER_DRIVER_ABOUT_ME_INPUT}    ${about_me}    About me input
    Log Data    Generated About Me    ${about_me}
    RETURN    ${about_me}

Click Second Page Next Button
    [Documentation]    Clicks Next button on the second page and waits for third page
    Log Action    Clicking Next button on second page
    Click Element    ${SECOND_PAGE_REGISTER_DRIVER_NEXT_BUTTON}    Next button
    # Wait for third page to load
    Wait For Load State    networkidle
    Wait Element Ready    ${THIRD_PAGE_REGISTER_DRIVER_COUNTRY_DROPDOWN}

Fill Second Page Registration
    [Documentation]    Complete filling of the second registration page
    Log Workflow Start    Second Page Registration
    ${language}=    Select Random Native Language
    ${english_level}=    Select Random English Level
    ${experience}=    Select Random Driving Experience
    Fill About Me
    Click Second Page Next Button
    Log Workflow End    Second Page Registration
    RETURN    ${language}    ${english_level}    ${experience}

# === THIRD PAGE ===

Select Random Country
    [Documentation]    Selects random country from dropdown
    Log Action    Selecting random country
    ${country}=    Select Random Dropdown Value    ${THIRD_PAGE_REGISTER_DRIVER_COUNTRY_DROPDOWN}    label    ${TRUE}    Country dropdown
    Log Data    Selected country    ${country}
    RETURN    ${country}

Fill Business Number
    [Documentation]    Fills business number (IČO) using Python function generate_ico()
    Log Action    Filling business number (IČO)
    ${ico}=    generate_ico
    Fill Field    ${THIRD_PAGE_REGISTER_DRIVER_BUSINESS_NUMBER_INPUT}    ${ico}    Business number input
    RETURN    ${ico}

Check VAT Payer
    [Documentation]    Checks the VAT payer checkbox
    Log Action    Checking VAT payer checkbox
    Click Element    ${THIRD_PAGE_REGISTER_DRIVER_VAT_PAYER_CHECKBOX}    VAT payer checkbox

Fill VAT Number
    [Documentation]    Fills VAT number (DIČ) using Python function generate_vat_number()
    [Arguments]    ${country_code}=CZ
    Log Action    Filling VAT number (DIČ)
    ${vat}=    generate_vat_number    ${country_code}
    Fill Field    ${THIRD_PAGE_REGISTER_DRIVER_VAT_NUMBER_INPUT}    ${vat}    VAT number input
    Log Data    Generated VAT number    ${vat}
    RETURN    ${vat}

Fill Business Name
    [Documentation]    Fills business name using FakerLibrary
    Log Action    Filling business name
    ${business_name}=    Company
    Fill Field    ${THIRD_PAGE_REGISTER_DRIVER_BUSINESS_NAME_INPUT}    ${business_name}    Business name input
    Log Data    Generated business name    ${business_name}
    RETURN    ${business_name}

Fill Business Address
    [Documentation]    Fills business address using FakerLibrary
    Log Action    Filling business address
    ${address}=    Street Address
    Fill Field    ${THIRD_PAGE_REGISTER_DRIVER_BUSINESS_ADDRESS_INPUT}    ${address}    Business address input
    Log Data    Generated address    ${address}
    RETURN    ${address}

Fill Business City
    [Documentation]    Fills business city using FakerLibrary
    Log Action    Filling business city
    ${city}=    City
    Fill Field    ${THIRD_PAGE_REGISTER_DRIVER_BUSINESS_CITY_INPUT}    ${city}    Business city input
    Log Data    Generated city    ${city}
    RETURN    ${city}

Fill Zip Code
    [Documentation]    Fills zip code using FakerLibrary
    Log Action    Filling zip code
    ${zip}=    Zipcode
    Fill Field    ${THIRD_PAGE_REGISTER_DRIVER_ZIP_CODE_INPUT}    ${zip}    Zip code input
    Log Data    Generated zip code    ${zip}
    RETURN    ${zip}

Fill IBAN
    [Documentation]    Fills IBAN using Python function generate_valid_czech_iban()
    Log Action    Filling IBAN
    ${iban}=    generate_valid_czech_iban
    Fill Field    ${THIRD_PAGE_REGISTER_DRIVER_IBAN_INPUT}    ${iban}    IBAN input
    RETURN    ${iban}

Fill BIC
    [Documentation]    Fills BIC using FakerLibrary
    Log Action    Filling BIC
    ${bic}=    Pystr
    Fill Field    ${THIRD_PAGE_REGISTER_DRIVER_BIC_INPUT}    ${bic}    BIC input
    Log Data    Generated BIC    ${bic}
    RETURN    ${bic}

Click Finish Button
    [Documentation]    Clicks Finish button
    Log Action    Clicking Finish button
    Click Element    ${THIRD_PAGE_REGISTER_DRIVER_FINISH_BUTTON}    Finish button

Fill Third Page Registration
    [Documentation]    Complete filling of the third registration page
    Log Workflow Start    Third Page Registration
    ${country}=    Select Random Country
    ${ico}=    Fill Business Number
    Log Data    Generated IČO    ${ico}
    ${business_name}=    Fill Business Name
    ${address}=    Fill Business Address
    ${city}=    Fill Business City
    ${zip}=    Fill Zip Code
    ${iban}=    Fill IBAN
    Log Data    Generated IBAN    ${iban}
    ${bic}=    Fill BIC
    Click Finish Button
    Log Workflow End    Third Page Registration
    RETURN    ${ico}    ${business_name}    ${iban}

# === VERIFICATION ===

Verify Registration Success
    [Documentation]    Verifies successful registration - message about verification email sent
    Log Action    Verifying registration success
    Wait Element Ready    ${REGISTER_FINISH_PAGE_EMAIL_TEXTAREA}
    ${message}=    Get Element Text    ${REGISTER_FINISH_PAGE_EMAIL_TEXTAREA}    Success message
    Should Contain    ${message}    ${REGISTER_FINISH_PAGE_EMAIL_TEXT_FOR_VERIFY}
    Log Verification    Registration completed - verification email sent

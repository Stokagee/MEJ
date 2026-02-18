*** Settings ***
Documentation     Page object for travel agency/hotel registration
Resource          ../../../common.resource

*** Keywords ***

# === NAVIGATION ===
# NOTE: Navigate To Sign Up Page is defined in driver_page.resource and reused here

Select Travel Agency Role
    [Documentation]    Selects Travel Agency/Hotel role and proceeds to registration form.
    ...
    ...    Clicks the Travel Agency/Hotel checkbox and then the Select button
    ...    to start the travel agency registration process.
    Log Action    Selecting Travel Agency/Hotel role
    Click Element    ${SIGN_UP_HOTEL_CHECKBOX}    Travel Agency/Hotel checkbox
    Click Element    ${SIGN_UP_SELECT_BUTTON}    Select button
    Wait For Load State    networkidle
    Wait Element Ready    ${FIRST_PAGE_REGISTER_TA_NAME_INPUT}

# === FIRST PAGE - Personal Information ===

Fill TA First Name
    [Documentation]    Fills the travel agency representative's first name using FakerLibrary.
    ...
    ...    Returns:
    ...        ${first_name} - Generated first name (e.g., "John", "Marie")
    Log Action    Filling first name
    ${first_name}=    Name
    Fill Field    ${FIRST_PAGE_REGISTER_TA_NAME_INPUT}    ${first_name}    First name input
    Log Data    Generated first name    ${first_name}
    RETURN    ${first_name}

Fill TA Last Name
    [Documentation]    Fills the travel agency representative's last name using FakerLibrary.
    ...
    ...    Returns:
    ...        ${last_name} - Generated last name (e.g., "Smith", "Johnson")
    Log Action    Filling last name
    ${last_name}=    Last Name
    Fill Field    ${FIRST_PAGE_REGISTER_TA_LAST_NAME_INPUT}    ${last_name}    Last name input
    Log Data    Generated last name    ${last_name}
    RETURN    ${last_name}

Select Random Dial Code TA
    [Documentation]    Selects a random country dial code from the dropdown.
    ...
    ...    Returns:
    ...        ${dial} - Selected dial code (e.g., "+420", "+1", "+49")
    Log Action    Selecting random dial code
    ${dial}=    Select Random Dropdown Value    ${FIRST_PAGE_REGISTER_TA_DIAL_DROPDOWN}    label    ${FALSE}    Dial dropdown
    Log Data    Selected dial code    ${dial}
    RETURN    ${dial}

Fill TA Phone
    [Documentation]    Fills the travel agency phone number using FakerLibrary.
    ...
    ...    Returns:
    ...        ${phone} - Generated phone number
    Log Action    Filling phone number
    ${phone}=    Phone Number
    Fill Field    ${FIRST_PAGE_REGISTER_TA_PHONE_INPUT}    ${phone}    Phone input
    Log Data    Generated phone    ${phone}
    RETURN    ${phone}

Fill TA Email
    [Documentation]    Fills the travel agency email address using FakerLibrary.
    ...
    ...    Returns:
    ...        ${email} - Generated email address (e.g., "john.smith@example.com")
    Log Action    Filling email
    ${email}=    Email
    Fill Field    ${FIRST_PAGE_REGISTER_TA_EMAIL_INPUT}    ${email}    Email input
    Log Data    Generated email    ${email}
    RETURN    ${email}

Fill TA Password
    [Documentation]    Fills the password field.
    ...
    ...    Arguments:
    ...        ${password} - Password to use for registration
    [Arguments]    ${password}
    Log Action    Filling password
    Fill Field    ${FIRST_PAGE_REGISTER_TA_PASSWORD_INPUT}    ${password}    Password input

Fill TA Confirm Password
    [Documentation]    Fills the password confirmation field.
    ...
    ...    Arguments:
    ...        ${password} - Password to confirm (must match password)
    [Arguments]    ${password}
    Log Action    Filling confirm password
    Fill Field    ${FIRST_PAGE_REGISTER_TA_CONFIRMED_PASSWORD_INPUT}    ${password}    Confirm password input

Accept Terms Of Use TA
    [Documentation]    Checks the Terms of Use checkbox to accept the terms.
    Log Action    Accepting terms of use
    Wait Element Ready    ${FIRST_PAGE_REGISTER_TA_TERMS_OF_USE_CHECKBOX}
    Check Checkbox    ${FIRST_PAGE_REGISTER_TA_TERMS_OF_USE_CHECKBOX}

Click Submit Button TA
    [Documentation]    Clicks Submit button on the first (and only) page.
    ...    Note: Travel Agency registration ENDS here - no more pages!
    Log Action    Clicking Submit button
    Click Element    ${FIRST_PAGE_REGISTER_TA_SUBMIT_BUTTON}    Submit button

Fill First Page Registration TA
    [Documentation]    Complete filling of the first (and only) registration page for Travel Agency.
    ...                This is the ONLY page - registration ends after this!
    [Arguments]    ${password}
    Log Workflow Start    First Page Registration - Travel Agency
    ${first_name}=    Fill TA First Name
    ${last_name}=    Fill TA Last Name
    ${dial}=    Select Random Dial Code TA
    ${phone}=    Fill TA Phone
    ${email}=    Fill TA Email
    Fill TA Password    ${password}
    Fill TA Confirm Password    ${password}
    Accept Terms Of Use TA
    Click Submit Button TA
    Log Workflow End    First Page Registration - Travel Agency
    RETURN    ${first_name}    ${last_name}    ${email}    ${dial}    ${phone}

# === SECOND PAGE - SKIPPED for Travel Agency ===
# Travel Agency does NOT have Languages & Experience page

# === THIRD PAGE - SKIPPED for Travel Agency ===
# Travel Agency does NOT have Business Details page
# Registration ends after personal information!

# === VERIFICATION ===

Verify Registration Success TA
    [Documentation]    Verifies successful registration - message about verification email sent
    Log Action    Verifying registration success
    Wait Element Ready    ${REGISTER_TA_FINISH_PAGE_EMAIL_TEXTAREA}
    ${message}=    Get Element Text    ${REGISTER_TA_FINISH_PAGE_EMAIL_TEXTAREA}    Success message
    Should Contain    ${message}    ${REGISTER_TA_FINISH_PAGE_EMAIL_TEXT_FOR_VERIFY}
    Log Verification    Registration completed - verification email sent

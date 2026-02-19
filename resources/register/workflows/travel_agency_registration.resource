*** Settings ***
Documentation     Workflow keywords for travel agency/hotel registration
Resource          ../../../common.resource

*** Keywords ***

# === COMPLETE REGISTRATION WORKFLOWS ===

Complete Travel Agency Registration Workflow
    [Documentation]    Complete travel agency/hotel registration workflow from start to finish.
    ...
    ...    This workflow performs the entire travel agency registration process:
    ...    1. Opens browser and navigates to the application
    ...    2. Clicks Sign Up and selects Travel Agency/Hotel role
    ...    3. Fills first page (personal information) - THIS IS THE ONLY PAGE!
    ...    4. Verifies successful registration
    ...
    ...    NOTE: Travel Agency registration is the SIMPLEST - only personal info required!
    ...    No language skills page, no business details page.
    ...
    ...    All data is generated randomly using FakerLibrary:
    ...    - Name, email, phone: FakerLibrary
    ...
    ...    Arguments:
    ...        ${password} - Password for the travel agency account (default: Pan123!)
    ...
    ...    Returns:
    ...        ${first_name} - Generated first name
    ...        ${last_name} - Generated last name
    ...        ${dial} - Selected dial code (e.g., "+420")
    ...        ${phone} - Generated phone number
    ...        ${email} - Generated email address (useful for DB verification)
    [Arguments]    ${password}=Pan123!
    Log Workflow Start    Complete Travel Agency Registration

    # Initialize browser
    ${browser}    ${context}    ${page}=    Initialize Browser Session    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}

    # Navigation and role selection
    Navigate To Sign Up Page
    Select Travel Agency Role

    # First page - personal information (THE ONLY PAGE!)
    ${first_name}    ${last_name}    ${email}    ${dial}    ${phone}=    Fill First Page Registration TA    ${password}

    # NOTE: No second or third page for Travel Agency!
    # Registration ends after personal information.

    # Verification
    Verify Registration Success TA

    Log Workflow End    Complete Travel Agency Registration

    RETURN    ${first_name}    ${last_name}    ${dial}    ${phone}    ${email}

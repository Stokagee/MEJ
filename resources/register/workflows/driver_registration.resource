*** Settings ***
Documentation     Workflow keywords for driver registration
Resource    ../../../common.resource

*** Keywords ***

# === COMPLETE REGISTRATION WORKFLOWS ===

Complete Driver Registration Workflow
    [Documentation]    Complete driver registration workflow from start to finish.
    ...
    ...    This workflow performs the entire driver registration process:
    ...    1. Opens browser and navigates to the application
    ...    2. Clicks Sign Up and selects Driver role
    ...    3. Fills first page (personal information)
    ...    4. Fills second page (language skills and experience)
    ...    5. Fills third page (business information)
    ...    6. Verifies successful registration
    ...
    ...    All data is generated randomly using FakerLibrary and Python functions:
    ...    - Name, email, phone: FakerLibrary
    ...    - IČO: generate_ico()
    ...    - IBAN: generate_valid_czech_iban()
    ...
    ...    Arguments:
    ...        ${password} - Password for the driver account (default: Pan123!)
    ...
    ...    Returns:
    ...        ${first_name} - Generated first name
    ...        ${last_name} - Generated last name
    ...        ${dial} - Selected dial code (e.g., "+420")
    ...        ${phone} - Generated phone number
    ...        ${email} - Generated email address (useful for DB verification)
    ...        ${ico} - Generated IČO number
    ...        ${business_name} - Generated business name
    ...        ${iban} - Generated IBAN
    [Arguments]    ${password}=Pan123!
    Log Workflow Start    Complete Driver Registration

    # Initialize browser
    ${browser}    ${context}    ${page}=    Initialize Browser Session    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}

    # Navigation and role selection
    Navigate To Sign Up Page
    Select Driver Role

    # First page - personal information
    ${first_name}    ${last_name}    ${dial}    ${phone}    ${email}=    Fill First Page Registration    ${password}

    # Second page - language skills and experience
    ${language}    ${english_level}    ${experience}=    Fill Second Page Registration

    # Third page - business information
    ${ico}    ${business_name}    ${iban}=    Fill Third Page Registration

    # Verification
    Verify Registration Success

    Log Workflow End    Complete Driver Registration

    RETURN    ${first_name}    ${last_name}    ${dial}    ${phone}    ${email}    ${ico}    ${business_name}    ${iban}

Complete Driver Registration With VAT Workflow
    [Documentation]    Complete driver registration workflow with VAT number (VAT payer).
    ...
    ...    This workflow performs the entire driver registration process
    ...    with the additional step of checking VAT payer and filling DIČ:
    ...    1. Opens browser and navigates to the application
    ...    2. Clicks Sign Up and selects Driver role
    ...    3. Fills first page (personal information)
    ...    4. Fills second page (language skills and experience)
    ...    5. Fills third page (business information) with VAT payer option
    ...    6. Verifies successful registration
    ...
    ...    All data is generated randomly using FakerLibrary and Python functions:
    ...    - Name, email, phone: FakerLibrary
    ...    - IČO: generate_ico()
    ...    - DIČ: generate_vat_number()
    ...    - IBAN: generate_valid_czech_iban()
    ...
    ...    Arguments:
    ...        ${password} - Password for the driver account (default: Pan123!)
    ...        ${country_code} - Country code for VAT number (default: CZ)
    ...
    ...    Returns:
    ...        ${first_name} - Generated first name
    ...        ${last_name} - Generated last name
    ...        ${dial} - Selected dial code (e.g., "+420")
    ...        ${phone} - Generated phone number
    ...        ${email} - Generated email address (useful for DB verification)
    ...        ${ico} - Generated IČO number
    ...        ${vat} - Generated DIČ (VAT number)
    ...        ${iban} - Generated IBAN
    [Arguments]    ${password}=Pan123!    ${country_code}=CZ
    Log Workflow Start    Complete Driver Registration With VAT

    # Initialize browser
    ${browser}    ${context}    ${page}=    Initialize Browser Session    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}

    # Navigation and role selection
    Navigate To Sign Up Page
    Select Driver Role

    # First page - personal information
    ${first_name}    ${last_name}    ${dial}    ${phone}    ${email}=    Fill First Page Registration    ${password}

    # Second page - language skills and experience
    ${language}    ${english_level}    ${experience}=    Fill Second Page Registration

    # Third page - business information with VAT
    ${country}=    Select Random Country
    ${ico}=    Fill Business Number
    Log Data    Generated IČO    ${ico}
    Check VAT Payer
    ${vat}=    Fill VAT Number    ${country_code}
    Log Data    Generated DIČ    ${vat}
    ${business_name}=    Fill Business Name
    Fill Business Address
    Fill Business City
    Fill Zip Code
    ${iban}=    Fill IBAN
    Log Data    Generated IBAN    ${iban}
    Fill BIC
    Click Finish Button

    # Verification
    Verify Registration Success

    Log Workflow End    Complete Driver Registration With VAT

    RETURN    ${first_name}    ${last_name}    ${dial}    ${phone}    ${email}    ${ico}    ${vat}    ${iban}

*** Settings ***
Documentation     Workflow keywords for shuttle company registration
Resource          ../../../common.resource

*** Keywords ***

# === COMPLETE REGISTRATION WORKFLOWS ===

Complete Shuttle Company Registration Workflow
    [Documentation]    Complete shuttle company registration workflow from start to finish.
    ...
    ...    This workflow performs the entire shuttle company registration process:
    ...    1. Opens browser and navigates to the application
    ...    2. Clicks Sign Up and selects Shuttle Company role
    ...    3. Fills first page (personal information)
    ...    4. Fills third page (business information) - NOTE: No second page for SH!
    ...    5. Verifies successful registration
    ...
    ...    All data is generated randomly using FakerLibrary and Python functions:
    ...    - Name, email, phone: FakerLibrary
    ...    - IČO: generate_ico()
    ...    - IBAN: generate_valid_czech_iban()
    ...
    ...    Arguments:
    ...        ${password} - Password for the shuttle company account (default: Pan123!)
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
    Log Workflow Start    Complete Shuttle Company Registration

    # Initialize browser
    ${browser}    ${context}    ${page}=    Initialize Browser Session    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}

    # Navigation and role selection
    Navigate To Sign Up Page
    Select Shuttle Company Role

    # First page - personal information
    ${first_name}    ${last_name}    ${email}    ${dial}    ${phone}=    Fill First Page Registration SH    ${password}

    # NOTE: No second page for Shuttle Company - goes directly to third page!
    # Third page - business information
    ${ico}    ${business_name}    ${iban}=    Fill Third Page Registration SH

    # Verification
    Verify Registration Success SH

    Log Workflow End    Complete Shuttle Company Registration

    RETURN    ${first_name}    ${last_name}    ${dial}    ${phone}    ${email}    ${ico}    ${business_name}    ${iban}

Complete Shuttle Company Registration With VAT Workflow
    [Documentation]    Complete shuttle company registration workflow with VAT number (VAT payer).
    ...
    ...    This workflow performs the entire shuttle company registration process
    ...    with the additional step of checking VAT payer and filling DIČ:
    ...    1. Opens browser and navigates to the application
    ...    2. Clicks Sign Up and selects Shuttle Company role
    ...    3. Fills first page (personal information)
    ...    4. Fills third page (business information) with VAT payer option - NOTE: No second page for SH!
    ...    5. Verifies successful registration
    ...
    ...    All data is generated randomly using FakerLibrary and Python functions:
    ...    - Name, email, phone: FakerLibrary
    ...    - IČO: generate_ico()
    ...    - DIČ: generate_vat_number()
    ...    - IBAN: generate_valid_czech_iban()
    ...
    ...    Arguments:
    ...        ${password} - Password for the shuttle company account (default: Pan123!)
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
    Log Workflow Start    Complete Shuttle Company Registration With VAT

    # Initialize browser
    ${browser}    ${context}    ${page}=    Initialize Browser Session    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}

    # Navigation and role selection
    Navigate To Sign Up Page
    Select Shuttle Company Role

    # First page - personal information
    ${first_name}    ${last_name}    ${email}    ${dial}    ${phone}=    Fill First Page Registration SH    ${password}

    # NOTE: No second page for Shuttle Company - goes directly to third page!
    # Third page - business information with VAT
    ${country}=    Select Random Country SH
    ${ico}=    Fill Business Number SH
    Log Data    Generated IČO    ${ico}
    Check VAT Payer SH
    ${vat}=    Fill VAT Number SH    ${country_code}
    Log Data    Generated DIČ    ${vat}
    ${business_name}=    Fill Business Name SH
    Fill Business Address SH
    Fill Business City SH
    Fill Zip Code SH
    ${iban}=    Fill IBAN SH
    Log Data    Generated IBAN    ${iban}
    Fill BIC SH
    Click Finish Button SH

    # Verification
    Verify Registration Success SH

    Log Workflow End    Complete Shuttle Company Registration With VAT

    RETURN    ${first_name}    ${last_name}    ${dial}    ${phone}    ${email}    ${ico}    ${vat}    ${iban}

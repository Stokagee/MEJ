*** Settings ***
Documentation     Tests for travel agency/hotel registration
...               This test verifies the complete travel agency registration workflow including:
...               - Personal information (1st page): name, phone, email, password
...               - NOTE: Only ONE page for Travel Agency - no language or business details!
...               - Verification of successful registration
Resource          ../../common.resource

*** Variables ***
${PASSWORD}       Pan123!

*** Test Cases ***

Register New Travel Agency
    [Documentation]    Complete registration of a new travel agency/hotel with random values.
    ...
    ...    This is the SIMPLEST registration - only personal info required:
    ...    - First name, Last name
    ...    - Phone (with dial code)
    ...    - Email, Password
    ...    - Terms of Use acceptance
    ...
    ...    Returns: first_name, last_name, dial, phone, email
    [Tags]             e2e    register    positive    p1    travel-agency

    ${email}=    Complete Travel Agency Registration Workflow    ${PASSWORD}

    [Teardown]    Close Browser

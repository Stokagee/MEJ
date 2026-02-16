*** Settings ***
Resource    common.resource

*** Keywords ***
Enter Admin Email
    [Documentation]    Enters email into the email field on the login page
    [Arguments]    ${email}
    Log Action    Entering admin email: ${email}
    Fill Field    ${LOGIN_EMAIL_INPUT}    ${email}    filling email field with --> '${email}' <--

Enter Admin Password
    [Documentation]    Enters password into the password field on the login page
    [Arguments]    ${password}
    Log Action    Entering admin password [MASKED]
    Fill Field    ${LOGIN_PASSWORD_INPUT}    ${password}    filling password field with --> '${ADMIN_EMAIL}' <--

Click Login Button
    [Documentation]    Clicks the login button on the login page
    Log Action    Clicking login button
    Click Element    ${LOGIN_SUBMIT_BUTTON}    clicking the login button

Verify Admin Login Success
    [Documentation]    Verifies that the user is logged in as administrator
    Verify Element Visible    ${MAIN_MAIN_SEARCH_BUTTON}    on dashboard page
    Log Verification    Admin login successful

Enter Driver Email
    [Documentation]    Enters email as driver
    [Arguments]    ${email}
    Log Action    Entering driver email: ${email}
    Fill Field    ${LOGIN_EMAIL_INPUT}    ${email}    filling email field with --> '${email}' <--

Enter Driver Password
    [Documentation]    Enters password into the password field on the login page
    [Arguments]    ${password}
    Log Action    Entering driver password [MASKED]
    Fill Field    ${LOGIN_PASSWORD_INPUT}    ${password}    filling password field with --> '${DRIVER_EMAIL}' <--

Enter Company Email
    [Documentation]    Enters login email as Company ${COMPANY_EMAIL}
    [Arguments]    ${email}
    Log Action    Entering company email: ${email}
    Fill Field    ${LOGIN_EMAIL_INPUT}    ${email}    logging in as Company

Enter Company Password
    [Documentation]    Enters password as Company
    [Arguments]    ${password}
    Log Action    Entering company password [MASKED]
    Fill Field    ${LOGIN_PASSWORD_INPUT}    ${password}



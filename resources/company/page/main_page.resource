*** Settings ***
Resource    ../../../common.resource

*** Keywords ***

Login As Company
    [Documentation]    Creates new window, configures it, opens URL and logs in as Company
    [Arguments]    ${email}    ${password}
    Log Workflow Start    Company Login
    ${company_browser}    ${company_context}    ${company_page}=
    ...    Initialize Browser Session    ${BROWSER }   ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}
    Enter Company Email    ${email}
    Enter Company Password    ${password}
    Click Login Button
    Verify Company Login Success
    Log Workflow End    Company Login
    RETURN    ${company_browser}    ${company_context}    ${company_page}

Verify Company Login Success
    Verify Element Visible    ${COMPANY_MAIN_REQUESTED_TRIPS_BUTTON}
    Log Verification    Company login successful

Navigate To Requested Packages Page As Company
    [Documentation]    Clicks to navigate to Requested Packages page
    Log Action    Navigating to Requested Packages page as Company
    Click Element    ${COMPANY_MAIN_PACKAGES_BUTTON}





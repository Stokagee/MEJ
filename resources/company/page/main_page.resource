*** Settings ***
Resource    ../../../common.resource

*** Keywords ***

Login As Company
    [Documentation]    Creates new window, configures it, opens URL and logs in as Company
    [Arguments]    ${email}    ${password}
    ${company_browser}    ${company_context}    ${company_page}=
    ...    Initialize Browser Session    ${BROWSER }   ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}
    Enter Company Email    ${email}
    Enter Company Password    ${password}
    Click Login Button
    Verify Company Login Success
    RETURN    ${company_browser}    ${company_context}    ${company_page}

Verify Company Login Success
    Verify Element Visible    ${COMPANY_MAIN_REQUESTED_TRIPS_BUTTON}

Navigate To Requested Trips Page As Company
    [Documentation]    Clicks to navigate to Requested trips page
    Click Element    ${COMPANY_MAIN_REQUESTED_TRIPS_BUTTON}

Navigate To Requested Packages Page As Company
    [Documentation]    Clicks to navigate to Requested Packages page
    Click Element    ${COMPANY_MAIN_PACKAGES_BUTTON}





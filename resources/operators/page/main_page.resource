*** Settings ***
Resource    ../../../common.resource

*** Keywords ***

Open New Browser Session As Admin
    [Documentation]    Opens browser, configures it, opens URL and logs in as Admin
    [Arguments]    ${email}    ${password}
    ${admin_browser}    ${admin_context}    ${admin_page}=
    ...    Initialize Browser Session    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}
    Enter Admin Email       ${email}
    Enter Admin Password    ${password}
    Click Login Button
    Verify Admin Login Success
    RETURN    ${admin_browser}    ${admin_context}    ${admin_page}

Navigate To Invoices Page
    [Documentation]    Navigates to Invoices page
    Click Element    ${MAIN_INVOICES_TOP_BUTTON}    navigating to Invoices page




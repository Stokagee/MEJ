*** Settings ***
Resource    ../../../common.resource

*** Keywords ***
Navigate To Tour Routes Page As Admin
    [Documentation]    Navigates to Tour Routes Page as Admin
    Click Element    ${MAIN_WHEREABOUTS_TOP_BUTTON}    clicking Whereabouts Top Button

Open First Tour Route Item As Admin
    [Documentation]    Opens first item in Tour Routes list as Admin
    Click Element    ${ADMIN_TOUR_ROUTES_EDIT_BUTTON}    clicking Edit Button for first item in Tour Routes list

Apply Filter For Pending For Operator Tour Routes
    [Documentation]    Applies filter for Pending For Operator Tour Routes
    Select From Dropdown    ${ADMIN_TOUR_ROUTES_STATE_DROPDOWN}    Pending for operator    text    selecting Pending for operator from State Dropdown

Click Search Button For Tour Routes Filter As Admin
    [Documentation]    Clicks Search Button to apply filter on Tour Routes as Admin
    Click Element    ${ADMIN_TOUR_ROUTES_SEARCH_BUTTON}    clicking Search Button for Tour Routes

Click Accounting Edit Button In Tour Routes As Admin
    [Documentation]    Clicks Accounting Edit Button in Tour Routes as Admin
    Click Element    ${ADMIN_TOUR_ROUTES_ACCOUNTING_EDIT_BUTTON}    clicking Accounting Edit Button in Tour Routes

Click Accounting Save Button In Tour Routes As Admin
    [Documentation]    Clicks Accounting Save Button in Tour Routes as Admin
    Click Element    ${ADMIN_TOUR_ROUTES_ACCOUNTING_SAVE_BUTTON}    clicking Accounting Save Button in Tour Routes

Click Approve Button In Tour Routes As Admin
    [Documentation]    Clicks Approve Button in Tour Routes as Admin
    Click Element    ${ADMIN_TOUR_ROUTES_ACCOUNTING_APPROVE_BUTTON}    clicking Approve Button in Tour Routes

Click Modal Accept Button In Tour Routes As Admin
    [Documentation]    Clicks Modal Accept Button in Tour Routes as Admin
    Click Element    ${ADMIN_TOUR_ROUTES_MODAL_ACCEPT_BUTTON}    clicking Modal Accept Button in Tour Routes

Get WA2 ID From Tour Routes As Admin
    [Documentation]    Gets WA2 ID from Tour Routes as Admin
    ${wa2_id}=    Get Element Text    ${ADMIN_TOUR_ROUTES_WA2_ID_TEXTAREA}    getting WA2 ID from Tour Routes
    RETURN    ${wa2_id}

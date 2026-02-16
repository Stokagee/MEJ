*** Settings ***
Resource    ../../../common.resource

*** Keywords ***

Click Available Button
    [Documentation]    Clicks Available to open two dropdown lists
    Log Action    Clicking Available button for package
    Click Element    ${COMPANY_PACKAGES_AVAILABLE_BUTTON}

Select Random Car
    [Documentation]    Selects random car from list
    Log Action    Selecting random car for package
    Select Random Dropdown Option    ${COMPANY_PACKAGES_CAR_DROPDOWN}    randomly selecting Car

Select Random Driver
    [Documentation]    Selects random driver from list
    Log Action    Selecting random driver for package
    Select Random Dropdown Option    ${COMPANY_PACKAGES_DRIVER_DROPDOWN}    randomly selecting Driver

Enter BID Price As Company
    [Documentation]    Enters BID price
    [Arguments]    ${bid}
    Log Data    Entered BID price    ${bid}
    Fill Field    ${COMPANY_PACKAGES_BID_INPUT}    ${bid}    entering BID as ${COMPANY_EMAIL}

Click Save Button
    [Documentation]    Saves selected driver with car and price
    Log Action    Saving package bid
    Click Element    ${COMPANY_PACKAGES_SAVE_BUTTON}

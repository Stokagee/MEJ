*** Settings ***
Resource    ../../../common.resource

*** Keywords ***

Click Available Button
    [Documentation]    Clicks Available to open two dropdown lists
    Click Element    ${COMPANY_REQUESTED_TRIPS_AVAILABLE_BUTTON}

Select Random Car
    [Documentation]    Selects random car from list
    Select Random Dropdown Option    ${COMPANY_REQUESTED_TRIPS_CAR_DROPDOWN}    randomly selecting Car

Select Random Driver
    [Documentation]    Selects random driver from list
    Select Random Dropdown Option    ${COMPANY_REQUESTED_TRIPS_DRIVER_DROPDOWN}    randomly selecting Driver

Enter BID Price
    [Documentation]    Enters BID price
    [Arguments]    ${bid}
    Fill Field    ${COMPANY_REQUESTED_TRIPS_BID_INPUT}    ${bid}    entering BID as ${COMPANY_EMAIL}

Click Save Button
    [Documentation]    Saves selected driver with car and price
    Click Element    ${COMPANY_REQUESTED_TRIPS_SAVE_BUTTON}

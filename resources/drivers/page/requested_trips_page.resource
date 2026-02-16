*** Settings ***
Resource    ../../../common.resource

*** Keywords ***

Check BID Checkbox
    [Documentation]    Checks checkbox to open input for entering amount
    Log Action    Checking BID checkbox for price offer
    Click Element   ${DRIVER_REQUESTED_TRIPS_BID_CHECKBOX}    checking checkbox

Enter BID Price As Driver
    [Documentation]    After text field appears, enters amount into it
    [Arguments]    ${bid_price}
    Log Data    Entered BID price    ${bid_price}
    Fill Field    ${DRIVER_REQUESTED_TRIPS_BID_INPUT}    ${bid_price}

Confirm Trip By Clicking Available
    [Documentation]    Clicks available to confirm trip which moves it to confirmed trips page
    Log Action    Confirming trip by clicking Available
    Click Element    ${DRIVER_REQUESTED_TRIPS_AVAILABLE_BUTTON}

Verify Browser Switch As Driver
    [Documentation]    Verifies that browser switched correctly
    Verify Element Visible    ${DRIVER_REQUESTED_TRIPS_REJECT_BUTTON}
    Log Verification    Browser switch successful

Click Navigate To Confirmed Trips Page As Driver
    [Documentation]    Clicks to navigate to confirmed trips page as driver
    Log Action    Navigating to Confirmed Trips page
    Click Element    ${DRIVER_CONFIRMED_TRIPS_TOP_BUTTON}

Verify Trip Assigned To Driver
    [Documentation]    Verifies that trip was assigned to driver correctly
    Verify Element Visible    ${DRIVER_CONFIRMED_TRIPS_CANCEL_BUTTON}
    Log Verification    Trip assigned to driver successfully


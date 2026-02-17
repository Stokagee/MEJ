*** Settings ***
Resource    ../../../common.resource

*** Keywords ***

Check BID Checkbox
    [Documentation]    Checks checkbox to open input for entering amount
    Log Action    Checking BID checkbox for price offer
    Click Element   ${DRIVER_REQUESTED_TRIPS_BID_CHECKBOX}    checking checkbox

Verify Browser Switch As Driver
    [Documentation]    Verifies that browser switched correctly
    Verify Element Visible    ${DRIVER_REQUESTED_TRIPS_REJECT_BUTTON}
    Log Verification    Browser switch successful


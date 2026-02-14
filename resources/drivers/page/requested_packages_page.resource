*** Settings ***
Resource    ../../../common.resource

*** Keywords ***

Navigate To Driver Requested Packages Page
    [Documentation]    Navigates to driver requested packages page
    Click Element    ${DRIVER_REQUESTED_PACKAGES_BUTTON}    "Driver Main Requested Packages Button"

Check BID Checkbox In Requested Packages
    [Documentation]    Checks checkbox for price offer (BID) in Requested Packages
    Click Element    ${DRIVER_REQUESTED_PACKAGES_BID_PRICE_CHECKBOX}    "Driver Requested Packages BID Price Checkbox"

Enter BID Price As Driver In Packages
    [Documentation]    Enters price for offer (BID) in Requested Packages
    [Arguments]    ${bid_price}
    Fill Field    ${DRIVER_REQUESTED_PACKAGES_BID_PRICE_INPUT}    ${bid_price}    "Driver Requested Packages BID Price Input"

Click Available Button As Driver
    [Documentation]    Clicks Available button in Requested Packages
    Click Element    ${DRIVER_REQUESTED_PACKAGES_AVAILABLE_BUTTON}    "Driver Requested Packages Available Button"

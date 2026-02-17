*** Settings ***
Resource    ../../../common.resource

*** Keywords ***

Navigate To Driver Requested Packages Page
    [Documentation]    Navigates to driver requested packages page
    Log Action    Navigating to Requested Packages page
    Click Element    ${DRIVER_REQUESTED_PACKAGES_BUTTON}    "Driver Main Requested Packages Button"

Check BID Checkbox In Requested Packages
    [Documentation]    Checks checkbox for price offer (BID) in Requested Packages
    Log Action    Checking BID checkbox for price offer
    Click Element    ${DRIVER_REQUESTED_PACKAGES_BID_PRICE_CHECKBOX}    "Driver Requested Packages BID Price Checkbox"

Enter BID Price As Driver In Packages
    [Documentation]    Enters price for offer (BID) in Requested Packages
    [Arguments]    ${bid_price}
    Log Data    Entered BID price for package    ${bid_price}
    Fill Field    ${DRIVER_REQUESTED_PACKAGES_BID_PRICE_INPUT}    ${bid_price}    "Driver Requested Packages BID Price Input"

Click Available Button As Driver
    [Documentation]    Clicks Available button in Requested Packages
    Log Action    Confirming package by clicking Available
    Click Element    ${DRIVER_REQUESTED_PACKAGES_AVAILABLE_BUTTON}    "Driver Requested Packages Available Button"

Check BID Checkbox And Confirm All Packages
    [Documentation]    Processes all packages waiting for BID using WHILE loop.
    ...                Gets first checkbox each iteration to avoid stale elements.
    [Arguments]    ${bid_price}
    Log Action    Processing all available packages
    VAR    ${has_more}    ${TRUE}

    # Wait for page to load before checking for checkboxes
    Sleep    2

    WHILE    ${has_more} == ${TRUE}    limit=${TIMEOUT}
        # Get fresh count of checkboxes each iteration
        ${checkboxes}=    Get Element Count    ${DRIVER_REQUESTED_PACKAGES_ALL_CHECKBOXES}

        IF    ${checkboxes} == 0
            VAR    ${has_more}    ${FALSE}
            Log    \n---> No more packages to process    console=${LOG_TO_CONSOLE}
        ELSE
            # Get first checkbox only (fresh element)
            ${checkbox}=    Get Element    ${DRIVER_REQUESTED_PACKAGES_FIRST_CHECKBOX}
            ${testid}=      Get Attribute    ${checkbox}    data-testid
            ${index}=       Fetch From Right    ${testid}    -
            Log    \n---> Processing package at index: ${index}    console=${LOG_TO_CONSOLE}

            # Check checkbox
            Click Element    xpath=//input[@data-testid='check-carrier-offer-${index}']    checking BID checkbox for package ${index}
            Sleep    0.5

            # Enter BID price
            Fill Field    ${DRIVER_REQUESTED_PACKAGES_BID_PRICE_INPUT}    ${bid_price}    entering BID price for package ${index}
            Sleep    0.5

            # Click Available
            Click Element    xpath=//button[@data-testid='btn-available-${index}']    clicking Available for package ${index}
            Sleep    1
        END
    END

*** Settings ***
Resource    ../../../common.resource

*** Keywords ***

Click Available Button
    [Documentation]    Clicks Available to open two dropdown lists
    Log Action    Clicking Available button for package
    Click Element    ${COMPANY_PACKAGES_AVAILABLE_BUTTON}

Select Random Car
    [Documentation]    Selects random car from list (skips first placeholder)
    Log Action    Selecting random car for package
    Select Random Dropdown Value    ${COMPANY_PACKAGES_CAR_DROPDOWN}    label    ${TRUE}    selecting Car

Select Random Driver
    [Documentation]    Selects random driver from list (skips first placeholder)
    Log Action    Selecting random driver for package
    Select Random Dropdown Value    ${COMPANY_PACKAGES_DRIVER_DROPDOWN}    label    ${TRUE}    selecting Driver

Enter BID Price As Company
    [Documentation]    Enters BID price
    [Arguments]    ${bid}
    Log Data    Entered BID price    ${bid}
    Fill Field    ${COMPANY_PACKAGES_BID_INPUT}    ${bid}    entering BID as ${COMPANY_EMAIL}

Click Save Button
    [Documentation]    Saves selected driver with car and price
    Log Action    Saving package bid
    Click Element    ${COMPANY_PACKAGES_SAVE_BUTTON}

Process All Available Packages As Company
    [Documentation]    Processes all available packages using WHILE loop.
    ...                Gets first available button each iteration to avoid stale elements.
    [Arguments]    ${bid_price}
    Log Action    Processing all available packages as Company
    VAR    ${has_more}    ${TRUE}

    # Wait for page to load before checking for buttons
    Sleep    2

    WHILE    ${has_more} == ${TRUE}    limit=${TIMEOUT}
        # Get fresh count of buttons each iteration
        ${buttons}=    Get Element Count    ${COMPANY_PACKAGES_ALL_AVAILABLE_BUTTONS}

        IF    ${buttons} == 0
            VAR    ${has_more}    ${FALSE}
            Log    \n---> No more packages to process    console=${LOG_TO_CONSOLE}
        ELSE
            # Get first button only (fresh element)
            ${button}=    Get Element    ${COMPANY_PACKAGES_FIRST_AVAILABLE_BUTTON}
            ${testid}=     Get Attribute    ${button}    data-testid
            ${index}=      Fetch From Right    ${testid}    -
            Log    \n---> Processing package at index: ${index}    console=${LOG_TO_CONSOLE}

            # Click Available
            Click Element    xpath=//button[@data-testid='btn-available-${index}']    clicking Available for package ${index}
            Sleep    0.5

            # Select Car and Driver
            Select Random Dropdown Value    ${COMPANY_PACKAGES_CAR_DROPDOWN}    label    ${TRUE}    selecting Car for package ${index}
            Sleep    0.5
            Select Random Dropdown Value    ${COMPANY_PACKAGES_DRIVER_DROPDOWN}    label    ${TRUE}    selecting Driver for package ${index}
            Sleep    0.5

            # Enter BID
            Fill Field    ${COMPANY_PACKAGES_BID_INPUT}    ${bid_price}    entering BID for package ${index}

            # Save
            Click Element    ${COMPANY_PACKAGES_SAVE_BUTTON}    saving package ${index}
            Sleep    1
        END
    END

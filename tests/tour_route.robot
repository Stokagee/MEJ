*** Settings ***
Resource    ../common.resource

*** Variables ***
# Tour Route configuration
${time_from}      08:00
${time_to}        17:00
${price}          1000


*** Test Cases ***
Create Tour Route And Accept By Operator And Validate API
    [Documentation]    Creates Tour Route and Accepted by OP and verifies via API that everything is correct.
    ...                Refactored version using workflow keywords and API resource.
    [Tags]    e2e    tour-route    positive    p1

    ${driver_browser}    ${driver_context}    ${driver_page}=
    ...    Open New Browser Session As Driver    ${DRIVER_EMAIL}    ${DRIVER_PASSWORD}
    Click Whereabouts 2 Page As Driver
    Click Create New Tour Route Form

    ${pick_up_adress}    ${to_location}=    Generate Random Journey Locations

    Enter From Location    ${pick_up_adress}
    Enter To Location    ${to_location}
    Select Tomorrow Date
    Select Available From Time    ${time_from}
    Select Available To Time    ${time_to}
    Check Flexible Option
    Enter Offer Price    ${price}
    Submit Tour Route

    ${admin_browser}    ${admin_context}    ${admin_page}=
    ...    Open New Browser Session As Admin    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    Navigate To Tour Routes Page As Admin
    Sleep    2s
    Apply Filter For Pending For Operator Tour Routes
    Click Search Button For Tour Routes Filter As Admin
    Open First Tour Route Item As Admin
    ${tour_route_id}=    Get WA2 ID From Tour Routes As Admin
    Log    \n--->WA2 ID of created tour route: ${tour_route_id}    console=${LOG_TO_CONSOLE}

    FOR    ${attempt}    IN RANGE    5
        Log    \n--->Attempt ${attempt} to approve tour route    console=${LOG_TO_CONSOLE}
        Click Accounting Edit Button In Tour Routes As Admin
        Click Accounting Save Button In Tour Routes As Admin
        Click Approve Button In Tour Routes As Admin
        ${status}=    Run Keyword And Return Status
        ...    Click Modal Accept Button In Tour Routes As Admin
        IF    ${status}    BREAK
        Sleep    2s
    END

    Switch Browser    ${driver_browser}
    Switch Context    ${driver_context}
    Switch Page    ${driver_page}
    Sleep    3
    Click Requested Trips Page As Driver
    Click Whereabouts 2 Page As Driver
    Approve Tour Route
    Sleep    3

    Verify Tour Route Exists In API    ${tour_route_id}

    [Teardown]    Close Browser

*** Settings ***
Resource    ../../../common.resource

*** Keywords ***

Open New Browser Session As Driver
    [Documentation]    Verifies that user can log in as driver with valid credentials
    [Arguments]    ${email}    ${password}
    ${driver_browser}    ${driver_context}    ${driver_page}=
    ...    Initialize Browser Session    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}
    Enter Driver Email     ${email}
    Enter Driver Password     ${password}
    Click Login Button
    Verify Driver Login Success

    RETURN    ${driver_browser}    ${driver_context}    ${driver_page}

Verify Driver Login Success
    [Documentation]    Verifies that Driver logged in
    Verify Element Visible    ${DRIVER_MAIN_REQTESTED_TRIPS_BUTTON}    failed to login as ${DRIVER_EMAIL}

Click Requested Trips Page As Driver
    [Documentation]    Clicks top button ${DRIVER_MAIN_REQTESTED_TRIPS_BUTTON} to navigate to requests page
    Click Element    ${DRIVER_MAIN_REQTESTED_TRIPS_BUTTON}    clicking "Requested trips"

Click Whereabouts 2 Page As Driver
    [Documentation]    Clicks top button ${DRIVER_MAIN_WHEREABOUTS_TOP_BUTTON} to navigate to Whereabouts 2 page
    Click Element    ${DRIVER_MAIN_WHEREABOUTS_TOP_BUTTON}    clicking "Whereabouts 2"

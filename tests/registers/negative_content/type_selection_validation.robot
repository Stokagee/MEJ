*** Settings ***
Documentation    Type Selection page validation tests.
...              Tests role selection and navigation behavior:
...              - Log In tab navigation
...              - Select without role (silent failure)
...              - Role radio buttons visibility
Resource         ../../../common.resource

*** Test Cases ***

Test Select Without Role Silent Failure
    [Documentation]    Select button without role selection does nothing (silent failure).
    ...                Expected: User stays on type selection page, no navigation
    [Tags]    ui    register    negative    p1
    [Setup]    Initialize Browser Session    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}
    Click Element    ${MAIN_REGISTER_BUTTON}    Sign Up button
    Wait Element State    ${SIGN_UP_DRIVER_CHECKBOX}
    Click Element    ${SIGN_UP_SELECT_BUTTON}    Select button (without role)
    Verify Still On Type Selection Page
    [Teardown]    Close Browser

Test All Role Radio Buttons Visible
    [Documentation]    All three role radio buttons are visible on type selection page.
    ...                Expected: Driver, Shuttle Company, Travel Agency/Hotel all visible
    [Tags]    ui    register    positive    p1
    [Setup]    Initialize Browser Session    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}
    Click Element    ${MAIN_REGISTER_BUTTON}    Sign Up button
    Verify Element Visible    ${SIGN_UP_DRIVER_CHECKBOX}    Driver checkbox
    Verify Element Visible    ${SIGN_UP_SHUTTLE_COMPANY_CHECKBOX}    Shuttle Company checkbox
    Verify Element Visible    ${SIGN_UP_HOTEL_CHECKBOX}    Travel Agency checkbox
    [Teardown]    Close Browser

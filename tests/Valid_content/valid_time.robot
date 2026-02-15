*** Settings ***
Resource    ../../common.resource

*** Variables ***
${pick_up_time}        10:00
${first_pick_up}       karvina
${drop_off_address}    praha
${stop_duration_for_verify}    15

*** Test Cases ***
Open And Validate Expected Time After Filling Locations
    [Documentation]    Test that expected time has a value after selecting addresses and saving time.
    [Tags]    ui    journey    positive    p2    time    expected_time_validation
    [Setup]    Open Browser And Navigate To Journey Form
    Sleep    2
    Enter Pickup Time    pick_up_time=${pick_up_time}
    Save Form Left Section
    Confirm Time Change Modal
    Fill And Save Locations Section      ${first_pick_up}    ${drop_off_address}
    Sleep    2
    ${expected_time}=    Get Element Text    ${JOURNEYS_FORM_REQUEST_TIME_TEXTAREA}
    Should Not Be Empty    ${expected_time}    msg=Expected time is empty after filling locations and saving time
    Should Match Regexp    ${expected_time}    \\d+    msg=Expected time does not have HH:MM format
    Log    \n Expected time is: \n \n------ \n ${expected_time} \n------    console=${LOG_TO_CONSOLE}
    [Teardown]    Close Browser

Open And Validate Pick Up Time
    [Documentation]    Test that pick up time has a value after selecting addresses and saving time.
    [Tags]    ui    journey    positive    p2    time    pick_up_time_validation
    [Setup]    Open Browser And Navigate To Journey Form
    Sleep    2
    Enter Pickup Time    pick_up_time=${pick_up_time}
    Save Form Left Section
    Confirm Time Change Modal
    sleep    2
    ${pick_up_time_for_verify}=    Get Element Text    ${JOURNEYS_FORM_REQUEST_PICK_UP_TIME_TEXTAREA}
    Should Not Be Empty    ${pick_up_time_for_verify}    msg=Pick up time
    Should Match Regexp    ${pick_up_time_for_verify}    \\d+    msg=Pick up time does not have HH:MM format
    [Teardown]    Close Browser

Open And Validate Time In Pick Up Address
    [Documentation]    Test that time in pick up address has a value after selecting addresses and saving time.
    [Tags]    ui    journey    positive    p2    time    pick_up_address_time_validation
    [Setup]    Open Browser And Navigate To Journey Form
    Sleep    2
    Enter Pickup Time    pick_up_time=${pick_up_time}
    Save Form Left Section
    Confirm Time Change Modal
    Fill And Save Locations Section      ${first_pick_up}    ${drop_off_address}
    Sleep    2
    ${expected_time}=    Get Element Text    ${JOURNEY_FORM_REQUEST_PICKUP_TIME_TEXTAREA}
    Should Not Be Empty    ${expected_time}    msg=Expected time is empty after filling locations and saving time
    Should Match Regexp    ${expected_time}    \\d+    msg=Expected time does not have HH:MM format
    Log    \n Expected time is: \n \n------ \n ${expected_time} \n------    console=${LOG_TO_CONSOLE}
    [Teardown]    Close Browser

Open And Validate Time In Drop Off Address
    [Documentation]    Test that time in drop off address has a value after selecting addresses and saving time.
    [Tags]    ui    journey    positive    p2    time    drop_off_address_time_validation
    [Setup]    Open Browser And Navigate To Journey Form
    Sleep    2
    Enter Pickup Time    pick_up_time=${pick_up_time}
    Save Form Left Section
    Confirm Time Change Modal
    Fill And Save Locations Section      ${first_pick_up}    ${drop_off_address}
    Sleep    2
    ${expected_time}=    Get Element Text    ${JOURNEY_FORM_REQUEST_DROP_OFF_TIME_TEXTAREA}
    Should Not Be Empty    ${expected_time}    msg=Expected time is empty after filling locations and saving time
    Should Match Regexp    ${expected_time}    \\d+    msg=Expected time does not have HH:MM format
    Log    \n Expected time is: \n \n------ \n ${expected_time} \n------    console=${LOG_TO_CONSOLE}
    [Teardown]    Close Browser

Open And Validate Time In Stops And Duration
    [Documentation]    Test that time in stops has a value after selecting addresses and saving time.
    [Tags]    ui    journey    positive    p2    time    stops_time_validation
    [Setup]    Open Browser And Navigate To Journey Form
    Sleep    2
    Enter Pickup Time    ${pick_up_time}
    Save Form Left Section
    Confirm Time Change Modal
    Fill Locations Section      ${first_pick_up}    ${drop_off_address}
    Add Stop To Journey      stop_address=ostrava    stop_duration=${stop_duration_for_verify}
    Sleep    2
    ${expected_time}=    Get Element Text    ${JOURNEY_FORM_REQUEST_STOP_ADRESS_TEXTAREA}    wanted to get text from stop
    Should Not Be Empty    ${expected_time}    msg=Expected time is empty after filling locations and saving time
    Should Match Regexp    ${expected_time}    \\d+:\\d+    msg=Expected time does not have HH:MM format
    Log    \n Expected time is: \n \n------ \n ${expected_time} \n------    console=${LOG_TO_CONSOLE}
    ${expected_duration}=    Get Element Text    ${JOURNEY_FORM_REQUEST_STOP_ADRESS_DURATION_TEXTAREA}    wanted to get text from duration in stop
    Should Be Equal    ${stop_duration_for_verify} min    ${expected_duration}    msg=Duration in stops does not match the entered value
    Log    \n Expected duration is: \n \n------ \n ${expected_duration} min \n------    console=${LOG_TO_CONSOLE}
    [Teardown]    Close Browser

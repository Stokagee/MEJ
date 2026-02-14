*** Settings ***
Resource    ../../common.resource

*** Variables ***
${pick_up_time}        10:00
${passengers_count}    2
${bokun_amount}        500
${bokun_profit}        250
${driver_amount}       50
${driver_profit}       ${EMPTY}

${pick_up_adress}      karviná
${dropp_off_adress}    praha

${driver_bid_price}    500
${company_bid_price}    750


*** Test Cases ***
Valid Login As Admin
    [Documentation]    Verifies that user can log in as administrator with valid credentials
    [Tags]    e2e    journey    positive    p1
    ${note_for_dri}=    Sentences
    ${note_for_op}=     Sentences
    ${passangers_name}=    Name
    ${passangers_surname}=    Last Name
    ${passangers_phone}=    Phone Number
    ${passangers_email}=    Email
    ${product_note}=    Sentences

    ${admin_browser}    ${admin_context}    ${admin_page}=
    ...    Open New Browser Session As Admin    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    Navigate To Journeys Page
    Open New Journey Form
    Click Edit All Button
    Select Journey Type
    Sleep    1
    Enter Pickup Time                            ${pick_up_time}
    Enter Passenger Count                          ${passengers_count}
    Select Car Type
    Enter Operator Note                        ${note_for_op}
    Enter Driver Note                           ${note_for_dri}
    Check Passenger Whatsapp Checkbox
    Enter Passenger First Name                           ${passangers_name}
    Enter Passenger Last Name                       ${passangers_surname}
    Enter Passenger Phone            ${passangers_phone}
    Enter Passenger Email                     ${passangers_email}
    Check Issue Checkbox
    Save Form Left Section
    Confirm Time Change Modal
    Click Edit Product Order
    Enter Product Note                               ${product_note}
    Save Product Note
    Click Edit Accounting
    Add Bokun Payment
    Sleep    1
    Enter Bokun Amount                           ${bokun_amount}
    Enter Bokun Driver Profit                ${bokun_profit}
    Add Driver Cash Payment
    Sleep    1
    Enter Driver Cash Amount                     ${driver_amount}
    Enter Driver Profit    ${driver_profit}
    Sleep    1
    Save Accounting Section
    Open Location Edit
    Click Change Location
    Enter Exact Pickup Address                     ${pick_up_adress}
    Sleep    2
    Select Pickup From Autocomplete List
    Enter Drop Off City                    ${dropp_off_adress}
    Sleep    2
    Select Drop Off From Autocomplete List
    Save Location Section
    Sleep    1
    Click New Booking
    Sleep    1
    Click Welcome Message Sent
    Open Driver Selection Tab
    Click Search Drivers
    Select MrMPVDriver
    Sleep    2
    Select Shuttle Company
    Sleep    1
    Click Request Now
    Sleep    2
    ${company_browser}    ${company_context}    ${company_page}=
    ...    Login As Company    ${COMPANY_EMAIL}    ${COMPANY_PASSWORD}
    Navigate To Requested Trips Page As Company
    requsted_trips.Click Available Button
    requsted_trips.Select Random Car
    requsted_trips.Select Random Driver
    requsted_trips.Enter BID Price    ${company_bid_price}
    requsted_trips.Click Save Button
    ${driver_browser}    ${driver_context}    ${driver_page}=
    ...    Open New Browser Session As Driver    ${DRIVER_EMAIL}    ${DRIVER_PASSWORD}
    Click Requested Trips Page As Driver
    Check BID Checkbox
    Enter BID Price As Driver    ${driver_bid_price}
    Confirm Trip By Clicking Available
    Switch Context    ${admin_context}
    Open Driver Assignment Tab
    Assign MPVDriver
    Switch Context    ${driver_context}
    Click Navigate To Confirmed Trips Page As Driver
    Verify Trip Assigned To Driver









    Sleep    5




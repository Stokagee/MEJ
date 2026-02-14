*** Settings ***
Documentation    Contains keywords for filling out new journey form
Resource    ../../../common.resource


*** Keywords ***

Fill Definition Section
    [Documentation]    Fills time, passenger count, car type and notes in form
    [Arguments]    ${pick_up_time}    ${passengers_count}    ${note_for_op}    ${note_for_dri}
    Enter Pickup Time                            ${pick_up_time}
    Enter Passenger Count                          ${passengers_count}
    Select Car Type
    Enter Operator Note                        ${note_for_op}
    Enter Driver Note                           ${note_for_dri}

Fill Passengers Section
    [Documentation]    Fills and saves Passengers section in form
    [Arguments]    ${passangers_name}    ${passangers_surname}    ${passangers_phone}    ${passangers_email}
    Check Passenger Whatsapp Checkbox
    Enter Passenger First Name                           ${passangers_name}
    Enter Passenger Last Name                       ${passangers_surname}
    Enter Passenger Phone            ${passangers_phone}
    Enter Passenger Email                     ${passangers_email}

Fill And Save Product Order
    [Documentation]    Fills and saves Product Order Detail section in form
    [Arguments]    ${product_note}
    Enter Product Note                               ${product_note}
    Save Product Note

Fill And Save Accounting Section
    [Documentation]    Fills and saves Accounting section in form
    [Arguments]    ${bokun_amount}    ${bokun_profit}    ${driver_amount}    ${driver_profit}
    Sleep    1
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

Fill And Save Locations Section
    [Documentation]    Fills and saves locations in Locations section in form
    [Arguments]    ${pick_up_adress}    ${dropp_off_adress}
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

Send New Booking And Welcome Message
    [Documentation]    Sends new booking and clicks WM Sent with retry attempts on failure
    ${success}=    Set Variable    ${FALSE}

    WHILE    ${success} == ${FALSE}    limit=${timeout}
        TRY
            Log To Console    \n---> Attempting to click new booking
            Click New Booking
            Click Welcome Message Sent
            Log To Console    \n---> Successfully clicked "New booking"
            ${success}=    Set Variable    ${TRUE}
        EXCEPT
            Log To Console    message
            Sleep    2
        END
    END

    IF    ${success} == ${FALSE}
        Take Screenshot
        Fail    Saving and sending booking failed after repeated attempts within timeout ${timeout}.
    END

Add Stop To Journey
    [Documentation]    Adds stops to journey in form
    [Arguments]    ${stop_adress}    ${stop_duration}
    Click Add Stop In Form
    Enter Stop Address                             ${stop_adress}
    Sleep    2
    Select Stop From Autocomplete List
    Enter Stop Duration                      ${stop_duration}
    Sleep    3
    Save Location Section

Fill Locations Section
    [Documentation]    Fills and saves locations in Locations section in form
    [Arguments]    ${pick_up_adress}    ${dropp_off_adress}
    Open Location Edit
    Click Change Location
    Enter Exact Pickup Address                     ${pick_up_adress}
    Sleep    2
    Select Pickup From Autocomplete List
    Enter Drop Off City                    ${dropp_off_adress}
    Sleep    2
    Select Drop Off From Autocomplete List
    Sleep    1

Fill Accounting Bokun Amount Only
    [Documentation]    Fills and saves Accounting section in form for Bokun Amount only
    [Arguments]    ${bokun_amount}
    Click Edit Accounting
    Sleep    1
    Add Bokun Payment
    Sleep    1
    Enter Bokun Amount                           ${bokun_amount}
    Save Accounting Section

Fill Accounting Bokun Profit Only
    [Documentation]    Fills and saves Accounting section in form for Bokun Profit For Driver only
    [Arguments]    ${bokun_profit}
    Click Edit Accounting
    Sleep    1
    Add Bokun Payment
    Sleep    1
    Enter Bokun Driver Profit                ${bokun_profit}
    Save Accounting Section

Fill Accounting Driver Cash Only
    [Documentation]    Fills and saves Accounting section in form for Driver Cash Amount only
    [Arguments]    ${driver_amount}
    Click Edit Accounting
    Sleep    1
    Add Driver Cash Payment
    Sleep    1
    Enter Driver Cash Amount                     ${driver_amount}
    Save Accounting Section

Fill Accounting Driver Profit Only
    [Documentation]    Fills and saves Accounting section in form for Driver Cash Profit only
    [Arguments]    ${driver_profit}
    Click Edit Accounting
    Sleep    1
    Add Driver Cash Payment
    Sleep    1
    Enter Driver Profit    ${driver_profit}
    Save Accounting Section

Fill Accounting MEJ Stripe Only
    [Documentation]    Fills and saves Accounting section in form for MEJ Stripe Amount only
    [Arguments]    ${mej_stripe_amount}
    Click Edit Accounting
    Sleep    1
    Add MEJ Stripe Payment
    Sleep    1
    Enter MEJ Stripe Amount                      ${mej_stripe_amount}
    Save Accounting Section

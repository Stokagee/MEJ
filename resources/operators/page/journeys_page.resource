*** Settings ***
Resource    ../../../common.resource

*** Keywords ***

Navigate To Journeys Page
    [Documentation]    Navigates to Journeys page
    Click Element    ${MAIN_ORDERS_TOP_BUTTON}    navigating to Journeys page

Open New Journey Form
    [Documentation]    Opens new journey form on Journeys page
    Click Element    ${JOURNEYS_CREATE_NEW_JOURNEY_BUTTON}    opening new journey form

Click Edit All Button
    [Documentation]    Clicks Edit all button in bottom left on Journeys page
    Click Element    ${JOURNEYS_EDIT_ALL_BUTTON}    clicking Edit all

Select Journey Type
    [Documentation]    Opens dropdown and randomly selects journey type (not default)
    ${options}=    Get Select Options    ${JOURNEYS_FORM_REQUEST_TYPE_DROPDOWN}
    @{labels}=    Evaluate    [o['label'] for o in ${options}]
    ${first}=    Get From List    ${labels}    0
    Remove Values From List    ${labels}    ${first}
    ${choice}=    Evaluate    random.choice(${labels})    modules=random
    Log To Console    Selected: ${choice}
    Select Options By    ${JOURNEYS_FORM_REQUEST_TYPE_DROPDOWN}    text    ${choice}
    RETURN    ${choice}


Enter Pickup Time
    [Documentation]    Enters pickup time
    [Arguments]    ${pick_up_time}
    Fill Field    ${JOURNEYS_FORM_REQUEST_PICKUP_INPUT}    ${pick_up_time}    entering pickup time

Enter Passenger Count
    [Documentation]    Enters passenger count
    [Arguments]    ${passenger_count}
    Append To Field    ${JOURNEYS_FORM_REQUEST_PASSENGERS_INPUT}    ${passenger_count}    entering passenger count
    RETURN    ${passenger_count}

Select Car Type
    [Documentation]    Opens dropdown and randomly selects car type
    ${options}=    Get Select Options    ${JOURNEYS_FORM_REQUEST_CAR_TYPE_DROPDOWN}
    @{labels}=    Evaluate    [o['label'] for o in ${options}]
    ${first}=    Get From List    ${labels}    0
    Remove Values From List    ${labels}    ${first}
    ${choice}=    Evaluate    random.choice(${labels})    modules=random
    Log To Console   Selected: ${choice}
    Select Options By    ${JOURNEYS_FORM_REQUEST_CAR_TYPE_DROPDOWN}    text    ${choice}
    RETURN    ${choice}

Enter Operator Note
    [Documentation]    Enters random text into note for operator field
    [Arguments]    ${note_for_op}
    Fill Field    ${JOURNEYS_FORM_REQUEST_OPERATOR_NOTE_INPUT}    ${note_for_op}
    RETURN    ${note_for_op}

Enter Driver Note
    [Documentation]    Enters random text into note for driver field
    [Arguments]    ${note_for_dri}
    Fill Field    ${JOURNEYS_FORM_REQUEST_DRIVER_NOTE_INPUT}    ${note_for_dri}
    RETURN    ${note_for_dri}

Enter Passenger First Name
    [Documentation]    Enters passenger first name
    [Arguments]    ${passangers_name}
    Fill Field    ${JOURNEYS_FORM_REQUEST_PASSENGERS_FIRST_NAME_INPUT}    ${passangers_name}
    RETURN    ${passangers_name}

Enter Passenger Last Name
    [Documentation]    Enters passenger last name
    [Arguments]    ${passangers_surname}
    Fill Field    ${JOURNEYS_FORM_REQUEST_PASSENGERS_LAST_NAME_INPUT}    ${passangers_surname}
    RETURN    ${passangers_surname}

Enter Passenger Phone
    [Documentation]    Enters passenger phone number
    [Arguments]    ${passangers_phone}
    Fill Field    ${JOURNEYS_FORM_REQUEST_PASSENGERS_PHONE_INPUT}    ${passangers_phone}
    Log To Console    New phone number: ${passangers_phone}
    RETURN    ${passangers_phone}

Enter Passenger Email
    [Documentation]    Enters passenger email
    [Arguments]    ${passangers_email}
    Fill Field    ${JOURNEYS_FORM_REQUEST_PASSENGERS_EMAIL_INPUT}    ${passangers_email}
    Log To Console    New email: ${passangers_email}
    RETURN    ${passangers_email}

Save Form Left Section
    [Documentation]    Clicks save all button to save changes
    Click Element    ${JOURNEYS_FORM_REQUEST_SAVE_ALL_BUTTON}

Click Edit Product Order
    [Documentation]    Clicks edit product info button (first one on edit)
    Click Element    ${JOURNEY_FORM_REQUEST_PRODUCT_EDIT_BUTTON}

Enter Product Note
    [Documentation]    Enters random text into product note field
    [Arguments]    ${product_note}
    Fill Field    ${JOURNEY_FORM_REQUEST_PRODUCT_NOTE_INPUT}    ${product_note}
    RETURN    ${product_note}

Save Product Note
    [Documentation]    Saves changes in product order
    Click Element    ${JOURNEY_FORM_REQUEST_PRODUCT_SAVE_BUTTON}

Click Edit Accounting
    [Documentation]    Clicks edit accounting button in left section of page
    Click Element    ${JOURNEY_FORM_REQUEST_ACCOUTNING_EDIT_BUTTON}    clicking Edit Accounting

Add Bokun Payment
    [Documentation]    Clicks Bokun button to open 2 inputs for amount entry. Difference goes to MEJ.
    Click Element    ${JOURNEY_FORM_REQUEST_ACCOUTNING_BOKUN_BUTTON}    clicking Bokun button

Enter Bokun Amount
    [Documentation]    Enters amount - total journey amount from which driver profit is subtracted
    [Arguments]    ${bokun_amount}
    Fill Field    ${JOURNEY_FORM_REQUEST_ACCOUTNING_BOKUN_AMOUNT_INPUT}    ${bokun_amount}
    RETURN    ${bokun_amount}

Enter Bokun Driver Profit
    [Documentation]    Enters amount for driver - how much they get for the trip
    [Arguments]    ${bokun_profit}
    Fill Field    ${JOURNEY_FORM_REQUEST_ACCOUTNING_BOKUN_PROFIT_INPUT}    ${bokun_profit}
    RETURN    ${bokun_profit}

Add Driver Cash Payment
    [Documentation]    Clicks Driver cash button to open 2 inputs. For driver to pay or not.
    Click Element    ${JOURNEY_FORM_REQUEST_ACCOUTNING_DRIVER_EDIT_BUTTON}

Enter Driver Cash Amount
    [Documentation]    Enters amount - subtracted from driver and opens new input for cash collecting
    [Arguments]    ${driver_amount}
    Fill Field    ${JOURNEY_FORM_REQUEST_ACCOUTNING_DRIVER_AMOUNT_INPUT}    ${driver_amount}
    RETURN    ${driver_amount}

Enter Driver Profit
    [Documentation]    Enters amount - added to driver and subtracted from ${driver_amount}
    [Arguments]    ${driver_profit}
    Fill Field    ${JOURNEY_FORM_REQUEST_ACCOUTNING_DRIVER_PROFIT_INPUT}    ${driver_profit}
    RETURN    ${driver_profit}

Save Accounting Section
    [Documentation]    Saves data entered for accounting
    Click Element    ${JOURNEY_FORM_REQUEST_ACCOUTNING_SAVE_BUTTON}

Confirm Time Change Modal
    [Documentation]    When time is changed, modal appears. Confirms it.
    Click Element    ${JOURNEY_MODAL_ACCEPT_BUTTON}

Open Location Edit
    [Documentation]    Clicks edit locations button to start editing locations
    Click Element    ${JOURNEY_FORM_REQUEST_LOCATION_EDIT_BUTTON}    clicking edit to edit locations

Click Change Location
    [Documentation]    Clicks change location option
    Click Element    ${JOURNEY_FORM_REQUEST_CHANGE_PICK_UP_ADRESS_BUTTON}    changing from city to local pick up address

Enter Exact Pickup Address
    [Documentation]    Enters exact pickup location address
    [Arguments]    ${pick_up_adress}
    Fill Field    ${JOURNEY_FORM_REQUEST_PICK_UP_INPUT}      ${pick_up_adress}    entering pickup address
    RETURN    ${pick_up_adress}

Select Pickup From Autocomplete List
    [Documentation]    Clicks first option from Google Autocomplete list
    Click Element    ${JOURNEY_FORM_REQUEST_PICK_UP_LIST}    selecting first address from Autocomplete for pickup

Enter Drop Off City
    [Documentation]    Enters city where journey ends - drop off location
    [Arguments]    ${dropp_off_adress}
    Fill Field    ${JOURNEY_FORM_REQUEST_DROP_OFF_INPUT}    ${dropp_off_adress}    entering drop off city

Select Drop Off From Autocomplete List
    [Documentation]    Clicks first option from Google Autocomplete list
    Click Element    ${JOURNEY_FORM_REQUEST_DROPP_OFF_LIST}    selecting first address from Autocomplete for drop off

Save Location Section
    [Documentation]    Clicks save button to save entered location data
    Click Element    ${JOURNEY_FORM_REQUEST_LOCATION_SAVE_BUTTON}    saving location data

Click New Booking
    [Documentation]    Clicks new booking button to open WM=welcome msg sent button
    Click Element    ${JOURNEYS_FORM_REQUEST_NEW_BOOKING_BUTTON}    clicking new booking

Click Welcome Message Sent
    [Documentation]    Clicks WM sent button to open details collected
    Click Element    ${JOURNEYS_FORM_REQUEST_WM_SENT_BUTTON}    clicking WM sent

Open Driver Selection Tab
    [Documentation]    Clicks driver selection to navigate to tab for requesting drivers
    Click Element    ${JOURNEYS_DRIVER_SELECTION_TAB_BUTTON}    navigating to driver selection tab

Click Search Drivers
    [Documentation]    Clicks search button to display list of drivers
    Click Element    ${JOURNEYS_DRIVER_SELECTION_SEARCH_BUTTON}    clicking search button to find drivers

Select MrMPVDriver
    [Documentation]    Finds Mr. Mpv and checks the checkbox
    Click Element    ${JOURNEYS_DRIVER_SELECTION_DRVIER_CHECKBOX}    checking Mr. Mpv

Select Shuttle Company
    [Documentation]    Finds shuttle company and checks the checkbox
    Click Element    ${JOURNEYS_DRIVER_SELECTION_SHUTTLE_COMPANY_CHECKBOX}    checking shuttle company

Click Request Now
    [Documentation]    Clicks request now to immediately send request to all selected drivers
    Click Element    ${JOURNEYS_DRIVER_SELECTION_REQUEST_NOW_BUTTON}    sending request to all at once

Open Driver Assignment Tab
    [Documentation]    Clicks driver assignment tab
    Click Element    ${JOURNEYS_DRIVER_ASSIGNMENT_TAB_BUTTON}    navigating to driver assignment tab

Assign MPVDriver
    [Documentation]    Clicks Assign to assign Mr. Mpv driver
    Click Element    ${JOURNEYS_DRIVER_ASSIGNMENT_TAB_MPV_BUTTON}    assigning MPV driver

Check Issue Checkbox
    [Documentation]    Checks issue checkbox in left form section, shows (!) icon on that order
    Click Element    ${JOURNEYS_FORM_REQUEST_ISSUE_CHECKBOX}    checking issue checkbox

Check Passenger Whatsapp Checkbox
    [Documentation]    Checks whatsapp contact checkbox with passenger
    Click Element    ${JOURNEYS_FORM_REQUEST_PASSENGERS_WHATSAPP_CHECKBOX}    checking whatsapp contact checkbox

Close First Open Form
    [Documentation]    Clicks close button to close first open form
    Click Element    ${JOURNEYS_CLOSE_NEW_JOURNEY_BUTTON}    closing first open form

Save Product ID From Open Form
    [Documentation]    Saves Product ID from open form to variable
    ${product_id}=    Get Text    ${JOURNEY_FORM_REQUEST_PRODUCT_ID_TEXTAREA}
    Log To Console    Product ID is: ${product_id}
    RETURN    ${product_id}

Click Add Stop In Form
    [Documentation]    Clicks add stop button in form
    Click Element    ${JOURNEY_FORM_REQUEST_ADD_STOPS_BUTTON}    adding stop in form

Enter Stop Address
    [Documentation]    Enters stop address in form
    [Arguments]    ${stop_adress}
    Fill Field    ${JOURNEY_FORM_REQUEST_STOP_ADRESS_INPUT}    ${stop_adress}    entering stop address in form

Enter Stop Duration
    [Documentation]    Enters duration time for stop in form
    [Arguments]    ${stop_duration}
    Fill Field    ${JOURNEY_FORM_REQUEST_STOP_ADRESS_DURATION_INPUT}    ${stop_duration}    entering stop duration in form

Select Stop From Autocomplete List
    [Documentation]    Clicks first option from Google Autocomplete list for stops
    Click Element    ${JOURNEY_FORM_REQUEST_STOP_ADRESS_LIST}    selecting first address from Autocomplete for stops

Click Hint Button For Cash Note
    [Documentation]    Clicks hint button to show note for driver cash
    Click Element    ${JOURNEY_HINT_BUTTON}    clicking hint button to show driver cash note

Confirm Modal Ok Button
    [Documentation]    Confirms modal ok button
    Click Element    ${JOURNEY_MODAL_OK_BUTTON}    confirming modal ok button

Add MEJ Stripe Payment
    [Documentation]    Clicks MEJ Stripe button to open input for amount entry
    Click Element    ${JOURNEY_FORM_REQUEST_ACCOUTNING_STRIPE_EDIT_BUTTON}    clicking MEJ Stripe button

Enter MEJ Stripe Amount
    [Documentation]    Enters amount for MEJ Stripe
    [Arguments]    ${mej_stripe_amount}
    Fill Field    ${JOURNEY_FORM_REQUEST_ACCOUTNING_STRIPE_AMOUNT_INPUT}    ${mej_stripe_amount}
    RETURN    ${mej_stripe_amount}




*** Settings ***
Resource    ../../../common.resource

*** Keywords ***

Click Create New Tour Route Form
    [Documentation]    Clicks button to create new tour route
    Click Element    ${TOUR_ROUTES_CREATE_NEW_ROUTE_BUTTON}    clicking "Create new tour route"

Enter From Location
    [Documentation]    Enters from location into input on tour routes page
    [Arguments]    ${from_location}
    Sleep    1
    Fill Field    ${TOUR_ROUTES_FROM_INPUT}    ${from_location}    entering "From" value "${from_location}"
    Sleep    1
    Click Element    ${TOUR_ROUTES_LIST_FIRST_ITEM}    selecting first item from location list

Enter To Location
    [Documentation]    Enters to location into input on tour routes page
    [Arguments]    ${to_location}
    Fill Field    ${TOUR_ROUTES_TO_INPUT}    ${to_location}    entering "To" value "${to_location}"
    Sleep    1
    Click Element    ${TOUR_ROUTES_LIST_FIRST_ITEM}    selecting first item from location list

Select Tomorrow Date
    [Documentation]    Selects tomorrow's date in date picker on tour routes page
    Sleep    1
    ${tomorrow}=    Evaluate    (datetime.datetime.now() + datetime.timedelta(days=1)).strftime('%d-%m-%Y')    modules=datetime
    Log To Console    \n \n------- \n Date entered into date picker: ${tomorrow} \n-------
    Type Into Field   ${TOUR_ROUTES_DATE_PICKER_INPUT}    ${tomorrow}    entering date "${tomorrow}" into date picker
    Keyboard Key    press    Tab


Select Available From Time
    [Documentation]    Selects available from time in time picker
    [Arguments]    ${time_at}
    Fill Field    ${TOUR_ROUTES_TIME_AT_INPUT}    ${time_at}    entering "At" time "08:00"
    Keyboard Key    press    Tab

Select Available To Time
    [Documentation]    Selects available to time in time picker on tour routes page
    [Arguments]    ${time_to}
    Fill Field    ${TOUR_ROUTES_TIME_TO_INPUT}    ${time_to}    entering "To" time "17:00"
    Keyboard Key    press    Tab

Check Flexible Option
    [Documentation]    Checks flexible checkbox on tour routes page
    Click Element    ${TOUR_ROUTES_CHECKBOX_LABEL}    checking "I'm flexible" checkbox

Enter Offer Price
    [Documentation]    Enters offer price on tour routes page
    [Arguments]    ${price}
    Fill Field    ${TOUR_ROUTES_PRICE_INPUT}    ${price}    entering "Price" value "${price}"

Submit Tour Route
    [Documentation]    Confirms tour route creation by clicking submit button
    Click Element    ${TOUR_ROUTES_SUBMIT_BUTTON}    clicking "Submit" button to create tour route

Approve Tour Route
    [Documentation]    Confirms tour route approval by clicking approve button
    Click Element    ${TOUR_ROUTES_APPROVE_BUTTON}    clicking "Approve" button to approve tour route

*** Settings ***
Resource    ../../../common.resource
Resource    ../page/packages_page.resource

*** Keywords ***

Search And Manually Add Journey To Package By ID
    [Documentation]    Clicks on candidate, manually searches journey by ID and adds it to package
    [Arguments]    ${product_id}
    Click Edit Package Candidate
    Click Orders Tab In Package Candidate
    Click Add Journey By Order ID
    Enter Order ID For Adding Journey    ${product_id}
    Click Search Journey By Order ID
    Click Add Journey To Package

Navigate To Detail Tab In Packages Candidate And Open Edit
    [Documentation]    Clicks Detail tab and prepares edit for data entry
    Click Detail Tab In Package Candidate
    Click Edit Package Detail

Fill Detail For New Candidate And Save
    [Documentation]    Fills name, note for Operator & note for Driver
    [Arguments]    ${package_candi_name}    ${pckg_candi_note_for_op}    ${pckg_candi_note_for_dri}
    Enter New Package Name    ${package_candi_name}
    Enter New Note For Operator    ${pckg_candi_note_for_op}
    Enter New Note For Driver    ${pckg_candi_note_for_dri}
    Click Save Candidate Data

Create Package
    [Documentation]    Attempts to create new package from candidate
    ${success}=    Set Variable    ${FALSE}
    WHILE    ${success} == ${FALSE}    limit=${timeout}
        TRY
            Log To Console    \n---> Attempting to click create package
            Click Create Package
            Confirm Accept Modal For Create Package
            Log To Console    \n---> Successfully clicked and created new package
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

Navigate To Packages Tab And Open Edit
    [Documentation]    Navigates to packages tab and opens first edit
    Navigate To Packages Tab
    Open First Edit In Packages

Navigate To Driver Selection Tab In Packages And Search Drivers
    [Documentation]    Navigates to Driver Selection tab in packages and searches drivers
    Navigate To Driver Selection Tab In Packages
    Search Drivers In Packages

Select Driver And Company In Packages And Send Request
    [Documentation]    Checks checkboxes for driver and company and sends request in packages
    Check Driver In Packages
    Check Shuttle Company In Packages
    Click Request Now In Packages

Create Journey With Random Locations
    [Documentation]    Creates new journey with random locations.
    ...                Returns product_id for first order (index 0).
    ...                Available countries: Czech Republic, Germany, Poland, Austria, Slovakia, etc.
    [Arguments]    ${order_index}    ${pick_up_time}    ${passengers_count}    ${bokun_amount}    ${bokun_profit}    ${driver_amount}    ${driver_profit}    ${pickup_country}=Česko    ${dropoff_country}=Německo
    Log To Console    \n---> Starting new order: ${order_index + 1}
    # Generate test data
    ${note_for_dri}=    Sentences
    ${note_for_op}=     Sentences
    ${passangers_name}=    Name
    ${passangers_surname}=    Last Name
    ${passangers_phone}=    Phone Number
    ${passangers_email}=    Email
    ${product_note}=    Sentences
    # Generate random locations
    ${pick_up_adress}    ${dropp_off_adress}=    Generate Random Journey Locations    ${pickup_country}    ${dropoff_country}
    # Create journey
    Open New Journey Form
    Click Edit All Button
    Select Journey Type
    Sleep    1
    Fill Definition Section    ${pick_up_time}    ${passengers_count}    ${note_for_op}    ${note_for_dri}
    Fill Passengers Section    ${passangers_name}    ${passangers_surname}    ${passangers_phone}    ${passangers_email}
    Check Issue Checkbox
    Save Form Left Section
    Sleep    1
    Confirm Time Change Modal
    Click Edit Product Order
    Fill And Save Product Order          ${product_note}
    Click Edit Accounting
    Fill And Save Accounting Section              ${bokun_amount}    ${bokun_profit}    ${driver_amount}    ${driver_profit}
    Fill And Save Locations Section      ${pick_up_adress}    ${dropp_off_adress}
    Send New Booking And Welcome Message
    # Save product_id only for first order
    ${product_id}=    Set Variable    ${EMPTY}
    IF    ${order_index} == 0
        ${product_id}=    Save Product ID From Open Form
        Close First Open Form
    END
    Log To Console    \n---> Completed order ${order_index + 1}.
    RETURN    ${product_id}

Create Multiple Journeys For Package
    [Documentation]    Creates specified number of journeys and returns product_id of first journey.
    ...                Available countries: Czech Republic, Germany, Poland, Austria, Slovakia, etc.
    [Arguments]    ${journey_count}    ${pick_up_time}    ${passengers_count}    ${bokun_amount}    ${bokun_profit}    ${driver_amount}    ${driver_profit}    ${pickup_country}   ${dropoff_country}
    ${product_id}=    Set Variable    ${EMPTY}
    FOR    ${index}    IN RANGE    ${journey_count}
        ${temp_id}=    Create Journey With Random Locations    ${index}    ${pick_up_time}    ${passengers_count}    ${bokun_amount}    ${bokun_profit}    ${driver_amount}    ${driver_profit}    ${pickup_country}    ${dropoff_country}
        IF    ${index} == 0
            ${product_id}=    Set Variable    ${temp_id}
        END
    END
    RETURN    ${product_id}

Complete Package Workflow With Company And Driver
    [Documentation]    Completes package workflow - company and driver confirm request.
    [Arguments]    ${company_email}    ${company_password}    ${company_bid_price}    ${driver_email}    ${driver_password}    ${driver_bid_price}
    # Company part
    ${company_browser}    ${company_context}    ${company_page}=
    ...    Login As Company    ${company_email}    ${company_password}
    Navigate To Requested Packages Page As Company
    requested_packages.Click Available Button
    requested_packages.Select Random Car
    requested_packages.Select Random Driver
    requested_packages.Enter BID Price As Company    ${company_bid_price}
    requested_packages.Click Save Button
    # Driver part
    ${driver_browser}    ${driver_context}    ${driver_page}=
    ...    Open New Browser Session As Driver    ${driver_email}    ${driver_password}
    Navigate To Driver Requested Packages Page
    Check BID Checkbox In Requested Packages
    Enter BID Price As Driver In Packages    ${driver_bid_price}
    Click Available Button As Driver
    Sleep    5s

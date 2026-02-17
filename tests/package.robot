*** Settings ***
Resource    ../common.resource

*** Variables ***
# Journey configuration
${pick_up_time}        10:00
${passengers_count}    2
${bokun_amount}        500
${bokun_profit}        250
${driver_amount}       50
${driver_profit}       ${EMPTY}
${journey_count}       2

# BID configuration
${driver_bid_price}    500
${company_bid_price}   750

# Location configuration
${pickup_country}      Česko
${dropoff_country}     Německo


*** Test Cases ***
Create Package Candidate With Multiple Journeys And Add First Journey By Order ID
    [Documentation]    Creates multiple orders (journeys) and saves first created journey to package candidate by order ID.
    ...                Refactored version using workflow keywords from packages.resource.
    [Tags]    e2e    package    positive    p1

    # 1. Admin login and navigation
    ${admin_browser}    ${admin_context}    ${admin_page}=
    ...    Open New Browser Session As Admin    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    Navigate To Journeys Page

    # 2. Create multiple journeys using workflow
    ${product_id}=    Create Multiple Journeys For Package
    ...    ${journey_count}
    ...    ${pick_up_time}
    ...    ${passengers_count}
    ...    ${bokun_amount}
    ...    ${bokun_profit}
    ...    ${driver_amount}
    ...    ${driver_profit}
    ...    ${pickup_country}
    ...    ${dropoff_country}

    # 3. Create package candidate
    Click Create Package Candidate
    Sleep    2
    Switch Page    NEW
    ${package_candi_name}=         Domain Name
    ${pckg_candi_note_for_op}=     Sentences    2
    ${pckg_candi_note_for_dri}=    Sentences    2

    # 4. Package candidate workflow
    Search And Manually Add Journey To Package By ID    ${product_id}
    Navigate To Detail Tab In Packages Candidate And Open Edit
    Fill Detail For New Candidate And Save    ${package_candi_name}    ${pckg_candi_note_for_op}    ${pckg_candi_note_for_dri}
    Create Package

    # 5. Driver selection workflow
    Navigate To Packages Tab And Open Edit By Name    ${package_candi_name}
    Navigate To Driver Selection Tab In Packages And Search Drivers
    Select Driver And Company In Packages And Send Request

    # 6. Company and Driver confirmation using workflow
    Complete Package Workflow With Company And Driver
    ...    ${COMPANY_EMAIL}
    ...    ${COMPANY_PASSWORD}
    ...    ${company_bid_price}
    ...    ${DRIVER_EMAIL}
    ...    ${DRIVER_PASSWORD}
    ...    ${driver_bid_price}

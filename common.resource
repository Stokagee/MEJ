*** Settings ***
Library    Browser
Library    Collections
Library    String
Library    FakerLibrary
Library    DateTime
Library    RequestsLibrary
Library    DatabaseLibrary
#Library    DebugLibrary
Library    resources/libraries/address_generator.py
Resource    login_locators.resource
Resource    global_variables.resource
Resource    login_page.resource
# *** Admin ***
Resource    resources/operators/locators/main_locators.resource
Resource    resources/operators/page/main_page.resource
Resource    resources/operators/locators/journeys/journeys_locators.resource
Resource    resources/operators/locators/validation_locators.resource
Resource    resources/operators/page/journeys_page.resource
Resource    resources/operators/locators/journeys/driver_selection_locators.resource
Resource    resources/operators/locators/journeys/driver_assignment.resource
Resource    resources/operators/workflows/journey.resource
Resource    resources/operators/locators/packages/candidate_locators.resource
Resource    resources/operators/workflows/packages.resource
Resource    resources/operators/page/packages_page.resource
Resource    resources/operators/locators/packages/packages_locators.resource
Resource    resources/operators/page/validation_page.resource
Resource    resources/operators/locators/validation_locators.resource
Resource    resources/operators/page/tour_routes_page.resource
Resource    resources/operators/locators/tour_routes_locators.resource
Resource    resources/operators/locators/invoices_locators.resource
Resource    resources/operators/page/invoices_page.resource
Resource    resources/operators/workflows/invoices.resource
# *** API ***
Resource    resources/api/tour_route_api.resource
# *** DB ***
# *** Driver ***
Resource    resources/drivers/page/main_page.resource
Resource    resources/drivers/locators/main_locators.resource
Resource    resources/drivers/locators/requested_trips_locators.resource
Resource    resources/drivers/page/requested_trips_page.resource
Resource    resources/drivers/locators/confirmed_trips.resource
Resource    resources/drivers/locators/requested_packages_locators.resource
Resource    resources/drivers/page/requested_packages_page.resource
Resource    resources/drivers/page/tour_routes_page.resource
Resource    resources/drivers/locators/tour_routes_locators.resource
#*** Company ***
Resource    resources/company/locators/main_locators.resource
Resource    resources/company/page/main_page.resource
Resource    resources/company/locators/requested_trips.resource
Resource    resources/company/page/requsted_trips.resource
Resource    resources/company/locators/requsted_packages.resource
Resource    resources/company/page/requested_packages.resource

*** Keywords ***

# === LOGGING KEYWORDS ===

Log Action
    [Documentation]    Logs a user action (clicks, navigation, form submissions).
    ...                Use for: button clicks, page navigation, form submissions, etc.
    [Arguments]    ${action_description}
    Log    \n---> ${action_description}    console=${LOG_TO_CONSOLE}

Log Data
    [Documentation]    Logs data values with consistent formatting.
    ...                Use for: entered values, selected options, retrieved data.
    ...                WARNING: NEVER use for passwords, API keys, or tokens!
    [Arguments]    ${data_type}    ${value}
    Log    \n---> ${data_type}: ${value}    console=${LOG_TO_CONSOLE}

Log Workflow Start
    [Documentation]    Logs the start of a workflow with its name.
    ...                Use at the beginning of complex multi-step operations.
    [Arguments]    ${workflow_name}
    Log    \n======= Starting: ${workflow_name} =======    console=${LOG_TO_CONSOLE}

Log Workflow End
    [Documentation]    Logs the end of a workflow with its name.
    ...                Use at the end of complex multi-step operations.
    [Arguments]    ${workflow_name}
    Log    \n======= Completed: ${workflow_name} =======    console=${LOG_TO_CONSOLE}

Log Verification
    [Documentation]    Logs verification/assertion results.
    ...                Use for: login success checks, element visibility, data validation.
    [Arguments]    ${what_is_verified}    ${result}=OK
    Log    \n---> Verified: ${what_is_verified} [${result}]    console=${LOG_TO_CONSOLE}

# === WAIT KEYWORDS ===

Wait Element State
    [Documentation]    Waits for element to reach specified state with error handling.
    ...                Use for: waiting for elements to be visible, enabled, attached, stable, or hidden.
    ...                States: visible (default), enabled, attached, stable, hidden
    ...                Example: Wait Element State    ${LOCATOR}    visible    ${TIMEOUT}    Filter panel
    [Arguments]    ${selector}    ${state}=visible    ${timeout}=${TIMEOUT}    ${context_name}=${EMPTY}
    TRY
        Wait For Elements State    ${selector}    ${state}    timeout=${timeout}
    EXCEPT    AS    ${err}
        Take Screenshot
        VAR    ${msg}    Failed waiting for element '${context_name}' --> | selector='${selector}' | state='${state}' | ERROR: ${err}
        Fail    ${msg}
    END

# === CORE KEYWORDS ===

Initialize Browser Session
    [Documentation]    Creates a new browser context with the specified settings. All settings are configured in global_variables.resource
    [Arguments]    ${BROWSER}    ${HEADLESS}    ${URL}    ${WIDTH}    ${HEIGHT}
    New Browser    ${BROWSER}    headless=${HEADLESS}
    ${browser_ids}=    Get Browser Ids    ACTIVE  # ← ZMĚNA: vezmi jen aktivní
    VAR    ${browser_id}    ${browser_ids}[0]   
    New Context    ignoreHTTPSErrors=True    viewport={'width':${WIDTH},'height':${HEIGHT}}
    ${context_ids}=    Get Context Ids    ACTIVE  # ← ZMĚNA: pro konkrétní browser
    ${context_id}=     Get From List    ${context_ids}    -1  
    New Page    ${URL}
    ${page_ids}=    Get Page Ids    ACTIVE  # ← ZMĚNA: pro konkrétní browser
    ${page_id}=        Get From List    ${page_ids}    -1     
    RETURN    ${browser_id}    ${context_id}    ${page_id}

Click Element
    [Documentation]    Clicks on an element using the specified selector with optional context name for better error messages
    [Arguments]    ${selector}    ${context_name}=${EMPTY}
    TRY
        Wait For Elements State    ${selector}    attached       ${TIMEOUT}
        Wait For Elements State    ${selector}    visible        ${TIMEOUT}
        Wait For Elements State    ${selector}    enabled        ${TIMEOUT}
        Wait For Elements State    ${selector}    stable         ${TIMEOUT}
        Click    ${selector}
    EXCEPT    AS    ${err}
        Take Screenshot
        VAR    ${msg}    Failed when, '${context_name}' --> | selector='${selector}' | ERROR: ${err}
        Fail    ${msg}
    END

Fill Field
    [Documentation]    Fills the specified text into a field using the given locator with optional context name for better error messages
    [Arguments]    ${locator}    ${text}    ${context_name}=${EMPTY}
    TRY
        Wait For Elements State    ${locator}    attached       ${TIMEOUT}
        Wait For Elements State    ${locator}    visible        ${TIMEOUT}
        Wait For Elements State    ${locator}    enabled        ${TIMEOUT}
        Wait For Elements State    ${locator}    stable         ${TIMEOUT}
        Click    ${locator}
        #Clear Text    ${locator}
        Fill Text    ${locator}    ${text}
    EXCEPT    AS    ${err}
        Take Screenshot
        VAR    ${msg}    Failed when, '${context_name}' --> | locator='${locator}' | ERROR: ${err}
        Fail    ${msg}
    END

Get Element Text
    [Documentation]    Gets text from an element using the specified locator with optional context name for better error messages
    [Arguments]    ${locator}    ${context_name}=${EMPTY}
    VAR    ${text}    ${EMPTY}
    TRY
        Wait For Elements State    ${locator}    attached       ${TIMEOUT}
        Wait For Elements State    ${locator}    visible        ${TIMEOUT}
        Wait For Elements State    ${locator}    enabled        ${TIMEOUT}
        Wait For Elements State    ${locator}    stable         ${TIMEOUT}
        ${text}=    browser.Get Text    ${locator}
    EXCEPT    AS    ${err}
        Take Screenshot
        VAR    ${msg}    Failed when, '${context_name}' --> | locator='${locator}' | ERROR: ${err}
        Fail    ${msg}
    END
    RETURN    ${text}

Verify Element Visible
    [Documentation]    Verifies that an element is present and visible on the page using the specified locator with optional context name for better error messages
    [Arguments]    ${locator}    ${context_name}=${EMPTY}
    TRY
        Wait For Elements State    ${locator}    attached       ${TIMEOUT}
        Wait For Elements State    ${locator}    visible        ${TIMEOUT}
        Wait For Elements State    ${locator}    enabled        ${TIMEOUT}
        Wait For Elements State    ${locator}    stable         ${TIMEOUT}
    EXCEPT    AS    ${err}
        Take Screenshot
        VAR    ${msg}    Failed '${context_name}' --> | locator='${locator}' | ERROR: ${err}
        Fail    ${msg}
    END

Append To Field
    [Documentation]    Appends text to a field without clearing existing content using the specified locator with optional context name for better error messages
    [Arguments]    ${locator}    ${text}    ${context_name}=${EMPTY}
    TRY
        Wait For Elements State    ${locator}    attached       ${TIMEOUT}
        Wait For Elements State    ${locator}    visible        ${TIMEOUT}
        Wait For Elements State    ${locator}    enabled        ${TIMEOUT}
        Wait For Elements State    ${locator}    stable         ${TIMEOUT}
        Click    ${locator}
        Fill Text    ${locator}    ${text}
    EXCEPT    AS    ${err}
        Take Screenshot
        VAR    ${msg}    Failed when, '${context_name}' --> | locator='${locator}' | ERROR: ${err}
        Fail    ${msg}
    END

Select Random Dropdown Option
    [Documentation]    Opens dropdown and randomly selects a car type
    [Arguments]    ${locator}    ${context_name}=${EMPTY}
    TRY
        Wait For Elements State    ${locator}    attached       ${TIMEOUT}
        Wait For Elements State    ${locator}    visible        ${TIMEOUT}
        Wait For Elements State    ${locator}    enabled        ${TIMEOUT}
        Wait For Elements State    ${locator}    stable         ${TIMEOUT}
        ${options}=    Get Select Options    ${JOURNEYS_FORM_REQUEST_CAR_TYPE_DROPDOWN}
        @{labels}=    Evaluate    [o['label'] for o in ${options}]
        ${choice}=    Evaluate    random.choice(${labels})    modules=random
        Log    Selected: ${choice}    console=${LOG_TO_CONSOLE}
        Select Options By    ${JOURNEYS_FORM_REQUEST_CAR_TYPE_DROPDOWN}    text    ${choice}
    EXCEPT    AS    ${err}
        Take Screenshot
        VAR    ${msg}    Failed when, '${context_name}'  --> | locator='${locator}' | ERROR: ${err}



    END


Type Into Field
    [Documentation]    Types text into a field without clicking using the specified locator with optional context name for better error messages
    [Arguments]    ${locator}    ${text}    ${context_name}=${EMPTY}
    TRY
        Type Text    ${locator}    ${text}
    EXCEPT    AS    ${err}
        Take Screenshot
        VAR    ${msg}    Failed when, '${context_name}' --> | locator='${locator}' | ERROR: ${err}
        Fail    ${msg}
    END

Select From Dropdown
    [Documentation]    Universal keyword for selecting from dropdown
    ...                Attribute: text (default), value, index, label
    [Arguments]    ${locator}    ${value}    ${attribute}=text    ${context_name}=${EMPTY}
    TRY
        Wait For Elements State    ${locator}    attached    ${TIMEOUT}
        Wait For Elements State    ${locator}    visible     ${TIMEOUT}
        Wait For Elements State    ${locator}    enabled     ${TIMEOUT}
        Select Options By    ${locator}    ${attribute}    ${value}
    EXCEPT    AS    ${err}
        Take Screenshot
        VAR    ${msg}    Failed when '${context_name}' --> | locator='${locator}' | attribute='${attribute}' | value='${value}' | ERROR: ${err}
        Fail    ${msg}
    END
    RETURN    ${value}

Select Random From List
    [Documentation]    Selects a random item from a list and returns it.
    ...                Parameter skip_first=True skips the first item (useful for dropdowns where first is default/null)
    ...                Usage: ${item}=    Select Random From List    @{list}
    [Arguments]    @{list}    ${skip_first}=${FALSE}
    ${start_index}=    Set Variable If    ${skip_first}    1    0
    ${length}=    Get Length    ${list}
    ${random_index}=    Evaluate    random.randint(${start_index}, ${length} - 1)    modules=random
    ${item}=    Get From List    ${list}    ${random_index}
    RETURN    ${item}

Generate Random Journey Locations
    [Documentation]    Generates random pickup and dropoff locations for a journey.
    ...                Available countries for Ctyri Nahodne Lokace keyword: Czech Republic, Germany, Poland, Austria, Slovakia, etc.
    ...                Usage: ${pickup}    ${dropoff}=    Generate Random Journey Locations    Czech Republic    Germany
    [Arguments]    ${pickup_country}=Česko    ${dropoff_country}=Německo
    @{pickup_list}=    Ctyri Nahodne Lokace    ${pickup_country}
    @{dropoff_list}=    Ctyri Nahodne Lokace    ${dropoff_country}
    ${pick_up_adress}=    Select Random From List    @{pickup_list}
    ${dropp_off_adress}=    Select Random From List    @{dropoff_list}
    Log    \n--->Selected pickup address: ${pick_up_adress}    console=${LOG_TO_CONSOLE}
    Log    \n--->Selected drop-off address: ${dropp_off_adress}    console=${LOG_TO_CONSOLE}
    RETURN    ${pick_up_adress}    ${dropp_off_adress}

Select Random Dropdown Value
    [Documentation]    Selects a random item from a dropdown and returns it.
    ...                Parameter skip_first=True skips the first item (useful where first is default/placeholder)
    ...                Parameter attribute determines selection criteria: text (default), value, index, label
    ...                Usage: ${selected}=    Select Random Dropdown Value    ${locator}
    [Arguments]    ${locator}    ${attribute}    ${skip_first}    ${context_name}=${EMPTY}
    TRY
        Wait For Elements State    ${locator}    attached    ${TIMEOUT}
        Wait For Elements State    ${locator}    visible     ${TIMEOUT}
        Wait For Elements State    ${locator}    enabled     ${TIMEOUT}

        # Get all options from dropdown
          ${options}=    Get Select Options    ${locator}
          @{values}=    Evaluate    [o['${attribute}'] for o in ${options}]

        # Random selection with option to skip first
        ${start_index}=    Set Variable If    ${skip_first}    1    0
        ${length}=    Get Length    ${values}
        ${random_index}=    Evaluate    random.randint(${start_index}, ${length} - 1)    modules=random
        ${selected_value}=    Get From List    ${values}    ${random_index}

        # Perform selection
        Select Options By    ${locator}    ${attribute}    ${selected_value}
        Log    Selected: ${selected_value}    console=${LOG_TO_CONSOLE}
    EXCEPT    AS    ${err}
        Take Screenshot
        VAR    ${msg}    Failed when '${context_name}' --> | locator='${locator}' | attribute='${attribute}' | ERROR: ${err}
        Fail    ${msg}
    END
    RETURN    ${selected_value}
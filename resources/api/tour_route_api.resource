*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource    ../../global_variables.resource

*** Keywords ***

Create Tour Route API Session
    [Documentation]    Creates API session with authentication for Tour Route API.
    ${headers}=    Create Dictionary    ${API_KEY_HEADER}=${API_KEY_VALUE}
    RequestsLibrary.Create Session    alias=tour_route_session    url=${API_BASE_URL}    headers=${headers}
    RETURN    tour_route_session

Get All Accepted Tour Routes From API
    [Documentation]    Gets list of all accepted tour routes from API.
    [Arguments]    ${session_alias}=tour_route_session
    ${response}=    RequestsLibrary.GET On Session    ${session_alias}    /api/TourRoute/accepted
    Should Be Equal As Integers    ${response.status_code}    200
    Log    \n--->API Response: ${response.json()}    console=${LOG_TO_CONSOLE}
    RETURN    ${response.json()}

Verify Tour Route Exists In API
    [Documentation]    Verifies that tour route with given ID exists in API response.
    [Arguments]    ${tour_route_id}
    # Create session
    Create Tour Route API Session
    # Get data from API
    ${data}=    Get All Accepted Tour Routes From API
    # Search for tour route in response
    VAR    ${found}    ${FALSE}
    FOR    ${item}    IN    @{data}
        IF    '${item["orderId"]}' == '${tour_route_id}'
            VAR    ${found}    ${TRUE}
            Log    \n--->Found tour route with ID: ${tour_route_id} in API response.    console=${LOG_TO_CONSOLE}
            BREAK
        END
    END
    Should Be True    ${found}    Tour route with ID: ${tour_route_id} was not found in API response.

Get Tour Route By ID From API
    [Documentation]    Returns tour route object by ID, or NONE if not found.
    [Arguments]    ${tour_route_id}
    # Create session
    Create Tour Route API Session
    # Get data from API
    ${data}=    Get All Accepted Tour Routes From API
    # Search for tour route in response
    FOR    ${item}    IN    @{data}
        IF    '${item["orderId"]}' == '${tour_route_id}'
            RETURN    ${item}
        END
    END
    RETURN    ${NONE}

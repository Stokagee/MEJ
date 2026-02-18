*** Settings ***
Resource    ../../../common.resource

*** Keywords ***

Click Edit Package Candidate
    [Documentation]    Clicks Edit Package Candidate on Package Candidate page
    Log Action    Clicking Edit Package Candidate
    Click Element    ${PACKAGES_CANDIDATE_EDIT_BUTTON}    clicking Edit Package Candidate

Click Orders Tab In Package Candidate
    [Documentation]    Clicks Orders Tab in Package Candidate on Package Candidate page
    Log Action    Clicking Orders Tab in Package Candidate
    Click Element    ${PACKAGES_CANDIDATE_ORDERS_TAB_BUTTON}    clicking Orders Tab in Package Candidate

Click Add Journey By Order ID
    [Documentation]    Clicks Add Journey By Order ID in Package Candidate on Package Candidate page
    Log Action    Clicking Add Journey By Order ID
    Click Element    ${PACKAGES_CANDIDATE_ADD_JOURNEY_ID_BUTTON}    clicking Add Journey By Order ID in Package Candidate

Enter Order ID For Adding Journey
    [Documentation]    Enters Order ID for adding Journey in Package Candidate on Package Candidate page
    [Arguments]    ${order_id}
    Log Data    Order ID    ${order_id}
    Fill Field    ${PACKAGES_CANDIDATE_ADD_JOURNEY_ID_INPUT}    ${order_id}

Click Search Journey By Order ID
    [Documentation]    Clicks Search Journey By Order ID in Package Candidate on Package Candidate page
    Log Action    Clicking Search Journey By Order ID
    Click Element    ${PACKAGES_CANDIDATE_SEARCH_JOURNEY_ID_BUTTON}    clicking Search Journey By Order ID in Package Candidate

Click Add Journey To Package
    [Documentation]    Clicks Add button and adds journey to package
    Log Action    Adding journey to package
    Click Element    ${PACKAGES_CANDIDATE_ADD_JOURNEY_BUTTON}    clicking Add button to manually add journey by ID

Click Detail Tab In Package Candidate
    [Documentation]    Navigates to detail tab in Candidate
    Log Action    Navigating to Detail Tab in Package Candidate
    Click Element    ${PACKAGES_CANDIDATE_DETAIL_TAB_BUTTON}    navigating to detail tab in candidate

Click Create Package
    [Documentation]    Clicks create package to create the package
    Log Action    Clicking Create Package
    Click Element    ${PACKAGES_CANDIDATE_CREATE_PACKAGE_BUTTON}    clicking to create package

Confirm Accept Modal For Create Package
    [Documentation]    Confirms popup modal and creates package
    Log Action    Confirming modal to create package
    Click Element    ${PACKAGES_CANDIDATE_ACCEPT_MODAL}    confirming modal to create package

Click Edit Package Detail
    [Documentation]    Clicks Edit to open editing options
    Log Action    Clicking Edit Package Detail
    Click Element    ${PACKAGES_CANDIDATE_DETAIL_EDIT_BUTTON}    opening edit for detail editing

Enter New Package Name
    [Documentation]    Enters new package name in package detail candidate
    [Arguments]    ${package_candi_name}
    Log Data    Package name    ${package_candi_name}
    Fill Field    ${PACKAGES_CANDIDATE_NAME_INPUT}    ${package_candi_name}    entering new package name in package detail candidate

Enter New Note For Operator
    [Documentation]    Enters new note for operator in package detail candidate
    [Arguments]    ${pckg_candi_note_for_op}
    Log Data    Note for operator    ${pckg_candi_note_for_op}
    Fill Field    ${PACKAGES_CANDIDATE_NOTE_FOR_OPERATOR}    ${pckg_candi_note_for_op}    entering new note for OP in package detail candidate

Enter New Note For Driver
    [Documentation]    Enters new note for driver in package in package detail candidate
    [Arguments]    ${pckg_candi_note_for_dri}
    Log Data    Note for driver    ${pckg_candi_note_for_dri}
    Fill Field    ${PACKAGES_CANDIDATE_NOTE_FOR_DRIVER}    ${pckg_candi_note_for_dri}    entering new note for driver in package detail candidate

Click Save Candidate Data
    [Documentation]    Clicks save to save new data in package candidate
    Log Action    Saving candidate data
    Click Element    ${PACKAGES_CANDIDATE_SAVE}    saving data for candidate in package candidate detail

Click Create Package Candidate
    [Documentation]    Clicks Create Package Candidate with retry.
    ...                Button may not be ready immediately after booking, so retry booking if needed.
    Log Action    Clicking Create Package Candidate
    VAR    ${success}    ${FALSE}

    WHILE    ${success} == ${FALSE}    limit=${TIMEOUT}
        TRY
            Wait Element State    ${JOURNEY_FORM_REQUEST_CREATE_PACKAGE_CANDIDATE_BUTTON}    visible    5    Create Package Candidate button
            Click    ${JOURNEY_FORM_REQUEST_CREATE_PACKAGE_CANDIDATE_BUTTON}
            VAR    ${success}    ${TRUE}
            Log    \n---> Successfully clicked Create Package Candidate    console=${LOG_TO_CONSOLE}
        EXCEPT
            Log    \n---> Create Package Candidate button not ready, retrying booking...    console=${LOG_TO_CONSOLE}
            Click New Booking
            Click Welcome Message Sent
            Sleep    2
        END
    END


Navigate To Packages Tab
    [Documentation]    Navigates to Packages tab from Packages Candidate page
    Log Action    Navigating to Packages tab
    Click Element    ${PACKAGES_PACKAGES_TAB_BUTTON}    navigating to Packages tab

Open First Edit In Packages
    [Documentation]    Opens first edit in packages
    Log Action    Opening first edit in packages
    Click Element    ${PACKAGES_1ST_EDIT_BUTTON}    opening first edit in packages

Open Edit For Package By Name
    [Documentation]    Opens edit for specific package by name with retry.
    ...                Refreshes page if package not found (might not be loaded yet).
    [Arguments]    ${package_name}
    Log Action    Opening edit for package: ${package_name}
    ${locator}=    Format String    ${PACKAGES_EDIT_BY_NAME}    ${package_name}
    VAR    ${success}    ${FALSE}
    VAR    ${attempts}    ${0}

    WHILE    ${success} == ${FALSE}    limit=${TIMEOUT}
        VAR    ${attempts}    ${attempts + 1}
        TRY
            Click Element    ${locator}    Package edit button for '${package_name}'
            VAR    ${success}    ${TRUE}
            Log    \n---> Successfully opened package: ${package_name}    console=${LOG_TO_CONSOLE}
        EXCEPT    AS    ${err}
            Log    \n---> Attempt ${attempts}: Package '${package_name}' not found, refreshing page...    console=${LOG_TO_CONSOLE}
            Sleep    2
            Reload
            Sleep    2
            IF    ${attempts} >= 5
                Take Screenshot
                Fail    Package with name '${package_name}' not found after ${attempts} attempts. ERROR: ${err}
            END
        END
    END

Navigate To Driver Selection Tab In Packages
    [Documentation]    Navigates to driver selection tab in packages
    Log Action    Navigating to Driver Selection tab in packages
    Click Element    ${PACKAGES_DRIVER_SELECTION_TAB_BUTTON}    navigating to driver selection tab in packages

Search Drivers In Packages
    [Documentation]    Clicks search button to display list of drivers in packages
    Log Action    Searching drivers in packages
    Click Element    ${PACKAGES_DRIVER_SELECTION_SEARCH_BUTTON}    clicking search button to find drivers in packages

Check Driver In Packages
    [Documentation]    Checks driver checkbox in packages
    Log Action    Checking driver in packages
    Wait Element Ready    ${PACKAGES_DRIVER_SELECTION_DRIVER_CHECKBOX}
    Check Checkbox    ${PACKAGES_DRIVER_SELECTION_DRIVER_CHECKBOX}

Check Shuttle Company In Packages
    [Documentation]    Checks shuttle company checkbox in packages
    Log Action    Checking shuttle company in packages
    Wait Element Ready    ${PACKAGES_DRIVER_SELECTION_SHUTTLE_COMPANY_CHECKBOX}
    Check Checkbox    ${PACKAGES_DRIVER_SELECTION_SHUTTLE_COMPANY_CHECKBOX}

Click Request Now In Packages
    [Documentation]    Clicks Request Now button in packages
    Log Action    Clicking Request Now in packages
    Click Element    ${PACKAGES_DRIVER_SELECTION_REQUEST_NOW_BUTTON}    clicking Request Now button in packages

# === Driver Assignment Tab ===

Navigate To Driver Assignment Tab In Packages
    [Documentation]    Navigates to Driver Assignment tab in packages
    Log Action    Navigating to Driver Assignment tab in packages
    Click Element    ${PACKAGES_DRIVER_ASSIGNMENT_TAB_BUTTON}    navigating to Driver Assignment tab in packages

Get Carrier Name From Assignment Row
    [Documentation]    Gets the carrier name from the assignment table row.
    ...                Returns the name text from the link element.
    [Arguments]    ${row_index}
    IF    ${row_index} == 0
        ${name}=    Get Element Text    ${PACKAGES_CARRIER_ASSIGNMENT_NAME_LINK_ROW_0}    getting carrier name from row 0
    ELSE
        ${name}=    Get Element Text    ${PACKAGES_CARRIER_ASSIGNMENT_NAME_LINK_ROW_1}    getting carrier name from row 1
    END
    Log Data    Carrier name from row ${row_index}    ${name}
    RETURN    ${name}

Click Assign Button For Carrier
    [Documentation]    Clicks the Assign button for the specified carrier row.
    ...                row_index: 0 or 1
    [Arguments]    ${row_index}
    Log Action    Clicking Assign button for carrier at row ${row_index}
    IF    ${row_index} == 0
        Click Element    ${PACKAGES_CARRIER_ASSIGNMENT_ASSIGN_BUTTON_0}    clicking Assign button for row 0
    ELSE
        Click Element    ${PACKAGES_CARRIER_ASSIGNMENT_ASSIGN_BUTTON_1}    clicking Assign button for row 1
    END

Click Confirm Button For Carrier Assignment
    [Documentation]    Clicks the Confirm button for the carrier assignment
    Log Action    Clicking Confirm button for carrier assignment
    Click Element    ${PACKAGES_CARRIER_ASSIGNMENT_CONFIRM_BUTTON_0}    clicking Confirm button for carrier assignment

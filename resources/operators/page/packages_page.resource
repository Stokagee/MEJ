*** Settings ***
Resource    ../../../common.resource

*** Keywords ***

Click Edit Package Candidate
    [Documentation]    Clicks Edit Package Candidate on Package Candidate page
    Click Element    ${PACKAGES_CANDIDATE_EDIT_BUTTON}    clicking Edit Package Candidate

Click Orders Tab In Package Candidate
    [Documentation]    Clicks Orders Tab in Package Candidate on Package Candidate page
    Click Element    ${PACKAGES_CANDIDATE_ORDERS_TAB_BUTTON}    clicking Orders Tab in Package Candidate

Click Add Journey By Order ID
    [Documentation]    Clicks Add Journey By Order ID in Package Candidate on Package Candidate page
    Click Element    ${PACKAGES_CANDIDATE_ADD_JOURNEY_ID_BUTTON}    clicking Add Journey By Order ID in Package Candidate

Enter Order ID For Adding Journey
    [Documentation]    Enters Order ID for adding Journey in Package Candidate on Package Candidate page
    [Arguments]    ${order_id}
    Fill Field    ${PACKAGES_CANDIDATE_ADD_JOURNEY_ID_INPUT}    ${order_id}

Click Search Journey By Order ID
    [Documentation]    Clicks Search Journey By Order ID in Package Candidate on Package Candidate page
    Click Element    ${PACKAGES_CANDIDATE_SEARCH_JOURNEY_ID_BUTTON}    clicking Search Journey By Order ID in Package Candidate

Click Add Journey To Package
    [Documentation]    Clicks Add button and adds journey to package
    Click Element    ${PACKAGES_CANDIDATE_ADD_JOURNEY_BUTTON}    clicking Add button to manually add journey by ID

Click Detail Tab In Package Candidate
    [Documentation]    Navigates to detail tab in Candidate
    Click Element    ${PACKAGES_CANDIDATE_DETAIL_TAB_BUTTON}    navigating to detail tab in candidate

Click Create Package
    [Documentation]    Clicks create package to create the package
    Click Element    ${PACKAGES_CANDIDATE_CREATE_PACKAGE_BUTTON}    clicking to create package

Confirm Accept Modal For Create Package
    [Documentation]    Confirms popup modal and creates package
    Click Element    ${PACKAGES_CANDIDATE_ACCEPT_MODAL}    confirming modal to create package

Click Edit Package Detail
    [Documentation]    Clicks Edit to open editing options
    Click Element    ${PACKAGES_CANDIDATE_DETAIL_EDIT_BUTTON}    opening edit for detail editing

Enter New Package Name
    [Documentation]    Enters new package name in package detail candidate
    [Arguments]    ${package_candi_name}
    Fill Field    ${PACKAGES_CANDIDATE_NAME_INPUT}    ${package_candi_name}    entering new package name in package detail candidate

Enter New Note For Operator
    [Documentation]    Enters new note for operator in package detail candidate
    [Arguments]    ${pckg_candi_note_for_op}
    Fill Field    ${PACKAGES_CANDIDATE_NOTE_FOR_OPERATOR}    ${pckg_candi_note_for_op}    entering new note for OP in package detail candidate

Enter New Note For Driver
    [Documentation]    Enters new note for driver in package in package detail candidate
    [Arguments]    ${pckg_candi_note_for_dri}
    Fill Field    ${PACKAGES_CANDIDATE_NOTE_FOR_DRIVER}    ${pckg_candi_note_for_dri}    entering new note for driver in package detail candidate

Click Save Candidate Data
    [Documentation]    Clicks save to save new data in package candidate
    Click Element    ${PACKAGES_CANDIDATE_SAVE}    saving data for candidate in package candidate detail

Click Create Package Candidate
    [Documentation]    Clicks Create Package Candidate and opens new page in browser
    Click Element    ${JOURNEY_FORM_REQUEST_CREATE_PACKAGE_CANDIDATE_BUTTON}    clicking Create Package Candidate


Navigate To Packages Tab
    [Documentation]    Navigates to Packages tab from Packages Candidate page
    Click Element    ${PACKAGES_PACKAGES_TAB_BUTTON}    navigating to Packages tab

Open First Edit In Packages
    [Documentation]    Opens first edit in packages
    Click Element    ${PACKAGES_1ST_EDIT_BUTTON}    opening first edit in packages

Navigate To Driver Selection Tab In Packages
    [Documentation]    Navigates to driver selection tab in packages
    Click Element    ${PACKAGES_DRIVER_SELECTION_TAB_BUTTON}    navigating to driver selection tab in packages

Search Drivers In Packages
    [Documentation]    Clicks search button to display list of drivers in packages
    Click Element    ${PACKAGES_DRIVER_SELECTION_SEARCH_BUTTON}    clicking search button to find drivers in packages

Check Driver In Packages
    [Documentation]    Checks driver in packages
    Click Element    ${PACKAGES_DRIVER_SELECTION_DRIVER_CHECKBOX}    checking driver in packages

Check Shuttle Company In Packages
    [Documentation]    Checks shuttle company in packages
    Click Element    ${PACKAGES_DRIVER_SELECTION_SHUTTLE_COMPANY_CHECKBOX}    checking shuttle company in packages

Click Request Now In Packages
    [Documentation]    Clicks Request Now button in packages
    Click Element    ${PACKAGES_DRIVER_SELECTION_REQUEST_NOW_BUTTON}    clicking Request Now button in packages





















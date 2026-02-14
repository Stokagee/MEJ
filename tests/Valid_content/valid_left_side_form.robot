*** Settings ***
Resource    ../../common.resource

*** Variables ***
${passengers_count}    3

*** Test Cases ***

Open And Validate Type Of Journey After Filling Locations
    [Documentation]    Test that type of journey has a value after selecting addresses and saving time.
    [Tags]    ui    journey    positive    p2    type_of_journey    type_of_journey_validation
    [Setup]    Open Browser And Navigate To Journey Form
    Sleep    2
    ${type_for_verify}=    Select Journey Type
    Save Form Left Section
    Sleep    2
    ${type_after_save}=    Get Element Text    ${JOURNEYS_FORM_REQUEST_TYPE_TEXTAREA}    get Type Of Journey value after saving form
    Log To Console    Value before saving: ${type_for_verify}
    Should Be Equal    ${type_after_save}    ${type_for_verify}    msg=Type Of Journey value changed after saving form!

Open And Validate Date After Filling Locations
    [Documentation]    Test that date has today's date after filling.
    [Tags]    ui    journey    positive    p2    date    date_validation
    [Setup]    Navigate To Journeys Page Without Opening Form
    ${date_for_verify}=    Get Element Text    ${JOURNEYS_FORM_DATE_PICKER_TEXTAREA}    get Date value after filling form
    Log To Console    Date value after filling: ${date_for_verify}
    ${today_day}=    Get Current Date    result_format=%d %b %Y
    ${today_day_for_verify}=    Evaluate    '${today_day}'.lstrip("0")
    Should Be Equal    ${date_for_verify}    ${today_day_for_verify}    msg=Date value in form is not today's date!
    [Teardown]    Close Browser

Open And Validate Passengers Count
    [Documentation]    Test that passengers count has the correct value after filling.
    [Tags]    ui    journey    positive    p2    passengers_count    passengers_count_validation
    [Setup]    Open Browser And Navigate To Journey Form
    Sleep    2
    ${passengers_count_for_verify}=    Enter Passenger Count    ${passengers_count}
    Save Form Left Section
    Sleep    2
    ${passengers_count_after_save}=    Get Element Text    ${JOURNEYS_FORM_REQUEST_PASSENGERS_COUNT_TEXTAREA}    get Passengers Count value after saving form
    Log To Console    Value before saving: ${passengers_count_for_verify}
    Should Be Equal    ${passengers_count_after_save}    ${passengers_count_for_verify}    msg=Passengers Count value changed after saving form!
    [Teardown]    Close Browser

Open And Validate Car Type
    [Documentation]    Test that car type has the correct value after filling.
    [Tags]    ui    journey    positive    p2    car_type    car_type_validation
    [Setup]    Open Browser And Navigate To Journey Form
    Sleep    2
    ${car_type_for_verify}=    Select Car Type
    Save Form Left Section
    Sleep    2
    ${car_type_after_save}=    Get Element Text    ${JOURNEYS_FORM_REQUEST_CAR_TYPE_TEXTAREA}     get Car Type value after saving form
    Log To Console    Value before saving: ${car_type_for_verify}
    Should Be Equal    ${car_type_after_save}    ${car_type_for_verify}    msg=Car Type value changed after saving form!
    [Teardown]    Close Browser

Open And Validate Note For Driver
    [Documentation]    Test that note for driver has the correct value after filling.
    [Tags]    ui    journey    positive    p2    note_for_driver    note_for_driver_validation
    [Setup]    Open Browser And Navigate To Journey Form
    @{note}=    Sentences    nb=3
    ${note_for_driver}=    Catenate    SEPARATOR=${SPACE}    ${note}
    Sleep    2
    ${note_for_driver_for_verify}=    Enter Driver Note    ${note_for_driver}
    Save Form Left Section
    Sleep    2
    ${note_for_driver_after_save}=    Get Element Text    ${JOURNEYS_FORM_REQUEST_NOTE_FOR_DRIVER_TEXTAREA}    get Note For Driver value after saving form
    Log To Console    Value before saving: ${note_for_driver_for_verify}
    Should Be Equal    ${note_for_driver_after_save}    ${note_for_driver_for_verify}    msg=Note For Driver value changed after saving form!
    [Teardown]    Close Browser

Open And Validate Note For Operator
    [Documentation]    Test that note for operator has the correct value after filling.
    [Tags]    ui    journey    positive    p2    note_for_operator    note_for_operator_validation
    [Setup]    Open Browser And Navigate To Journey Form
    @{note}=    Sentences    nb=3
    ${note_for_operator}=    Catenate    SEPARATOR=${SPACE}    ${note}
    Sleep    2
    ${note_for_operator_for_verify}=    Enter Operator Note    ${note_for_operator}
    Save Form Left Section
    Sleep    2
    ${note_for_operator_after_save}=    Get Element Text    ${JOURNEYS_FORM_REQUEST_OPERATOR_NOTE_TEXTAREA}    get Note For Operator value after saving form
    Log To Console    Value before saving: ${note_for_operator_for_verify}
    Should Be Equal    ${note_for_operator_after_save}    ${note_for_operator_for_verify}    msg=Note For Operator value changed after saving form!
    [Teardown]    Close Browser

Open And Validate Passengers First Name
    [Documentation]    Test that passengers first name has the correct value after filling.
    [Tags]    ui    journey    positive    p2    passengers_first_name    passengers_first_name_validation
    [Setup]    Open Browser And Navigate To Journey Form
    ${first_name}=    Name
    Sleep    2
    ${first_name_for_verify}=    Enter Passenger First Name    ${first_name}
    Save Form Left Section
    Sleep    2
    ${first_name_after_save}=    Get Element Text    ${JOURNEYS_FORM_REQUEST_PASSENGERS_FIRST_NAME_TEXTAREA}    get Passengers First Name value after saving form
    Log To Console    Value before saving: ${first_name_for_verify}
    Should Be Equal    ${first_name_after_save}    ${first_name_for_verify}    msg=Passengers First Name value changed after saving form!
    [Teardown]    Close Browser

Open And Validate Passengers Last Name
    [Documentation]    Test that passengers last name has the correct value after filling.
    [Tags]    ui    journey    positive    p2    passengers_last_name    passengers_last_name_validation
    [Setup]    Open Browser And Navigate To Journey Form
    ${last_name}=    Last Name
    Sleep    2
    ${last_name_for_verify}=    Enter Passenger Last Name    ${last_name}
    Save Form Left Section
    Sleep    2
    ${last_name_after_save}=    Get Element Text    ${JOURNEYS_FORM_REQUEST_PASSENGERS_LAST_NAME_TEXTAREA}    get Passengers Last Name value after saving form
    Log To Console    Value before saving: ${last_name_for_verify}
    Should Be Equal    ${last_name_after_save}    ${last_name_for_verify}    msg=Passengers Last Name value changed after saving form!
    [Teardown]    Close Browser

Open And Validate Passengers Email
    [Documentation]    Test that passengers email has the correct value after filling.
    [Tags]    ui    journey    positive    p2    passengers_email    passengers_email_validation
    [Setup]    Open Browser And Navigate To Journey Form
    ${email}=    Email
    Sleep    2
    ${email_for_verify}=    Enter Passenger Email    ${email}
    Save Form Left Section
    Sleep    2
    ${email_after_save}=    Get Element Text    ${JOURNEYS_FORM_REQUEST_PASSENGERS_EMAIL_TEXTAREA}    get Passengers Email value after saving form
    Log To Console    Value before saving: ${email_for_verify}
    Should Be Equal    ${email_after_save}    ${email_for_verify}    msg=Passengers Email value changed after saving form!
    [Teardown]    Close Browser

Open And Validate Passengers Phone
    [Documentation]    Test that passengers phone has the correct value after filling.
    [Tags]    ui    journey    positive    p2    passengers_phone    passengers_phone_validation
    [Setup]    Open Browser And Navigate To Journey Form
    ${phone}=    Phone Number
    Sleep    2
    ${phone_for_verify}=    Enter Passenger Phone    ${phone}
    Save Form Left Section
    Sleep    2
    ${phone_after_save}=    Get Element Text    ${JOURNEYS_FORM_REQUEST_PASSENGERS_PHONE_TEXTAREA}    get Passengers Phone value after saving form
    Log To Console    Value before saving: ${phone_for_verify}
    Should Be Equal    ${phone_after_save}    ${phone_for_verify}    msg=Passengers Phone value changed after saving form!
    [Teardown]    Close Browser

Open And Validate Whatsapp Supported Checkbox
    [Documentation]    Test that Whatsapp Supported Checkbox is checked after checking.
    [Tags]    ui    journey    positive    p2    whatsapp_supported_checkbox    whatsapp_supported_checkbox_validation
    [Setup]    Open Browser And Navigate To Journey Form
    Sleep    2
    Check Passenger Whatsapp Checkbox
    Save Form Left Section
    Sleep    2
    ${checkbox_state}=    Get Element Text  ${JOURNEYS_FORM_REQUEST_PASSENGERS_WHATSAPP_TEXTAREA}    aria-checked
    Log To Console    Whatsapp Supported Checkbox state after saving form: ${checkbox_state}
    Should Be Equal    ${checkbox_state}    WhatsApp supported    msg=Whatsapp Supported Checkbox is not checked after saving form!
    [Teardown]    Close Browser

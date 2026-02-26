*** Settings ***
Documentation    WhatsApp validation tests for registration form.
...              Tests the WhatsApp verification checkbox behavior:
...              - Click without phone shows error
...              - Valid phone shows verified message
...              - Invalid phone shows not verified message
...              - Phone change resets validation state
Resource         ../../../common.resource

*** Test Cases ***

Test WhatsApp Click Without Phone Shows Error
    [Documentation]    Clicking WhatsApp checkbox without phone shows error.
    ...                Expected: "Phone number must be filled in first"
    [Tags]    ui    register    driver    negative    whatsapp    p1
    [Setup]    Open Browser And Navigate To Registration Form
    Click Element    ${REGISTER_WHATSAPP_CHECKBOX}    WhatsApp checkbox
    Verify WhatsApp Phone Required Message
    [Teardown]    Close Browser

Test WhatsApp Verified With Valid Phone
    [Documentation]    WhatsApp verification succeeds with valid phone.
    ...                Expected: "WhatsApp verified" (green message)
    [Tags]    ui    register    driver    negative    whatsapp    p1
    [Setup]    Open Browser And Navigate To Registration Form
    Select From Dropdown    ${FIRST_PAGE_REGISTER_DRIVER_DIAL_DROPDOWN}    +420    label    Dial code
    Fill Field    ${REGISTER_PHONE_INPUT}    123456789    Phone input
    Click Element    ${REGISTER_WHATSAPP_CHECKBOX}    WhatsApp checkbox
    Verify WhatsApp Verified Message
    [Teardown]    Close Browser

Test WhatsApp Reset On Phone Change
    [Documentation]    WhatsApp validation resets when phone changes.
    ...                After phone change, the verified message should disappear.
    [Tags]    ui    register    driver    negative    whatsapp    p1
    [Setup]    Open Browser And Navigate To Registration Form
    Select From Dropdown    ${FIRST_PAGE_REGISTER_DRIVER_DIAL_DROPDOWN}    +420    label    Dial code
    Fill Field    ${REGISTER_PHONE_INPUT}    123456789    Phone input
    Click Element    ${REGISTER_WHATSAPP_CHECKBOX}    WhatsApp checkbox
    Verify WhatsApp Verified Message
    # Change phone number - should reset validation
    Fill Field    ${REGISTER_PHONE_INPUT}    987654321    Phone input changed
    # After phone change, validation should be reset (message no longer visible)
    ${state}=    Get Element States    ${REGISTER_WHATSAPP_VERIFIED_MESSAGE}
    Should Not Contain    ${state}    visible
    Log Verification    WhatsApp validation was reset after phone change
    [Teardown]    Close Browser

Test WhatsApp Reset On Dial Code Change
    [Documentation]    WhatsApp validation resets when dial code changes.
    ...                After dial code change, the verified message should disappear.
    [Tags]    ui    register    driver    negative    whatsapp    p2
    [Setup]    Open Browser And Navigate To Registration Form
    Select From Dropdown    ${FIRST_PAGE_REGISTER_DRIVER_DIAL_DROPDOWN}    +420    label    Dial code
    Fill Field    ${REGISTER_PHONE_INPUT}    123456789    Phone input
    Click Element    ${REGISTER_WHATSAPP_CHECKBOX}    WhatsApp checkbox
    Verify WhatsApp Verified Message
    # Change dial code - should reset validation
    Select From Dropdown    ${FIRST_PAGE_REGISTER_DRIVER_DIAL_DROPDOWN}    +421    label    Dial code changed
    # After dial code change, validation should be reset (message no longer visible)
    ${state}=    Get Element States    ${REGISTER_WHATSAPP_VERIFIED_MESSAGE}
    Should Not Contain    ${state}    visible
    Log Verification    WhatsApp validation was reset after dial code change
    [Teardown]    Close Browser

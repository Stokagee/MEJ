*** Settings ***
Documentation    This test verifies elements on the register page.
Resource    ../../Resources/Register/Keywords_register.resource
Resource    ../../Resources/Register/Variables_register.resource


*** Test Cases ***
Valid Register Pages
    [Tags]    ui    register    positive    p3
    [Documentation]    This test case ensures that all register page elements are properly displayed.
    New Browser    ${BROWSER}
    New Context
    New Page    ${URL}
    Verify Valid Register Content On Login Page
    [Teardown]    Close Browser

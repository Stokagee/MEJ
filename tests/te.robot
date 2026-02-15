*** Settings ***
Resource    ../common.resource
Documentation    Test scenario for Invoice

*** Variables ***


*** Test Cases ***
Create New Invoice
    [Documentation]    Tests creating new invoice via UI and verifies its correct creation in DB
    [Tags]    e2e    invoice    db    positive    p2
    [Setup]    Open Browser And Navigate To Invoices Page
    Open New Invoice Form
    ${order_name}=    FakerLibrary.Ripe Id
    ${product_name}=    FakerLibrary.Bothify
    ${profit_mej}=    FakerLibrary.Random Number    1000    5000
    ${received_payment}=    FakerLibrary.Random Number    1    999
    Enter Order Name In Invoice Form    ${order_name}
    Enter Product Name In Invoice Form    ${product_name}
    Enter Profit For MEJ In Invoice Form    ${profit_mej}
    Enter Received Payment In Invoice Form    ${received_payment}
    Select Driver In Invoice Form
    Save Invoice Form
    Verify Invoice Created In UI
    Log    \n=====\nCreating invoice with Order Name: ${order_name}, Product Name: ${product_name}\n=====    console=${LOG_TO_CONSOLE}
    Create Database Session
    Get Invoice By Order Name From DB    ${order_name}
    [Teardown]    Run Keywords
    ...    Close Browser
    ...    AND    Disconnect From All Databases





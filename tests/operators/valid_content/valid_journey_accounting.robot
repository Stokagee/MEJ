*** Settings ***
Resource    ../../../common.resource

*** Variables ***
${bokun_amount}    1000

*** Test Cases ***

Open And Validate Bokun Amount
    [Documentation]    Test that bokun amount has the correct value after filling.
    [Tags]    ui    journey    positive    p2    bokun_amount    bokun_amount_validation
    [Setup]    Navigate To Journeys Page Without Opening Form
    Fill Accounting Bokun Amount Only    ${bokun_amount}
    Sleep    2
    ${bokun_amount_after_save}=    Get Element Text    ${JOURNEYS_FORM_ACCOUNTING_BOKUN_AMOUNT_TEXTAREA}    get Bokun Amount value after saving form
    Log    Bokun Amount value after saving: ${bokun_amount_after_save}    console=${LOG_TO_CONSOLE}
    Should Be Equal As Numbers  ${bokun_amount_after_save}    ${bokun_amount}    msg=Bokun Amount value changed after saving form!
    [Teardown]    Close Browser

Open And Validate Bokun Profit For Driver
    [Documentation]    Test that bokun profit for driver has the correct value after filling.
    [Tags]    ui    journey    positive    p2    bokun_profit    bokun_profit_validation
    [Setup]    Navigate To Journeys Page Without Opening Form
    Fill Accounting Bokun Profit Only    ${bokun_amount}
    Sleep    2
    ${bokun_profit_after_save}=    Get Element Text    ${JOURNEYS_FORM_ACCOUNTING_BOKUN_PROFIT_TEXTAREA}    get Bokun Profit For Driver value after saving form
    Log    Bokun Profit For Driver value after saving: ${bokun_profit_after_save}    console=${LOG_TO_CONSOLE}
    Should Be Equal As Numbers  ${bokun_profit_after_save}    ${bokun_amount}    msg=Bokun Profit For Driver value changed after saving form!
    ${rest_of_driver_payment_after_save}=    Get Element Text    ${JOURNEYS_FORM_ACCOUNTING_REST_OF_DRIVER_PAYMENT_TEXTAREA}    get Rest Of Driver Payment value after saving form
    Log    Rest Of Driver Payment value after saving: ${rest_of_driver_payment_after_save}    console=${LOG_TO_CONSOLE}
    Should Be Equal As Numbers  ${rest_of_driver_payment_after_save}    ${bokun_amount}    msg=Rest Of Driver Payment value changed after saving form!
    [Teardown]    Close Browser

Open And Validate Driver Cash Amount
    [Documentation]    Test that driver cash amount has the correct value after filling.
    [Tags]    ui    journey    positive    p2    driver_cash_amount    driver_cash_amount_validation
    [Setup]    Navigate To Journeys Page Without Opening Form
    Fill Accounting Driver Cash Only    ${bokun_amount}
    Sleep    2
    ${driver_cash_amount_after_save}=    Get Element Text    ${JOURNEYS_FORM_ACCOUNTING_DRIVER_CASH_AMOUNT_TEXTAREA}    get Driver Cash Amount value after saving form
    Log    Driver Cash Amount value after saving: ${driver_cash_amount_after_save}    console=${LOG_TO_CONSOLE}
    Should Be Equal As Numbers  ${driver_cash_amount_after_save}    ${bokun_amount}    msg=Driver Cash Amount value changed after saving form!
    ${driver_cash_collecting_after_save}=    Get Element Text    ${JOURNEYS_FORM_ACCOUNTING_DRIVER_CASH_COLLECTING_TEXTAREA}    get Driver Cash Collecting value after saving form
    Log    Driver Cash Collecting value after saving: ${driver_cash_collecting_after_save}    console=${LOG_TO_CONSOLE}
    Should Be Equal As Numbers  ${driver_cash_collecting_after_save}    ${bokun_amount}    msg=Driver Cash Collecting value changed after saving form!
    Click Hint Button For Cash Note
    Confirm Modal Ok Button
    [Teardown]    Close Browser

Open And Validate Driver Cash Profit
    [Documentation]    Test that driver cash profit has the correct value after filling.
    [Tags]    ui    journey    positive    p2    driver_cash_profit    driver_cash_profit_validation
    [Setup]    Navigate To Journeys Page Without Opening Form
    Fill Accounting Driver Profit Only    ${bokun_amount}
    Sleep    2
    ${driver_cash_profit_after_save}=    Get Element Text    ${JOURNEYS_FORM_ACCOUNTING_DRIVER_REST_OF_PAYMENT_TEXTAREA}    get Driver Cash Profit value after saving form
    Log    Driver Cash Profit value after saving: ${driver_cash_profit_after_save}    console=${LOG_TO_CONSOLE}
    Should Be Equal As Numbers  ${driver_cash_profit_after_save}    ${bokun_amount}    msg=Driver Cash Profit value changed after saving form!
    ${rest_of_driver_payment_after_save}=    Get Element Text    ${JOURNEYS_FORM_ACCOUNTING_REST_OF_DRIVER_PAYMENT_TEXTAREA}    get Rest Of Driver Payment value after saving form
    Log    Rest Of Driver Payment value after saving: ${rest_of_driver_payment_after_save}    console=${LOG_TO_CONSOLE}
    Should Be Equal As Numbers  ${rest_of_driver_payment_after_save}    ${bokun_amount}    msg=Rest Of Driver Payment value changed after saving form!
    Click Hint Button For Cash Note
    Confirm Modal Ok Button
    [Teardown]    Close Browser

Open And Validate MEJ Stripe Amount
    [Documentation]    Test that MEJ Stripe amount has the correct value after filling.
    [Tags]    ui    journey    positive    p2    mej_stripe_amount    mej_stripe_amount_validation
    [Setup]    Navigate To Journeys Page Without Opening Form
    Fill Accounting MEJ Stripe Only    ${bokun_amount}
    Sleep    2
    ${mej_stripe_amount_after_save}=    Get Element Text    ${JOURNEYS_FORM_ACCOUNTING_MEJ_STRIPE_AMOUNT_TEXTAREA}    get MEJ Stripe Amount value after saving form
    Log    MEJ Stripe Amount value after saving: ${mej_stripe_amount_after_save}    console=${LOG_TO_CONSOLE}
    VAR    ${amount_part}    ${{str($mej_stripe_amount_after_save).split('/')[-1].strip()}}
    Should Be Equal As Numbers  ${amount_part}    ${bokun_amount}    msg=MEJ Stripe Amount value changed after saving form!
    [Teardown]    Close Browser

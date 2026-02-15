*** Settings ***
Resource    Variables_register.resource
Library    ../../resources/Python_skripts.py
Library    Browser
Library    FakerLibrary
Library    DatabaseLibrary


*** Variables ***
${MODULE_PATH}    path/resources/Python_skripts.py

*** Keywords ***
Navigate To Register Page
    [Documentation]    This keyword opens the browser and navigates to the login page.
    ...    This keyword enters valid login credentials and submits the login form.
    ...    It ensures the correct input values for username and password.
    ...    This keyword verifies that the user is redirected to the dashboard
    ...    and that the welcome message is displayed to confirm successful login.
    Wait For Elements State    xpath=//button[text()='Sign Up']    visible    ${SHORT}    # Wait for the "Sign Up" button
    Click    xpath=//button[text()='Sign Up']    # Click the "Sign Up" button to proceed
    Wait For Elements State    xpath=//button[contains(@class, 'x-btn-primary') and contains(text(), 'Select')]    visible    ${SHORT}    # Wa
    Click    xpath=//button[contains(@class, 'x-btn-primary') and contains(text(), 'Select')]    # Select driver registration option

Fill Valid Credentials
    [Documentation]    Fills in all required fields in the driver registration form and submits it.
    # Fill in personal details
    Wait For Elements State    xpath=//input[@name="Model.FirstName"]    visible    ${SHORT}    # Wait for "First Name" field
    ${USERNAME_FL}=    FakerLibrary.First Name
    Fill Text    xpath=//input[@name="Model.FirstName"]    ${USERNAME_FL}    # Enter first name
    Wait For Elements State    xpath=//input[@name="Model.LastName"]    visible    ${SHORT}    # Wait for "Last Name" field
    ${LASTNAME_FL}=    FakerLibrary.Last Name    
    Fill Text    xpath=//input[@name="Model.LastName"]    ${LASTNAME_FL}    # Enter last name
    Wait For Elements State    xpath=//select[@name="Model.PhoneDialCode"]    visible    ${SHORT}    # Wait for phone country code dropdown
    Click    xpath=//select[@name="Model.PhoneDialCode"]    # Click the phone country code dropdown
    Wait For Elements State    xpath=//select[@name="Model.PhoneDialCode"]    visible    ${SHORT}
    Select Options By    xpath=//select[@name="Model.PhoneDialCode"]    text    +420
    Wait For Elements State    xpath=//input[@name="Model.Phone"]    visible    ${SHORT}    # Wait for "Phone" field
    ${PHONE_NUMBER_FL}=    FakerLibrary.Random Number    digits=9    fix_len=${True}
    Fill Text    xpath=//input[@name="Model.Phone"]    ${PHONE_NUMBER_FL}    # Enter phone number
    ${random_user}=    FakerLibrary.User name
    VAR    ${email}    robot${random_user}@example.com    scope=GLOBAL
    Log    ${email}    console=${LOG_TO_CONSOLE}
    Wait For Elements State    xpath=//input[@name="Model.Email"]    visible    ${SHORT}    # Wait for "Email" field
    Fill Text    xpath=//input[@name="Model.Email"]    ${email}    # Enter email address
    Wait For Elements State    xpath=//input[@name="Model.Password"]    visible    ${SHORT}    # Wait for "Password" field
    Fill Text    xpath=//input[@name="Model.Password"]    ${PASSWORD_LOG}    # Enter password
    Wait For Elements State    xpath=//input[@name="Model.ConfirmPassword"]    visible    ${SHORT}    # Wait for "Confirm Password" field
    Fill Text    xpath=//input[@name="Model.ConfirmPassword"]    ${PASSWORD_CONFIRM_LOG}    # Confirm password
    Click    xpath=//input[@type="checkbox" and contains(@class, "form-check-input")]    # Kliknutie na checkbox "Súhlasím s podmienkami používania"
    Wait For Elements State    xpath=//input[@type="checkbox" and contains(@class, "form-check-input")]    visible    ${SHORT}    # Čakanie, kým sa checkbox zobrazí
    Get Checkbox State    xpath=//input[@type="checkbox" and contains(@class, "form-check-input")]    ==    checked    # Overenie, či je checkbox zaškrtnutý
    Wait For Elements State    xpath=//button[contains(@class, 'x-btn-primary')]    visible    ${SHORT}    # Wait for the submit button
    Sleep    10
    Click    xpath=//button[contains(@class, 'x-btn-primary')]    # Submit the form

    #    Fill In Business Details With Dynamic IBAN

    # Čakanie na pole "Business Number" a vyplnenie
    Wait For Elements State    xpath=//input[@name="Model.IdentificationNumber"]    visible    ${SHORT}
    ${BUSINESS_NUMBER_FL}=    FakerLibrary.Random Number
    Fill Text    xpath=//input[@name="Model.IdentificationNumber"]    ${BUSINESS_NUMBER_FL}
    # Výber krajiny "Czech Republic"
    Wait For Elements State    xpath=//select[@name="Model.CountryId"]    visible    ${SHORT}
    Select Options By    xpath=//select[@name="Model.CountryId"]    text    Czech Republic
    # Vyplnenie názvu firmy
    ${BUSINESS_NAME_FL}=    FakerLibrary.Random Number    digits=15    fix_len=${False}
    Fill Text    xpath=//input[@name="Model.BusinessName"]    ${BUSINESS_NAME_FL}
    # Vyplnenie adresy firmy
    ${BUSINESS_ADDRESS_FL}=    FakerLibrary.Street Address
    Fill Text    xpath=//input[@name="Model.BusinessStreet"]    ${BUSINESS_ADDRESS_FL}
    # Vyplnenie mesta
    ${BUSINESS_CITY_FL}=    FakerLibrary.City
    Fill Text    xpath=//input[@name="Model.BusinessCity"]    ${BUSINESS_CITY_FL}
    # Vyplnenie PSČ
    ${BUSINESS_ZIP_FL}=    FakerLibrary.Postalcode        
    Fill Text    xpath=//input[@name="Model.BusinessZipCode"]    ${BUSINESS_ZIP_FL}
    # Vyplnenie IBAN (predpokladáme, že máte vlastnú funkciu na generovanie IBAN)
    ${generated_iban}=    Generate Valid Czech Iban
    Fill Text    xpath=//input[@name="Model.IbanInEuro"]    ${generated_iban}
    # Odoslanie formulára
    Click    xpath=//button[contains(text(), 'Finish')]
    Wait For Elements State    xpath=//div[contains(@class, 'notification-component')]/p    visible    ${SHORT}    
    Get Text    xpath=//div[contains(@class, 'notification-component')]/p    ==    Verification email was sent, check your email.
    

    Connect To Database
    ...    pyodbc
    ...    db_name=${DB_NAME}
    ...    db_user=${DB_USER}
    ...    db_password=${DB_PASSWORD}
    ...    db_host=${DB_HOST}
    ...    db_port=${DB_PORT}
    ...    odbc_driver={ODBC Driver 17 for SQL Server}
    Log    Connected to database: ${DB_NAME}    console=${LOG_TO_CONSOLE}
    Table Must Exist    Driver
    Execute Sql String    UPDATE dri.Driver SET IsActive = 1 WHERE Email = '${email}'
    Execute Sql String    UPDATE idm.[User] SET EmailConfirmed = 1 WHERE Email = '${email}'
    Log    Email ${email} is confirmed    console=${LOG_TO_CONSOLE}
    Disconnect From Database
Navigate To SH Register Page
    [Documentation]    This keyword opens the browser and navigates to the login page.
    ...    This keyword enters valid login credentials and submits the login form.
    ...    It ensures the correct input values for username and password.
    ...    This keyword verifies that the user is redirected to the dashboard
    ...    and that the welcome message is displayed to confirm successful login.
    Wait For Elements State    xpath=//button[text()='Sign Up']    visible    ${SHORT}    # Wait for the "Sign Up" button
    Click    xpath=//button[text()='Sign Up']    # Click the "Sign Up" button to proceed
    Wait For Elements State    xpath=//input[@class='form-check-input' and @value='ShuttleCompany']    visible    ${SHORT}    # Wait for Shuttle Company registration option
    Click    xpath=//input[@class='form-check-input' and @value='ShuttleCompany']    # Select Shuttle Company registration option
    Wait For Elements State    xpath=//button[contains(@class, 'x-btn-primary') and contains(text(), 'Select')]    visible    ${SHORT}
    Click    xpath=//button[contains(@class, 'x-btn-primary') and contains(text(), 'Select')]    # Select driver registration option

Fill Valid SH Credentials
    [Documentation]    Fills in all required fields in the SH registration form and submits it.
    # Fill in personal details
    Wait For Elements State    xpath=//input[@name="Model.FirstName"]    visible    ${SHORT}    # Wait for "First Name" field
    ${USERNAME_FL}=    FakerLibrary.First Name
    Fill Text    xpath=//input[@name="Model.FirstName"]    ${USERNAME_FL}    # Enter first name
    Wait For Elements State    xpath=//input[@name="Model.LastName"]    visible    ${SHORT}    # Wait for "Last Name" field
    ${LASTNAME_FL}=    FakerLibrary.Last Name    
    Fill Text    xpath=//input[@name="Model.LastName"]    ${LASTNAME_FL}    # Enter last name
    Wait For Elements State    xpath=//select[@name="Model.PhoneDialCode"]    visible    ${SHORT}    # Wait for phone country code dropdown
    Click    xpath=//select[@name="Model.PhoneDialCode"]    # Click the phone country code dropdown
    Wait For Elements State    xpath=//select[@name="Model.PhoneDialCode"]    visible    ${SHORT}
    Select Options By    xpath=//select[@name="Model.PhoneDialCode"]    text    +420
    Wait For Elements State    xpath=//input[@name="Model.Phone"]    visible    ${SHORT}    # Wait for "Phone" field
    ${PHONE_NUMBER_FL}=    FakerLibrary.Random Number    digits=9    fix_len=${True}
    Fill Text    xpath=//input[@name="Model.Phone"]    ${PHONE_NUMBER_FL}    # Enter phone number
    ${random_user}=    FakerLibrary.User name
    VAR    ${email}    robot${random_user}@example.com    scope=GLOBAL
    Log    ${email}    console=${LOG_TO_CONSOLE}
    Wait For Elements State    xpath=//input[@name="Model.Email"]    visible    ${SHORT}    # Wait for "Email" field
    Fill Text    xpath=//input[@name="Model.Email"]    ${email}    # Enter email address
    Wait For Elements State    xpath=//input[@name="Model.Password"]    visible    ${SHORT}    # Wait for "Password" field
    Fill Text    xpath=//input[@name="Model.Password"]    ${PASSWORD_LOG}    # Enter password
    Wait For Elements State    xpath=//input[@name="Model.ConfirmPassword"]    visible    ${SHORT}    # Wait for "Confirm Password" field
    Fill Text    xpath=//input[@name="Model.ConfirmPassword"]    ${PASSWORD_CONFIRM_LOG}    # Confirm password
    Click    xpath=//input[@type="checkbox" and contains(@class, "form-check-input")]    # Kliknutie na checkbox "Súhlasím s podmienkami používania"
    Wait For Elements State    xpath=//input[@type="checkbox" and contains(@class, "form-check-input")]    visible    ${SHORT}    # Čakanie, kým sa checkbox zobrazí
    Get Checkbox State    xpath=//input[@type="checkbox" and contains(@class, "form-check-input")]    ==    checked    # Overenie, či je checkbox zaškrtnutý
    Wait For Elements State    xpath=//button[contains(@class, 'x-btn-primary')]    visible    ${SHORT}    # Wait for the submit button
    Sleep    10
    Click    xpath=//button[contains(@class, 'x-btn-primary')]    # Submit the form

    #    Fill In Business Details With Dynamic IBAN

    # Čakanie na pole "Business Number" a vyplnenie
    Wait For Elements State    xpath=//input[@name="Model.IdentificationNumber"]    visible    ${SHORT}
    ${BUSINESS_NUMBER_FL}=    FakerLibrary.Random Number
    Fill Text    xpath=//input[@name="Model.IdentificationNumber"]    ${BUSINESS_NUMBER_FL}
    # Výber krajiny "Czech Republic"
    Wait For Elements State    xpath=//select[@name="Model.CountryId"]    visible    ${SHORT}
    Select Options By    xpath=//select[@name="Model.CountryId"]    text    Czech Republic
    # Vyplnenie názvu firmy
    ${BUSINESS_NAME_FL}=    FakerLibrary.Random Number    digits=15    fix_len=${False}
    Fill Text    xpath=//input[@name="Model.BusinessName"]    ${BUSINESS_NAME_FL}
    # Vyplnenie adresy firmy
    ${BUSINESS_ADDRESS_FL}=    FakerLibrary.Street Address
    Fill Text    xpath=//input[@name="Model.BusinessStreet"]    ${BUSINESS_ADDRESS_FL}
    # Vyplnenie mesta
    ${BUSINESS_CITY_FL}=    FakerLibrary.City
    Fill Text    xpath=//input[@name="Model.BusinessCity"]    ${BUSINESS_CITY_FL}
    # Vyplnenie PSČ
    ${BUSINESS_ZIP_FL}=    FakerLibrary.Postalcode        
    Fill Text    xpath=//input[@name="Model.BusinessZipCode"]    ${BUSINESS_ZIP_FL}
    # Vyplnenie IBAN (predpokladáme, že máte vlastnú funkciu na generovanie IBAN)
    ${generated_iban}=    Generate Valid Czech Iban
    Fill Text    xpath=//input[@name="Model.IbanInEuro"]    ${generated_iban}
    # Odoslanie formulára
    Click    xpath=//button[contains(text(), 'Finish')]
    Wait For Elements State    xpath=//div[contains(@class, 'notification-component')]/p    visible    ${SHORT}    
    Get Text    xpath=//div[contains(@class, 'notification-component')]/p    ==    Verification email was sent, check your email.
    

    Connect To Database
    ...    pyodbc
    ...    db_name=${DB_NAME}
    ...    db_user=${DB_USER}
    ...    db_password=${DB_PASSWORD}
    ...    db_host=${DB_HOST}
    ...    db_port=${DB_PORT}
    ...    odbc_driver={ODBC Driver 17 for SQL Server}
    Log    Connected to database: ${DB_NAME}    console=${LOG_TO_CONSOLE}
    Table Must Exist    ShuttleCompany
    Execute Sql String    UPDATE dri.ShuttleCompany SET IsActive = 1 WHERE Email = '${email}'
    Execute Sql String    UPDATE idm.[User] SET EmailConfirmed = 1 WHERE Email = '${email}'
    Log    Email ${email} is confirmed    console=${LOG_TO_CONSOLE}
    Disconnect From Database

Fill Valid VAT SH Credentials
    [Documentation]    Fills in all required fields in the SH registration form and submits it.
    Wait For Elements State    xpath=//input[@name="Model.FirstName"]    visible    ${SHORT}    # Wait for "First Name" field
    ${USERNAME_FL}=    FakerLibrary.First Name
    Fill Text    xpath=//input[@name="Model.FirstName"]    ${USERNAME_FL}    # Enter first name
    Wait For Elements State    xpath=//input[@name="Model.LastName"]    visible    ${SHORT}    # Wait for "Last Name" field
    ${LASTNAME_FL}=    FakerLibrary.Last Name
    Fill Text    xpath=//input[@name="Model.LastName"]    ${LASTNAME_FL}    # Enter last name
    Wait For Elements State    xpath=//select[@name="Model.PhoneDialCode"]    visible    ${SHORT}    # Wait for phone country code dropdown
    Click    xpath=//select[@name="Model.PhoneDialCode"]    # Click the phone country code dropdown
    Wait For Elements State    xpath=//select[@name="Model.PhoneDialCode"]    visible    ${SHORT}
    Select Options By    xpath=//select[@name="Model.PhoneDialCode"]    text    +420
    Wait For Elements State    xpath=//input[@name="Model.Phone"]    visible    ${SHORT}    # Wait for "Phone" field
    ${PHONE_NUMBER_FL}=    FakerLibrary.Random Number    digits=9    fix_len=${True}
    Fill Text    xpath=//input[@name="Model.Phone"]    ${PHONE_NUMBER_FL}    # Enter phone number
    ${random_user}=    FakerLibrary.User name
    VAR    ${email}    robot${random_user}@example.com    scope=GLOBAL
    Log    ${email}    console=${LOG_TO_CONSOLE}
    Wait For Elements State    xpath=//input[@name="Model.Email"]    visible    ${SHORT}    # Wait for "Email" field
    Fill Text    xpath=//input[@name="Model.Email"]    ${email}    # Enter email address
    Wait For Elements State    xpath=//input[@name="Model.Password"]    visible    ${SHORT}    # Wait for "Password" field
    Fill Text    xpath=//input[@name="Model.Password"]    ${PASSWORD_LOG}    # Enter password
    Wait For Elements State    xpath=//input[@name="Model.ConfirmPassword"]    visible    ${SHORT}    # Wait for "Confirm Password" field
    Fill Text    xpath=//input[@name="Model.ConfirmPassword"]    ${PASSWORD_CONFIRM_LOG}    # Confirm password
    Click    xpath=//input[@type="checkbox" and contains(@class, "form-check-input")]    # Kliknutie na checkbox "Súhlasím s podmienkami používania"
    Wait For Elements State    xpath=//input[@type="checkbox" and contains(@class, "form-check-input")]    visible    ${SHORT}    # Čakanie, kým sa checkbox zobrazí
    Get Checkbox State    xpath=//input[@type="checkbox" and contains(@class, "form-check-input")]    ==    checked    # Overenie, či je checkbox zaškrtnutý
    Wait For Elements State    xpath=//button[contains(@class, 'x-btn-primary')]    visible    ${SHORT}    # Wait for the submit button
    Click    xpath=//button[contains(@class, 'x-btn-primary')]    # Submit the form

    #    Fill In Business Details With Dynamic IBAN

    # Čakanie na pole "Business Number" a vyplnenie
    Wait For Elements State    xpath=//input[@name="Model.IdentificationNumber"]    visible    ${SHORT}
    ${BUSINESS_NUMBER_FL}=    FakerLibrary.Random Number
    Fill Text    xpath=//input[@name="Model.IdentificationNumber"]    ${BUSINESS_NUMBER_FL}

    Wait For Elements State    xpath=//label[text()='I am the VAT Payer']    visible    ${SHORT}
    Click    xpath=//label[text()='I am the VAT Payer']
    ${VAT_NUMBER}=    Generate Vat Number    CZ
    Wait For Elements State    xpath=//input[@name="Model.VatNumber"]    visible    ${SHORT}
    Fill Text    xpath=//input[@name="Model.VatNumber"]    ${VAT_NUMBER}

    # Výber krajiny "Czech Republic"
    Wait For Elements State    xpath=//select[@name="Model.CountryId"]    visible    ${SHORT}    
    Select Options By    xpath=//select[@name="Model.CountryId"]    text    Czech Republic
    # Vyplnenie názvu firmy
    ${BUSINESS_NAME_FL}=    FakerLibrary.Random Number    digits=15    fix_len=${False}
    Fill Text    xpath=//input[@name="Model.BusinessName"]    ${BUSINESS_NAME_FL}
    # Vyplnenie adresy firmy
    ${BUSINESS_ADDRESS_FL}=    FakerLibrary.Street Address
    Fill Text    xpath=//input[@name="Model.BusinessStreet"]    ${BUSINESS_ADDRESS_FL}
    # Vyplnenie mesta
    ${BUSINESS_CITY_FL}=    FakerLibrary.City
    Fill Text    xpath=//input[@name="Model.BusinessCity"]    ${BUSINESS_CITY_FL}
    # Vyplnenie PSČ
    ${BUSINESS_ZIP_FL}=    FakerLibrary.Postalcode
    Fill Text    xpath=//input[@name="Model.BusinessZipCode"]    ${BUSINESS_ZIP_FL}
    # Vyplnenie IBAN (predpokladáme, že máte vlastnú funkciu na generovanie IBAN)
    ${generated_iban}=    Generate Valid Czech Iban
    Fill Text    xpath=//input[@name="Model.IbanInEuro"]    ${generated_iban}
    # Odoslanie formulára
    Click    xpath=//button[contains(text(), 'Finish')]
    Wait For Elements State    xpath=//div[contains(@class, 'notification-component')]/p    visible    5s
    Get Text    xpath=//div[contains(@class, 'notification-component')]/p    ==    Verification email was sent, check your email.

    Connect To Database
    ...    pyodbc
    ...    db_name=${DB_NAME}
    ...    db_user=${DB_USER}
    ...    db_password=${DB_PASSWORD}
    ...    db_host=${DB_HOST}
    ...    db_port=${DB_PORT}
    ...    odbc_driver={ODBC Driver 17 for SQL Server}
    Log    Connected to database: ${DB_NAME}    console=${LOG_TO_CONSOLE}
    Table Must Exist    ShuttleCompany
    Execute Sql String    UPDATE dri.ShuttleCompany SET IsActive = 1 WHERE Email = '${email}'
    Execute Sql String    UPDATE idm.[User] SET EmailConfirmed = 1 WHERE Email = '${email}'
    Log    Email ${email} is confirmed    console=${LOG_TO_CONSOLE}
    Disconnect From Database


Fill Valid VAT Credentials
    [Documentation]    Fills in all required fields in the SH registration form and submits it.
    Wait For Elements State    xpath=//input[@name="Model.FirstName"]    visible    ${SHORT}    # Wait for "First Name" field
    ${USERNAME_FL}=    FakerLibrary.First Name
    Fill Text    xpath=//input[@name="Model.FirstName"]    ${USERNAME_FL}    # Enter first name
    Wait For Elements State    xpath=//input[@name="Model.LastName"]    visible    ${SHORT}    # Wait for "Last Name" field
    ${LASTNAME_FL}=    FakerLibrary.Last Name
    Fill Text    xpath=//input[@name="Model.LastName"]    ${LASTNAME_FL}    # Enter last name
    Wait For Elements State    xpath=//select[@name="Model.PhoneDialCode"]    visible    ${SHORT}    # Wait for phone country code dropdown
    Click    xpath=//select[@name="Model.PhoneDialCode"]    # Click the phone country code dropdown
    Wait For Elements State    xpath=//select[@name="Model.PhoneDialCode"]    visible    ${SHORT}
    Select Options By    xpath=//select[@name="Model.PhoneDialCode"]    text    +420
    Wait For Elements State    xpath=//input[@name="Model.Phone"]    visible    ${SHORT}    # Wait for "Phone" field
    ${PHONE_NUMBER_FL}=    FakerLibrary.Random Number    digits=9    fix_len=${True}
    Fill Text    xpath=//input[@name="Model.Phone"]    ${PHONE_NUMBER_FL}    # Enter phone number
    ${random_user}=    FakerLibrary.User name
    VAR    ${email}    robot${random_user}@example.com    scope=GLOBAL
    Log    ${email}    console=${LOG_TO_CONSOLE}
    Wait For Elements State    xpath=//input[@name="Model.Email"]    visible    ${SHORT}    # Wait for "Email" field
    Fill Text    xpath=//input[@name="Model.Email"]    ${email}    # Enter email address
    Wait For Elements State    xpath=//input[@name="Model.Password"]    visible    ${SHORT}    # Wait for "Password" field
    Fill Text    xpath=//input[@name="Model.Password"]    ${PASSWORD_LOG}    # Enter password
    Wait For Elements State    xpath=//input[@name="Model.ConfirmPassword"]    visible    ${SHORT}    # Wait for "Confirm Password" field
    Fill Text    xpath=//input[@name="Model.ConfirmPassword"]    ${PASSWORD_CONFIRM_LOG}    # Confirm password
    Click    xpath=//input[@type="checkbox" and contains(@class, "form-check-input")]    # Kliknutie na checkbox "Súhlasím s podmienkami používania"
    Wait For Elements State    xpath=//input[@type="checkbox" and contains(@class, "form-check-input")]    visible    ${SHORT}    # Čakanie, kým sa checkbox zobrazí
    Get Checkbox State    xpath=//input[@type="checkbox" and contains(@class, "form-check-input")]    ==    checked    # Overenie, či je checkbox zaškrtnutý
    Wait For Elements State    xpath=//button[contains(@class, 'x-btn-primary')]    visible    ${SHORT}    # Wait for the submit button
    Click    xpath=//button[contains(@class, 'x-btn-primary')]    # Submit the form

    #    Fill In Business Details With Dynamic IBAN

    # Čakanie na pole "Business Number" a vyplnenie
    Wait For Elements State    xpath=//input[@name="Model.IdentificationNumber"]    visible    ${SHORT}
    ${BUSINESS_NUMBER_FL}=    FakerLibrary.Random Number
    Fill Text    xpath=//input[@name="Model.IdentificationNumber"]    ${BUSINESS_NUMBER_FL}

    Wait For Elements State    xpath=//label[text()='I am the VAT Payer']    visible    ${SHORT}
    Click    xpath=//label[text()='I am the VAT Payer']
    ${VAT_NUMBER}=    Generate Vat Number    CZ
    Wait For Elements State    xpath=//input[@name="Model.VatNumber"]    visible    ${SHORT}
    Fill Text    xpath=//input[@name="Model.VatNumber"]    ${VAT_NUMBER}

    # Výber krajiny "Czech Republic"
    Wait For Elements State    xpath=//select[@name="Model.CountryId"]    visible    ${SHORT}    
    Select Options By    xpath=//select[@name="Model.CountryId"]    text    Czech Republic
    # Vyplnenie názvu firmy
    ${BUSINESS_NAME_FL}=    FakerLibrary.Random Number    digits=15    fix_len=${False}
    Fill Text    xpath=//input[@name="Model.BusinessName"]    ${BUSINESS_NAME_FL}
    # Vyplnenie adresy firmy
    ${BUSINESS_ADDRESS_FL}=    FakerLibrary.Street Address
    Fill Text    xpath=//input[@name="Model.BusinessStreet"]    ${BUSINESS_ADDRESS_FL}
    # Vyplnenie mesta
    ${BUSINESS_CITY_FL}=    FakerLibrary.City
    Fill Text    xpath=//input[@name="Model.BusinessCity"]    ${BUSINESS_CITY_FL}
    # Vyplnenie PSČ
    ${BUSINESS_ZIP_FL}=    FakerLibrary.Postalcode
    Fill Text    xpath=//input[@name="Model.BusinessZipCode"]    ${BUSINESS_ZIP_FL}
    # Vyplnenie IBAN (predpokladáme, že máte vlastnú funkciu na generovanie IBAN)
    ${generated_iban}=    Generate Valid Czech Iban
    Fill Text    xpath=//input[@name="Model.IbanInEuro"]    ${generated_iban}
    # Odoslanie formulára
    Click    xpath=//button[contains(text(), 'Finish')]
    Wait For Elements State    xpath=//div[contains(@class, 'notification-component')]/p    visible    5s
    Get Text    xpath=//div[contains(@class, 'notification-component')]/p    ==    Verification email was sent, check your email.

    Connect To Database
    ...    pyodbc
    ...    db_name=${DB_NAME}
    ...    db_user=${DB_USER}
    ...    db_password=${DB_PASSWORD}
    ...    db_host=${DB_HOST}
    ...    db_port=${DB_PORT}
    ...    odbc_driver={ODBC Driver 17 for SQL Server}
    Log    Connected to database: ${DB_NAME}    console=${LOG_TO_CONSOLE}
    Table Must Exist    Driver
    Execute Sql String    UPDATE dri.Driver SET IsActive = 1 WHERE Email = '${email}'
    Execute Sql String    UPDATE idm.[User] SET EmailConfirmed = 1 WHERE Email = '${email}'
    Log    Email ${email} is confirmed    console=${LOG_TO_CONSOLE}
    Disconnect From Database

Navigate To Hotel Register Page
    [Documentation]    This keyword opens the browser and navigates to the login page.
    ...    This keyword enters valid login credentials and submits the login form.
    ...    It ensures the correct input values for username and password.
    ...    This keyword verifies that the user is redirected to the dashboard
    ...    and that the welcome message is displayed to confirm successful login.
    Wait For Elements State    xpath=//button[text()='Sign Up']    visible    ${SHORT}    # Wait for the "Sign Up" button
    Click    xpath=//button[text()='Sign Up']    # Click the "Sign Up" button to proceed
    Wait For Elements State    xpath=//input[@class='form-check-input' and @value='TravelAgency']    visible    ${SHORT}    # Wait for Shuttle Company registration option
    Click    xpath=//input[@class='form-check-input' and @value='TravelAgency']    # Select Shuttle Company registration option
    Wait For Elements State    xpath=//button[contains(@class, 'x-btn-primary') and contains(text(), 'Select')]    visible    ${SHORT}
    Click    xpath=//button[contains(@class, 'x-btn-primary') and contains(text(), 'Select')]    # Select driver registration option


Fill Valid Hotel Credentials
    [Documentation]    Fills in all required fields in the driver registration form and submits it.
    # Fill in personal details
    Wait For Elements State    xpath=//input[@name="Model.FirstName"]    visible    ${SHORT}    # Wait for "First Name" field
    ${USERNAME_FL}=    FakerLibrary.First Name
    Fill Text    xpath=//input[@name="Model.FirstName"]    ${USERNAME_FL}    # Enter first name
    Wait For Elements State    xpath=//input[@name="Model.LastName"]    visible    ${SHORT}    # Wait for "Last Name" field
    ${LASTNAME_FL}=    FakerLibrary.Last Name
    Fill Text    xpath=//input[@name="Model.LastName"]    ${LASTNAME_FL}    # Enter last name
    Wait For Elements State    xpath=//select[@name="Model.PhoneDialCode"]    visible    ${SHORT}    # Wait for phone country code dropdown
    Click    xpath=//select[@name="Model.PhoneDialCode"]    # Click the phone country code dropdown
    Wait For Elements State    xpath=//select[@name="Model.PhoneDialCode"]    visible    ${SHORT}
    Select Options By    xpath=//select[@name="Model.PhoneDialCode"]    text    +420
    Wait For Elements State    xpath=//input[@name="Model.Phone"]    visible    ${SHORT}    # Wait for "Phone" field
    ${PHONE_NUMBER_FL}=    FakerLibrary.Random Number    digits=9    fix_len=${True}
    Fill Text    xpath=//input[@name="Model.Phone"]    ${PHONE_NUMBER_FL}    # Enter phone number
    ${random_user}=    FakerLibrary.User name
    VAR    ${email}    robot${random_user}@example.com    scope=GLOBAL
    Log    ${email}    console=${LOG_TO_CONSOLE}
    Wait For Elements State    xpath=//input[@name="Model.Email"]    visible    ${SHORT}    # Wait for "Email" field
    Fill Text    xpath=//input[@name="Model.Email"]    ${email}    # Enter email address
    Wait For Elements State    xpath=//input[@name="Model.Password"]    visible    ${SHORT}    # Wait for "Password" field
    Fill Text    xpath=//input[@name="Model.Password"]    ${PASSWORD_LOG}    # Enter password
    Wait For Elements State    xpath=//input[@name="Model.ConfirmPassword"]    visible    ${SHORT}    # Wait for "Confirm Password" field
    Fill Text    xpath=//input[@name="Model.ConfirmPassword"]    ${PASSWORD_CONFIRM_LOG}    # Confirm password
    Click    xpath=//input[@type="checkbox" and contains(@class, "form-check-input")]    # Kliknutie na checkbox "Súhlasím s podmienkami používania"
    Wait For Elements State    xpath=//input[@type="checkbox" and contains(@class, "form-check-input")]    visible    ${SHORT}    # Čakanie, kým sa checkbox zobrazí
    Get Checkbox State    xpath=//input[@type="checkbox" and contains(@class, "form-check-input")]    ==    checked    # Overenie, či je checkbox zaškrtnutý
    Wait For Elements State    xpath=//button[contains(@class, 'x-btn-primary')]    visible    ${SHORT}    # Wait for the submit button
    Click    xpath=//button[contains(@class, 'x-btn-primary')]    # Submit the form

    Connect To Database
    ...    pyodbc
    ...    db_name=${DB_NAME}
    ...    db_user=${DB_USER}
    ...    db_password=${DB_PASSWORD}
    ...    db_host=${DB_HOST}
    ...    db_port=${DB_PORT}
    ...    odbc_driver={ODBC Driver 17 for SQL Server}
    Log    Connected to database: ${DB_NAME}    console=${LOG_TO_CONSOLE}
    Table Must Exist    User
    Execute Sql String    UPDATE idm.[User] SET EmailConfirmed = 1 WHERE Email = '${email}'
    Log    Email ${email} is confirmed    console=${LOG_TO_CONSOLE}
    Disconnect From Database


Verify Valid Register Content On Login Page
    [Documentation]    Verifies that the user is redirected to the dashboard after successful registration.
    ...    This keyword checks that the dashboard displays a welcome message to confirm success.
    Navigate To Register Page
    Wait For Elements State    xpath=//div[@class="upper-logo-part"]//span[text()="My"]    visible    ${SHORT}    # Wait for the "My" text
    Wait For Elements State    xpath=//div[@class="upper-logo-part"]//span[text()="Journey"]    visible    ${SHORT}    # Wait for the "Journey" text
    Wait For Elements State    xpath=//div[@class="lower-logo-part"]//span[text()="Transfers optimization"]    visible    ${SHORT}    # Wait for the "Transfers optimization" text
    Wait For Elements State    xpath=//button[contains(@class, 'tab-button-active') and contains(text(), "Log In")]    visible    ${SHORT}    # Wait for the "Log In" tab
    Wait For Elements State    xpath=//div[@class="inflex-col-center-top"]//a[contains(text(), "Resend confirmation email?")]    visible    ${SHORT}    # Wait for the "Resend confirmation email?" link
    Wait For Elements State    xpath=//div[@class="inflex-col-center-top"]//a[contains(text(), "Forget password?")]    visible    ${SHORT}    # Wait for the "Forget password?" link
    Wait For Elements State    xpath=//button[text()='Sign Up']    visible    ${SHORT}    # Wait for the "Sign Up" button
    Click    xpath=//button[text()='Sign Up']    # Click the "Sign Up" button to proceed
    Wait For Elements State    xpath=//button[contains(@class, 'x-btn-primary') and contains(text(), 'Select')]    visible    ${SHORT}    # Wa
    Click    xpath=//button[contains(@class, 'x-btn-primary') and contains(text(), 'Select')]    # Select driver registration option

*** Settings ***
Resource    ../../common.resource

*** Keywords ***

Create Database Session
    [Documentation]    Creates session for database connection to invoice_db
    Connect To Database Using Custom Connection String    pyodbc    ${DB_CONN_STRING}    invoice_db


Get Invoice By Order Name From DB
    [Documentation]    Gets invoice from DB by order name
    [Arguments]    ${order_name}
    ${count}=    Row Count
    ...    SELECT * FROM inv.Invoice WHERE OrderId = '${order_name}'
    Should Be True    ${count} > 0
    RETURN    ${order_name}

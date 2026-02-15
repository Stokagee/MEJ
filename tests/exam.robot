*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***

${API_URL}    https://dummyjson.com
${title}    Updated Product Name


*** Test Cases ***

Non-existent Product
    [Documentation]    Test API responses for non-existent product and invalid authentication.
    [Tags]    api    negative    p2
    Create Session    alias=new    url=${API_URL}
    ${response}=    GET On Session    alias=new    url=/products/9999    expected_status=404
    Status Should Be    404    ${response}

    ${credentials}=    Create Dictionary    username=fake    password=wrong
    ${response}=    POST On Session    alias=new    url=/auth/login    expected_status=400    json=${credentials}
    Status Should Be    400    ${response}

    ${bad_credentials_response}=    GET On Session    alias=new    url=/auth/me    expected_status=401
    Status Should Be    401    ${bad_credentials_response}



    Log    \n=======\n \n========    console=${LOG_TO_CONSOLE}
    Log    \n=======\n \n========    console=${LOG_TO_CONSOLE}


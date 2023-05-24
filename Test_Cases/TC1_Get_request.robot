*** Settings ***
Library               RequestsLibrary
Library                 Collections



*** Variables ***
${base_url}     http://restapi.demoqa.com/
${city}    Delhi

*** Test Cases ***
Get_Info
    create session    myssion   ${base_url}
    ${response}=    GET On Session    myssion     utilites/weather/city/${city}


#    log to console    ${response.status_code}
#    log to console    ${response.content}
#    log to console    ${response.headers}

    # validation
    ${status_code}=     convert to string    ${response.status_code}
    should be equal    ${status_code}   200

    ${body}=    ${response.content}
    should contain     ${body}      Porag

# ${response.headers} to get all heatders, this is dectonary variable

   ${contentTypeValue}=     get from dictionary    ${response.headers}     Content-Type
   should be equal        ${contentTypeValue}   application/json
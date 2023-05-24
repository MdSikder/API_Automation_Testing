*** Settings ***
Library               RequestsLibrary
Library                 Collections



*** Variables ***
${base_url}     https://restful-booker.herokuapp.com/
${firstname}    porag

*** Test Cases ***
Get_Info
    create session    myssion   ${base_url}
    ${response}=    GET On Session    myssion      booking/1122/${firstname}


#    log to console    ${response.status_code}
#    log to console    ${response.content}
#    log to console    ${response.headers}

    # validation
    ${status_code}=     convert to string    ${response.status_code}
    should be equal    ${status_code}   400

    ${body}=    ${response.content}
    should contain     ${body}      Porag

# ${response.headers} to get all heatders, this is dectonary variable

   ${contentTypeValue}=     get from dictionary    ${response.headers}     Content-Type
   should be equal        ${contentTypeValue}   application/json
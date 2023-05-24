####################################################################################
##  https://thetestingworldapi.com/Help/                                            ##
##  documents 'https://thetestingworldapi.com/Help/Api/POST-api-studentsDetails'      ##
##  api - 'http://thetestingworldapi.com/api/studentsDetails'                       ##
####################################################################################


*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections


*** Variables ***
${Base_URL}=    http://thetestingworldapi.com/
*** Test Cases ***
TC002 create new resource
    create session    AddData   ${Base_URL}
    ${body}=    create dictionary    first_name=Md    middle_name=Porag    last_name=Sikder    date_of_birth=12/12/1990
    # for define body type--header--means what kind of input you send--header could be multiple
    ${header}=  create dictionary    Cotent-Type=application/json

    ${response}=    POST On Session    AddData      api/studentsDetails     data=${body}    headers=${header}




    log to console     ${response.status_code}
    log to console     ${response.content}

    # validation
    ${code}=     convert to string    ${response.status_code}
    should be equal    ${code}   201

    ${body}=    ${response.content}
    should contain     ${body}      tisa
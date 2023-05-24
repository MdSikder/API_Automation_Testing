####################################################################################
##  https://thetestingworldapi.com/Help/                                            ##
##  documents 'https://thetestingworldapi.com/Help/Api/PUT-api-studentsDetails-id'      ##
##  api - 'http://thetestingworldapi.com/api/studentsDetails'                       ##
####################################################################################


*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections


*** Variables ***
${Base_URL}=    https://thetestingworldapi.com
*** Test Cases ***
TC002 create new resource
    create session    AddData   ${Base_URL}
    ${body}=    create dictionary    id=7542856    first_name=Md    middle_name=Rased    last_name=Sikder    date_of_birth=12/12/1988
    # for define body type--header--means what kind of input you send--header could be multiple
    ${header}=  create dictionary    Cotent-Type=application/json

    ${response}=    PUT On Session    AddData      /api/studentsDetails/7542856     data=${body}    headers=${header}




    log to console     ${response.status_code}
    log to console     ${response.content}

    # validation
    ${code}=     convert to string    ${response.status_code}
    should be equal    ${code}   200

#    ${body}=    ${response.content}
#    should contain     ${body}      tisa

    # for check uapdated or not
    ${response}=    get request    AddData      /api/studentsDetails/7542856
    log to console    ${response.content}
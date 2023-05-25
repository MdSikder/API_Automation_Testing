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
${Base_URL}=    https://restful-booker.herokuapp.com
*** Test Cases ***
TC002 create new resource
    create session      AddData      ${Base_URL}
    # to confirm create or not
    ${response}=    GET On Session    AddData      /booking/2957
    log to console     ${response.status_code}
    log to console    ${response.content}

    ${code}=     convert to string    ${response.status_code}
    should be equal    ${code}   200



##    ${body}=   get value from json    ${response.content}  AddData    /booking/453
#    ${body}=    to json    ${response.content}
#    should contain     ${body}      firstname=Porag
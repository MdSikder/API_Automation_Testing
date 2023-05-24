####################################################################################
##  https://thetestingworldapi.com/Help/                                            ##
##  documents 'https://thetestingworldapi.com/Help/Api/DELETE-api-studentsDetails-id'      ##
##  api - 'http://thetestingworldapi.com/api/studentsDetails'                       ##
####################################################################################


*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections


*** Variables ***
${Base_Url}          http://thetestingworldapi.com

*** Test Cases ***
TC003 Delete Request
    create session    AppAccess    ${Base_Url}
    ${response}=    DELETE On Session      AppAccess   /api/studentsDetails/7542709
    log to console     ${response.status_code}
    log to console     ${response.content}

    #validates
    ${code}=    convert to string    ${response.status_code}
    should be equal    ${code}      200

    ${jsonresponse}=    to json    ${response.content}
    @{status_list}=     get value from json     ${jsonresponse}     status
    ${status}=     get from list    @{status_list}   0

    should be equal     ${status}   true

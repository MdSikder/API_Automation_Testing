####################################################################################
##  https://thetestingworldapi.com/Help/                                            ##
##  documents 'http://thetestingworldapi.com/Help/Api/GET-api-studentsDetails'      ##
##  api - 'http://thetestingworldapi.com/api/studentsDetails'                       ##
####################################################################################


*** Settings ***
Library    RequestsLibrary


*** Variables ***
${Base_Url}          http://thetestingworldapi.com/

*** Test Cases ***
TC001 Get Request
    create session    Get_studen_details    ${Base_Url}
    ${response}=    GET On Session    Get_studen_details       api/studentsDetails
    log to console    ${response.status_code}
    log to console    ${response.content}  #for body print

    # validation
    ${status_code}=     convert to string    ${response.status_code}
    should be equal    ${status_code}   200

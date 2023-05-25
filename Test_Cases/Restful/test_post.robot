####################################################################################
##  https://thetestingworldapi.com/Help/                                          ##
##  documents 'https://thetestingworldapi.com/Help/Api/POST-api-studentsDetails'  ##
##  api - 'http://thetestingworldapi.com/api/studentsDetails'                     ##
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

    ${booking_dates}   create dictionary    checkin=2018-01-01    checkout=2019-01-01
    ${body}=    create dictionary    first_name=Md    last_name=porag    totalprice=141    depositpaid=true    bookingdates=${booking_dates}
    # for define body type--header--means what kind of input you send--header could be multiple
    ${header}=  create dictionary    Cotent-Type=application/json
    ${response}=    POST On Session     data=${body}    headers=${header}



    log to console     ${response.status_code}
    log to console     ${response.content}

    # validation
    ${code}=     convert to string    ${response.status_code}
    should be equal    ${code}   201

    ${body}=    to json    ${response.content}
    should contain     ${body}      porag



    # to confirm create or not
    ${response}=    GET On Session    AddData      /booking/
    log to console     ${response.status_code}
    log to console    ${response.content}
*** Settings ***
Library               RequestsLibrary
Library                 Collections


*** Variables ***

${base_url}     https://restful-booker.herokuapp.com

*** Test Cases ***
Post_customer_Info
    create session    mysession   ${base_url}

    ${booking_dates}    Create Dictionary    checkin=2018-01-01    checkout=2019-01-01
    ${body}=    create dictionary       	firstname=Hans    lastname=Gruber    totalprice=200    depositpaid=false    bookingdates=${booking_dates}
    ${header}=  create dictionary   Content-Type=application/json
    ${response}=    POST On Session    mysession      /booking/   data=${body}    headers=${header}

    log to console     ${response.status_code}
    log to console    ${response.content}

    #validations
    ${status_code}=     convert to string    ${response.status_code}
    should be equal    ${status_code}   200

    ${body}=    ${response.content}
    should contain     ${body}      Porag
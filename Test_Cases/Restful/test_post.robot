*** Settings ***
Library    RequestsLibrary
Library    Collections
#Suite Setup    Authenticate as Admin

*** Variables ***
${base_url}     https://restful-booker.herokuapp.com/
${firstname}    porag
*** Test Cases ***
Create a Booking at Restful Booker
    ${booking_dates}    Create Dictionary    checkin=2022-12-31    checkout=2023-01-01
    ${body}    Create Dictionary    firstname=Hans    lastname=Gruber    totalprice=200    depositpaid=false    bookingdates=${booking_dates}
    ${response}    POST    url=https://restful-booker.herokuapp.com/booking    json=${body}
    ${id}    Set Variable    ${response.json()}[bookingid]
    Set Suite Variable    ${id}
    ${response}    GET    https://restful-booker.herokuapp.com/booking/${id}
    Log    ${response.json()}
    Should Be Equal    ${response.json()}[lastname]    Gruber
    Should Be Equal    ${response.json()}[firstname]    Hans
    Should Be Equal As Numbers    ${response.json()}[totalprice]    200
    Dictionary Should Contain Value     ${response.json()}    Gruber


Get Bookings from Restful Booker
    ${body}    Create Dictionary    firstname=John
    ${response}    GET    https://restful-booker.herokuapp.com/booking    ${body}
    Status Should Be    200
    Log List    ${response.json()}
#    log to console    ${response.json()}
    FOR  ${booking}  IN  @{response.json()}
        ${response}    GET    https://restful-booker.herokuapp.com/booking/${booking}[bookingid]
        TRY
            Log    ${response.json()}
        EXCEPT
            Log    Cannot retrieve JSON due to invalid data
        END
    END


test_get
    ${body}    Create Dictionary    firstname=John
    ${response}    GET    https://restful-booker.herokuapp.com/booking    ${body}
#    create session    myssion   ${base_url}
#    ${response}    GET    https://restful-booker.herokuapp.com/booking/${booking}[bookingid]
#    ${response}=    GET On Session    myssion      booking/1122/${firstname}


    log to console    ${response.status_code}
    log to console    ${response.content}
    log to console    ${response.headers}

    # validation
    ${status_code}=     convert to string    ${response.status_code}
    should be equal    ${status_code}   200

    ${body}=    ${response.content}
    log to console    ${response.content}
    should contain     ${body}      Hans

# ${response.headers} to get all heatders, this is dectonary variable

   ${contentTypeValue}=     get from dictionary    ${response.headers}     Content-Type
   should be equal        ${contentTypeValue}   application/json
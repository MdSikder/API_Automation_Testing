####################################################################################
##  https://thetestingworldapi.com/Help/                                            ##
##  documents 'https://thetestingworldapi.com/Help/Api/POST-api-studentsDetails'    ##
##  api - 'http://thetestingworldapi.com/api/studentsDetails'                       ##
####################################################################################

# ************************************---run---*******************************************
# For post -- 'robot --include=post-info Post-Get-Put-Delete/post_get_put_delete.robot'
# For get -- 'robot --include=get-info Post-Get-Put-Delete/post_get_put_delete.robot'
# For put -- 'robot --include=put-info Post-Get-Put-Delete/post_get_put_delete.robot'
# For delete -- 'robot --include=delete-info Post-Get-Put-Delete/post_get_put_delete.robot'

*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
#Suite Setup    Authenticate as Admin
*** Variables ***
${Base_URL}=    https://thetestingworldapi.com
*** Test Cases ***
TC002 create new resource
    [Tags]      post-info
    create session    AddData   ${Base_URL}
    ${body}=    create dictionary    first_name=Md    middle_name=porag    last_name=sorkar    date_of_birth=11/12/1988
    # for define body type--header--means what kind of input you send--header could be multiple
    ${header}=  create dictionary    Cotent-Type=application/json

    ${response}=    POST On Session    AddData      /api/studentsDetails     data=${body}    headers=${header}
    log to console     ${response.status_code}
    log to console     ${response.content}
    # validation
    ${code}=     convert to string    ${response.status_code}
    should be equal    ${code}   201

Get new resource
    [Tags]      get-info
    create session    AddData   ${Base_URL}
    # to confirm create or not
    ${response}=    GET On Session    AddData      /api/studentsDetails/7543132
    log to console    ${response.content}

    Log List    ${response.json()}
    FOR  ${booking}  IN  @{response.json()}
        ${response}    GET    https://restful-booker.herokuapp.com/booking/${booking}'\[id]'
        TRY
            log to console    ${response.json()}
        EXCEPT
            log to console    Cannot retrieve JSON due to invalid data
        END
    END



#    ${body}    Create Dictionary    Cotent-Type=application/json
#    ${response}    GET    https://restful-booker.herokuapp.com/booking    ${body}
#    Status Should Be    200
#    Log List    ${response.json()}
#    FOR  ${booking}  IN  @{response.json()}
#        ${response}    GET    https://restful-booker.herokuapp.com/booking/${booking}[bookingid]
#        TRY
#            Log    ${response.json()}
#        EXCEPT
#            Log    Cannot retrieve JSON due to invalid data
#        END
#    END














Put into new resource
    [Tags]      put-info
    create session    AddData   ${Base_URL}
    ${body}=    create dictionary    id=7543117    first_name=Md    middle_name=Rased    last_name=Sikder    date_of_birth=12/12/1988
    # for define body type--header--means what kind of input you send--header could be multiple
    ${header}=  create dictionary    Cotent-Type=application/json

    ${response}=    PUT On Session    AddData      /api/studentsDetails/7542856     data=${body}    headers=${header}
    log to console     ${response.status_code}
    log to console     ${response.content}

    # validation
    ${code}=     convert to string    ${response.status_code}
    should be equal    ${code}   200

Delete new resource
    [Tags]      delete-info
    create session    AppAccess    ${Base_Url}
    ${response}=    DELETE On Session      AppAccess   /api/studentsDetails/7543116
    log to console     ${response.status_code}
    log to console     ${response.content}
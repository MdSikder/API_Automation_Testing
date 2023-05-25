*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
*** Variables ***
${BaseURL}      https://certtransaction.elementexpress.com/
${BearerToken}      "Bearer    E4F284BFADA11D01A52508ED7B92FFD7EE0905659F5DED06A4B73FC7739B48A287648801
"

*** Test Cases ***
BearerAuthTest
    create session    mysession     ${BaseURL}
    ${headers}  create dictionary    Authorization=${BearerToken}       Content-Type=text/xml

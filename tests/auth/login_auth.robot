*** Settings ***
Library    Browser    jsextension=${CURDIR}/play.js
Library    DataDriver    ../../resources/testData/login_testData.xlsx
Resource    ../../resources/locators/login_locators.robot
Resource    ../../resources/pageObjects/login_pageObjects.robot

Test Template    OpenGoogle
# Test Teardown     Capture And Log Console And Network On Failure
# Test Teardown     Log Failure Reason

*** Variables ***
${url}    https://arnetta.adaptnxt.in/rmswebapp/login
${username}
${password}
${expected_result}

*** Test Cases ***
ValidLoginScenario   
    [Template]    OpenGoogle
    ${username}    ${password}    ${expected_result}

*** Keywords ***
OpenGoogle
    [Arguments]    ${username}    ${password}    ${expected_result}
    OpenBrowser    ${url}
    # New Page    url=${url}
    EnterUserName    ${username}
    EnterPassword    ${password}
    SignInButton    ${signinButton}
    ${currentURL}=    Get Url   
    ${logs}=    browserLogs    ${currentURL}
    ValidateUrl    ${expected_result}


# Capture And Log Console And Network On Failure
#     Run Keyword If    '${TEST STATUS}' != 'PASS'    Capture And Log Console And Network

# Capture And Log Console And Network
#     ${console_logs}    ${network_requests}=    Capture Logs    ${url}
#     Log    Console Logs: ${console_logs}
#     Log    Network Requests: ${network_requests} 

   
# Log Failure Reason
#     Run Keyword If    '${TEST STATUS}' != 'PASS'    Append Failure To Log File

# Append Failure To Log File
#     ${test_name}=    Get Variable Value    ${TEST NAME}
#     ${date_time}=    Get Time    format=%Y-%m-%d %H:%M:%S
#     ${log_message}=    Catenate    SEPARATOR=\n    Test Case: ${test_name}    Date/Time: ${date_time}    Failure Reason: ${TEST MESSAGE}\n
#     Append To File    ${OUTPUT_DIR}/test_failures.txt    ${log_message}

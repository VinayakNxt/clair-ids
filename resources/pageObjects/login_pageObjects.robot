*** Settings ***
Library    Browser
Resource    ../../resources/locators/login_locators.robot

*** Keywords ***
OpenBrowser
    [Arguments]    ${url}
    New Browser    chromium    headless=False
    New Page    url=${url}

EnterUserName
    [Arguments]    ${username}
    Type Text    ${usernameTextField}    ${username}

EnterPassword
    [Arguments]    ${password}
    Type Text    ${passwordTextField}     ${password}

SignInButton
    [Arguments]    ${signinButton}
    Click    ${signinButton}

ValidateUrl
    [Arguments]    ${expected_result}
    ${currentUrl}    Get Url
    Should Be Equal    ${currentUrl}    ${expected_result}
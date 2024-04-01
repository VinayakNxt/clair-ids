# *** Settings ***
# Library    CustomBrowserActions.py

# *** Test Cases ***
# Capture Console Logs
#     ${console_logs}=    Capture Console Logs    https://arnetta.adaptnxt.in/rmswebapp/login
#     Log    ${console_logs}


*** Settings ***
Library    NetworkLogger.PlaywrightLogCapturer

*** Test Cases ***
Capture Browser Logs Synchronously
    ${console_logs}    ${network_requests}=    Capture Logs    https://arnetta.adaptnxt.in/rmswebapp/login
    Log    ${console_logs}
    Log    ${network_requests}



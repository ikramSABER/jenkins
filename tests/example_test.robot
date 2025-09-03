*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://example.com

*** Test Cases ***
Open Example Page
    Log To Console     \n--- Running test with REMOTE_URL=${REMOTE_URL} and BROWSER=${BROWSER} ---
    Open Browser    ${URL}    ${BROWSER}    remote_url=${REMOTE_URL}
    Title Should Be    Example Domain
    [Teardown]    Close All Browsers

*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Variables ***
${URL}    https://www.example.com
${REMOTE_URL}    http://selenium_firefox:4444/wd/hub

*** Test Cases ***
Open Example Page
    [Documentation]    Open a page in remote Selenium browser
    Log To Console     \n--- Running test with REMOTE_URL=${REMOTE_URL} ---
    Open Browser    ${URL}    chrome    remote_url=${REMOTE_URL}
    Title Should Be    Example Domain
    Close Browser

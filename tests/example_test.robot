*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.google.com

*** Test Cases ***
Open Example Page
    [Documentation]    Open a page in remote Selenium browser
    Open Browser    ${URL}    chrome    remote_url=${REMOTE_URL}
    Title Should Be    Example Domain
    Close Browser

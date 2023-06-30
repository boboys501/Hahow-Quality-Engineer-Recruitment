*** Settings ***
Library           SeleniumLibrary
Library           Collections
Resource          ../locators/ui_locator.robot
Suite Setup       Open Browser and go to target
Test Teardown     go to    ${url}

*** Variable ***
${url}            https://github.com/hahow/hahow-recruit
${browser}        Chrome
${headless}       headlessChrome

*** Keywords ***
Open Browser and go to target
    Open Browser    ${url}    ${headless}    options=add_argument("--window-size=1280,768")

Wait and Scroll into Element
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=10s
    Scroll Element Into View    ${locator}

Wait and Click Element
    [Arguments]    ${locator}
    Wait and Scroll into Element    ${locator}
    Click Element    ${locator}

Get contributors count
    Wait and Scroll into Element    ${Contributors icon}
    ${count}=    Get Element Count    ${Contributors icon}
    Should Be Equal As Integers    ${count}    11
    Set Test Message    Contributors count is ${count}

Get contributors name list
    Wait and Click Element    ${Contributors link}
    Wait and Scroll into Element    ${Contributors user name}
    @{elements}=    Get WebElements    ${Contributors user name}
    ${name_list}=    Create List
    FOR    ${item}    IN    @{elements}
        Append To List    ${name_list}    ${item.text}
    END
    Set Test Message    Contributors List:${name_list}

Go to frontend.md
    Wait and Click Element    ${frontend.md}

Check Wireframe image exists
    Wait and Scroll into Element    ${wireframe}
    Wait and Scroll into Element    ${Wireframe hero list img}
    Capture Page Screenshot    hero_list_check.png
    Wait and Scroll into Element    ${Wireframe hero profile img}
    Page Should Contain Element   ${Wireframe hero list img}
    Page Should Contain Element   ${Wireframe hero profile img}
    Capture Page Screenshot    hero_profile_check.png

Go to commits page
    Wait and Click Element    ${commits link}

Check Last Commit
    Wait and Scroll into Element    ${last commit contributor}
    ${name}=    Get Text    ${last commit contributor}
    Set Test Message    Last commit user is ${name}

*** Test Case ***
Count of Contributors
    Get contributors count

list Contributors names
    Get contributors name list

Check if Wireframe image exists on frontend.md
    Go to frontend.md
    Check Wireframe image exists

Identify last commit user name
    Go to commits page
    Check Last Commit
    

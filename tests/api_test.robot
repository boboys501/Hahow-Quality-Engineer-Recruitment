*** Settings ***
Library    Collections        
Library    RequestsLibrary    
Library    BuiltIn            
Library    JSONLibrary

*** Keywords ***
Read local json
    [Documentation]    讀取Local Json檔用以測試
    [Arguments]        ${file_path}
    ${json_data}=      JSONLibrary.Load Json From File    ${file_path}
    [Return]           ${json_data}                       

Create film list and sorting
    [Arguments]       @{data}
    ${list}=          Create List
    FOR               ${item}                IN                         @{data}
    ${title}=         Get From Dictionary    ${item}                    title
    ${episode_id}=    Get From Dictionary    ${item}                    episode_id
    ${moive_list}=    Create List            ${episode_id}, ${title}
    Append To List    ${list}                ${moive_list}
    END
    Sort List         ${list}
    [Return]          ${list} 

Parser Vehicles details
    [Arguments]          ${base}         
    # 取得頁面的資料
    ${response}=         GET             ${base}
    ${count}=            Set Variable    ${response.json()['count']}/10
    ${vehicles_list}=    Create List

    FOR                           ${index}               IN RANGE                         ${count}
    ${data}=                      Set Variable           ${response.json()['results']}
        # 遞迴取得Name, max_atmosphering_speed
    FOR                           ${item}                IN                               @{data}
    ${name}=                      Get From Dictionary    ${item}                          name
    ${max_atmosphering_speed}=    Get From Dictionary    ${item}                          max_atmosphering_speed
    ${add_item}=                  Create Dictionary      name=${name}                     max_atmosphering_speed=${max_atmosphering_speed}
    Append To List                ${vehicles_list}       ${add_item}                      
    END
        # 檢查有沒有下一頁，沒有下一頁就跳出迴圈
    ${base}=                      Get From Dictionary    ${response.json()}               next
    Run Keyword If                '${base}' == 'None'    
    ...                           Exit For Loop
        # 沒跳出迴圈的話就拿新的base取得response
    ${response}=                  GET                    ${base}
    END
    [Return]                      ${vehicles_list}

Filter vehicles with speed over 1000
    [Arguments]                   ${vehicles_list} 
    ${final_list}=                Create List
    FOR                           ${item}                                     IN                           @{vehicles_list}
    ${max_atmosphering_speed}=    Get From Dictionary                         ${item}                      max_atmosphering_speed
    IF                            '${max_atmosphering_speed}' != 'unknown'    
    ${max_atmosphering_speed}=    Convert To Integer                          ${max_atmosphering_speed}
    IF                            ${max_atmosphering_speed} > 1000
    Append To List                ${final_list}                               ${item}
    END
    END                           
    END
    [Return]                      ${final_list}

*** Test Cases ***
Quick Get Request Test
    ${response}                    GET                        https://swapi.dev/api/ 
    should be equal as integers    ${response.status_code}    200

Count of Different species in Film 6
    ${response}                    GET                                                 https://swapi.dev/api/films/6/
    ${count}                       Get length                                          ${response.json()}[species]
    should be equal as integers    ${count}                                            20
    Set Test Message               Count of Different species in Film 6 is ${count}

Sort Movie Names by Film Series
    ${response}         GET                             https://swapi.dev/api/films/
    @{results}          Set Variable                    ${response.json()['results']}
    ${list}=            Create film list and sorting    @{results}
    Set Test Message    ${list}

List Vehicles with Speed Over 1000 in Movies
    ${base}               Set Variable                            https://swapi.dev/api/vehicles/
    ${vehicles_list} =    Parser Vehicles details                 ${base}
    ${final_list}=        Filter vehicles with speed over 1000    ${vehicles_list} 
    Set Test Message      ${final_list}

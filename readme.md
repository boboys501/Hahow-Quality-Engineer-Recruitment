# Hahow Quality Engineer 徵才小專案
## Description
- As the title, this mini project is for the Hahow Quality Engineer recruitment.
- Use Robot Framework and Vscode.

## How to use?
1. Clone this Project.
2. Install requirements.

        git clone 
        cd Hahow-Quality-Engineer
        pip install -r requirements.txt  

3. Excute.

        robot -d reports/ test/

##  Dictionary structure

    ├── reports/                    # 測試報告 
    ├── tests/                  
    │  ├── api_test.robot           # API測試
    │  ├── ui_test.robot            # UI測試
    │  └── chromedriver.exe         # WebDriver
    ├── .gitattributes
    ├── .gitignore
    ├── README.md
    └── requirements.txt 


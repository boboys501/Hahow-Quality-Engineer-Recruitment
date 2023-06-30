# Hahow Quality Engineer Recruitment
### Description
- Test Framework: Robot Framework
- IDE: VS Code

## How to use?
1. Clone this Project.
2. Download Chrome WebDriver https://chromedriver.chromium.org/downloads, and put it in Dictionary.
3. Install requirements.

        pip install -r requirements.txt  
4. Excute.

        robot -d reports/ test/

##  Dictionary structure

    ├── reports/                    # Test Report and Screen Shot Img
    ├── tests/                  
    │  ├── api_test.robot           # API test robot
    │  └── ui_test.robot            # UI test robot
    ├── locators/  
    │  └── ui_locator.robot         # UI Locator
    ├── chromedriver.exe            # WebDriver
    ├── .gitattributes
    ├── .gitignore
    ├── README.md
    └── requirements.txt 


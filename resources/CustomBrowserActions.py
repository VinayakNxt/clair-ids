from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager

def capture_console_logs(url):
    # Setup Chrome options
    chrome_options = Options()
    # Enable browser logging
    chrome_options.set_capability('goog:loggingPrefs', {'browser': 'ALL'})
    
    # Initialize the Chrome driver
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)
    
    # Navigate to the URL
    driver.get(url)
    
    # Retrieve and print console logs
    console_logs = driver.get_log('browser')
    print("Console Logs:")
    for log in console_logs:
        print(log)
    
    driver.quit()
    return console_logs

#installing and loading the packages :

install.packages("RSelenium")
install.packages("httr")
install.packages("XML")
install.packages("rvest")

library(RSelenium)
library(httr)
library(XML)
library(rvest)

#start a Selenium Server and create a driver object for browser automation
rm.driver <- rsDriver(
  browser = "firefox",  #browser type to control
  phantomver = NULL, # Specifies the version of PhantomJS to use as NULL
  chromever = NULL) # Specifies the version of ChromeDriver as NULL since we use Firefox
rm <- rm.driver$client



# check session status
rm$getStatus() # if you got $ready[1] TRUE && $message [1] "Server is running" means it's working fine

#terminate session using cmd (this is how I terminate)
# C:\Users\ASUS>netstat -ano | findstr :4567
# TCP    0.0.0.0:4567           0.0.0.0:0              LISTENING       10244
# TCP    [::]:4567              [::]:0                 LISTENING       10244
# 
# C:\Users\ASUS>taskkill /PID 10244 /F
# SUCCESS: The process with PID 10244 has been terminated.

# here we are selecting both furnished and unfurnished apartment in the selected city without any other filter since we want to 
# collect all the housing ads to check the prices and the correlation of size and pricing. 

# Go to the qasa website ad list
url <- paste0("https://", "******/en/find-home?homeTypes=apartment&searchAreas=Stockholm~~se&furnished=unfurnished,furnished")
rm$navigate(url)

# Give it sometime to load the website. 
Sys.sleep(1) 
# Locate the "Accept all" button using the class name from dialog box
accept_cookie_button <- rm$findElement(using = "css selector", ".qds-10f05bf.eym1m0z14")
# Click the "Accept all" button
accept_cookie_button$click()

# =========== try whethere there is a way to automate the page number. 
# Find the last page link using its class and href attributes
page_elements <- rm$findElements(using = 'css selector', 'div.qds-uvzinv.eym1m0z53 a')[[6]]
last_page <- page_elements$getElementText() # here we capture that the last page is 32

#==================================


# We notice there are 32 pages.
#Lets try to iterate through each page and collect all the advertiesment. 
for(page in 1:2){
  #Find all ad containers
  #We can notice that there are 60 ads in each page
  ad_container <- rm$findElements(using = 'css selector', 'div.qds-2bbao8.e1v66ncn1 a')
  
}




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

# Go to the qasa website
url <- paste0("https://", "******/en")
rm$navigate(url)

# Give it sometime to load the website. 
Sys.sleep(1) 
# Locate the "Accept all" button using the class name from dialog box
accept_cookie_button <- rm$findElement(using = "css selector", ".qds-10f05bf.eym1m0z14")
# Click the "Accept all" button
accept_cookie_button$click()

# Wait for the page to load
Sys.sleep(5)
# Locate the search text box by its ID and input the city name "Stockholm"
search_box <- rm$findElement(using = "css selector", "#downshift-\\:Radql1l7rmkqfatcva\\:-input")
search_box$sendKeysToElement(list("S"))
Sys.sleep(2)
search_box$sendKeysToElement(list("t"))
Sys.sleep(2)
search_box$sendKeysToElement(list("o"))
Sys.sleep(2)
search_box$sendKeysToElement(list("c"))
Sys.sleep(2)
search_box$sendKeysToElement(list("k"))
Sys.sleep(2)
search_box$sendKeysToElement(list("h"))
Sys.sleep(2)
search_box$sendKeysToElement(list("o"))
Sys.sleep(2)
search_box$sendKeysToElement(list("l"))
Sys.sleep(2)
search_box$sendKeysToElement(list("m"))

# Wait for the page to load
Sys.sleep(5)
# Wait for the page to load
Sys.sleep(1)

# Locate the <form> element by its class name
form_element <- rm$findElement(using = "css selector", "form.qds-1vkiv0d.em8mlxq0")

if (!is.null(form_element)) {
  # Locate the <div> element within the <form> by its ID
  div_element <- form_element$findElement(using = "css selector", "div.qds-79elbk.efv1kq00")
  
  if (!is.null(div_element)) {
    # Locate the <ul> element inside the <div> by its ID
    ul_element <- div_element$findElement(using = "css selector", "ul.qds-1dqxrx0")
    
    if (!is.null(ul_element)) {
      # Locate the <li> element within the <ul> by its ID
      li_element <- ul_element$findElement(using = 'id', "downshift-:Radql1l7rmkqfatcva:-item-0")
      
      if (!is.null(li_element)) {
        # Locate the <span> element inside the <li>
        span_element <- li_element$findElement(using = "css selector", "span")
        
        if (!is.null(span_element)) {
          # Get the text inside the <span>
          span_text <- span_element$getElementText()
          
          # Check if the text is "Stockholm"
          if (span_text == "Stockholm") {
            print("The first <li> contains 'Stockholm' in the span.")
          } else {
            print("The first <li> does not contain 'Stockholm' in the span.")
          }
          
        } else {
          print("The first <li> does not contain 'Stockholm' in the span.")
        }
        
        }else {
          print("No <li> element with the specified ID found.")
        }
      
    } else {
      print("No <ul> element found with the specified ID inside the <form>.")
    }
    
  }else {
    print("No <div> element found with the specified class name.")
  }
  
  
}else {
  print("No <form> element found with the specified class name.")
}
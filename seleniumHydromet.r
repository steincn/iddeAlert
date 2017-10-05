rm(list=ls())
library(RSelenium)


## load docker, run: docker run -d -p 4445:4444 selenium/standalone-firefox
## to kill dockers : docker rm -f $(docker ps -a -q)

## load RSelenium
remDr <- remoteDriver(remoteServerAddr = "192.168.99.100",
                      port = 4445L,
                      browserName = "chrome")  ## not sure if chrome is reaaly needed

## Opens connection or somehting to server
remDr$open()

## give url
remDr$navigate("http://www.hydrometcloud.com/hydrometcloud/")

## Set display option and pull a screen shot
remDr$setWindowSize(width = 800, height = 1000)
remDr$screenshot(display = TRUE)

## Needlessly pull url
remDr$getCurrentUrl()


#############################################################################
## Login
## Login button
webElem <- remDr$findElement('xpath',
                             "/html/body/section/div[1]/div/div/div/div[1]/input")
webElem$clickElement()

## User name and Pass
cred <- list(NA, NA) ## pull from file
webElem <- remDr$findElement('xpath',
                              "//*[@id='userName']")
webElem$sendKeysToElement(cred[1]) ## paste user

webElem <- remDr$findElement('xpath',
                              "//*[@id='password']")
webElem$sendKeysToElement(cred[2]) ## paste pass

webElem <- remDr$findElement('xpath',
                              "//*[@id='btnValue']")
remDr$screenshot(display = TRUE)
webElem$clickElement() ## click login in button

#############################################################################
## Navigate table to Long creek, select parameters, go to report
## click
webElem <- remDr$findElement('xpath',
                              "/html/body/section/div[1]/header/div/div[3]/ul/li[4]/a")
webElem$clickElement()

webElem <- remDr$findElement('xpath',
                             "//*[@id='selectionCriteriaTree']/ul/li/span/span[1]")
webElem$clickElement()

webElem <- remDr$findElement('xpath',
                             "//*[@id='selectionCriteriaTree']/ul/li/ul/li[4]/span/span[1]")
webElem$clickElement()
remDr$screenshot(display = TRUE)


## pH
webElem <- remDr$findElement('xpath',
                             "//*[@id='selectionCriteriaTree']/ul/li/ul/li[4]/ul/li[5]/span/span[2]")
webElem$clickElement()

## SpCond
webElem <- remDr$findElement('xpath',
                             "//*[@id='selectionCriteriaTree']/ul/li/ul/li[4]/ul/li[7]/span/span[2]")
webElem$clickElement()

## Turb
webElem <- remDr$findElement('xpath',
                             "//*[@id='selectionCriteriaTree']/ul/li/ul/li[4]/ul/li[10]/span/span[2]")
webElem$clickElement()
remDr$screenshot(display = TRUE)

## Click Reports Tab
webElem <- remDr$findElement('xpath',
                             "//*[@id='tab3']")
webElem$clickElement()
Sys.sleep(2); remDr$screenshot(display = TRUE)

#############################################################################
## Copy stuff out of talbe

## Set up container for date times
dateHolder <- NULL
phHolder <- NULL
condHolder <- NULL
turbHolder <- NULL

for (i in 1:10) {
    ## Dates
    tempDate <- paste0("//*[@id='reportInner']/div/div[3]/div/div[2]/div[2]/table/tbody/tr[",
                      3+i,
                      "]/td[1]")
    webElem <- remDr$findElement('xpath', tempDate)
    dateHolder <- rbind(dateHolder, webElem$getElementText()[[1]])

    ## pH
    temppH <- paste0("//*[@id='reportInner']/div/div[3]/div/div[2]/div[2]/table/tbody/tr[",
                      3+i,
                      "]/td[2]")
    webElem <- remDr$findElement('xpath', temppH)
    phHolder <- rbind(phHolder, webElem$getElementText()[[1]])

    ## k
    tempK <- paste0("//*[@id='reportInner']/div/div[3]/div/div[2]/div[2]/table/tbody/tr[",
                      3+i,
                      "]/td[3]")
    webElem <- remDr$findElement('xpath', tempK)
    condHolder <- rbind(condHolder, webElem$getElementText()[[1]])

    ## pH
    tempTurb <- paste0("//*[@id='reportInner']/div/div[3]/div/div[2]/div[2]/table/tbody/tr[",
                      3+i,
                      "]/td[4]")
    webElem <- remDr$findElement('xpath', tempTurb)
    turbHolder <- rbind(turbHolder, webElem$getElementText()[[1]])


}

## Make a data frame
ds <- data.frame(dt=as.POSIXct(dateHolder), pH=as.numeric(phHolder),
                    k=as.numeric(condHolder), turb=as.numeric(turbHolder))

ds <- ds[order(ds$dt),]

#############################################################################
## Log out
webElem <- remDr$findElement('xpath',
                             "/html/body/section/div[1]/div/div/div/div[1]/form[1]/button")
webElem$clickElement()
remDr$screenshot(display = TRUE)

## Reset URL
remDr$navigate("http://www.hydrometcloud.com/hydrometcloud/")




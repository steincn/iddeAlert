rm(list=ls())
library(RSelenium)

##https://stackoverflow.com/questions/45395849/cant-execute-rsdriver-connection-refused

## load docker, run: docker run -d -p 4445:4444 selenium/standalone-firefox
## to kill dockers : docker rm -f $(docker ps -a -q)

## load RSelenium
remDr <- remoteDriver(remoteServerAddr = "192.168.99.100",
                      port = 4445L,
                      browserName = "chrome")  ## not sure if chrome is reaaly needed

## Opens connection or somehting to server
remDr$open()

## give url
remDr$navigate("http://www.sutronwin.com/mecklenburg/jsp/CustomReport/CustomReports.jsp?menu=CustomReports")

## Set display option and pull a screen shot
remDr$setWindowSize(width = 800, height = 1000)
remDr$screenshot(display = TRUE)

## Needlessly pull url
remDr$getCurrentUrl()





## webElem <- remDr$findElement('xpath',
##                              "//li[(((count(preceding-sibling::*) + 1) = 10) and parent::*)]//*[contains##(concat( ' ', @class, ' ' ), concat( ' ', 'dynatree-expander', ' ' ))]")

## Chrome inspect copy xpath to get snippets of what to click
webElem <- remDr$findElement('xpath',
                             "//*[@id='selectionCriteriaTree']/ul/li[10]/span/a")

## Click element and pull a screen grab for verification
webElem$clickElement()
remDr$screenshot(display = TRUE)

## Expand a tree
webElem2 <- remDr$findElement('xpath',
                              "//*[@id='selectionCriteriaTree']/ul/li[10]/ul/li[3]/span/span[2]")

## Click and capture
webElem2$clickElement()
remDr$screenshot(display = TRUE)

## Table button
webElem3 <- remDr$findElement('xpath',
                              "//*[@id='btnTable']/span/b")
## Click, wait caputure
webElem3$clickElement()
Sys.sleep(4)
remDr$screenshot(display = TRUE)

## SEt up container for date times
dateHolder <- NULL

## Get date 1
webElem4 <- remDr$findElement('xpath',
                  "//*[@id='reportInner']/div/div[3]/div/div[1]/div[2]/table/tbody/tr[4]/td")
dateHolder <- rbind(dateHolder, webElem4$getElementText()[[1]])

## Get date 2
webElem5 <- remDr$findElement('xpath',
                  "//*[@id='reportInner']/div/div[3]/div/div[1]/div[2]/table/tbody/tr[5]/td")
dateHolder <- rbind(dateHolder, webElem5$getElementText()[[1]])


## Get date 3
webElem6 <- remDr$findElement('xpath',
                  "//*[@id='reportInner']/div/div[3]/div/div[1]/div[2]/table/tbody/tr[6]/td")
dateHolder <- rbind(dateHolder, webElem6$getElementText()[[1]])


## pick up here,






//*[@id="selectionCriteriaTree"]/ul/li[10]/ul/li[3]/span
webElem2 <- remDr$findElement('xpath',
                              ".//*[text()[contains(.,'BVD')]]

webElem <- remDr$findElement('xpath',
                             "//input[@id = 'selectionCriteriaTreeMain']")

webElem <- remDr$findElement('xpath',
                             "//input[@class = 'dynatree-checkbox']")

webElem <- remDr$findElement(using = 'id',
                             value = "selectionCriteriaTreeMain")


webElem <- remDr$findElement(using = 'class',
                             value = "blue_treeview customtree")


webElem <- remDr$findElement('xpath',
                             "//*[contains(concat( ' ', @class, ' ' ), concat( ' ', 'dynatree-expander', ' ' ))]")

## Fun works as expected when stepped through via debug, but fails
##  as a fun call.  Issue probably due to local scope or docker access
pullCmann <- function(){

    remDr$open()
    ## give url
    remDr$navigate("http://www.hydrometcloud.com/hydrometcloud/")

    browser()


    ## Login
    ## Login button
    webElem <- remDr$findElement('xpath',
                                 "/html/body/section/div[1]/div/div/div/div[1]/input")
    webElem$clickElement(); Sys.sleep(1)

    ## User name and Pass
    cred <- list(NA, NA) ## Set up config to pull from file
    webElem <- remDr$findElement('xpath',
                                 "//*[@id='userName']")
    webElem$sendKeysToElement(cred[1]) ## paste user

    webElem <- remDr$findElement('xpath',
                                 "//*[@id='password']")
    webElem$sendKeysToElement(cred[2]) ## paste pass

    webElem <- remDr$findElement('xpath',
                                 "//*[@id='btnValue']")
    webElem$clickElement(); Sys.sleep(1.5) ## click login in button

    ## Navigate table to Long creek, select parameters, go to report
    ## click
    remDr$screenshot(display = TRUE)
    webElem <- remDr$findElement('xpath',
                                 "/html/body/section/div[1]/header/div/div[3]/ul/li[4]/a")
    webElem$clickElement()

    remDr$screenshot(display = TRUE)

    webElem <- remDr$findElement('xpath',
                                 "//*[@id='selectionCriteriaTree']/ul/li/span/span[1]")
    webElem$clickElement()

    webElem <- remDr$findElement('xpath',
                                 "//*[@id='selectionCriteriaTree']/ul/li/ul/li[4]/span/span[1]")
    webElem$clickElement()

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

    ## Click Reports Tab
    webElem <- remDr$findElement('xpath',
                                 "//*[@id='tab3']")
    webElem$clickElement()
    Sys.sleep(2); remDr$screenshot(display = TRUE)

    ## Copy stuff out of talbe

    ## Set up container for date times
    dateHolder <- NULL
    phHolder <- NULL
    condHolder <- NULL
    turbHolder <- NULL

    for (i in 1:10) {
        ## Dates
        tempDate <- paste0(
            "//*[@id='reportInner']/div/div[3]/div/div[2]/div[2]/table/tbody/tr[",
            3+i, "]/td[1]")
        webElem <- remDr$findElement('xpath', tempDate)
        dateHolder <- rbind(dateHolder, webElem$getElementText()[[1]])

        ## pH
        temppH <- paste0(
            "//*[@id='reportInner']/div/div[3]/div/div[2]/div[2]/table/tbody/tr[",
            3+i, "]/td[2]")
        webElem <- remDr$findElement('xpath', temppH)
        phHolder <- rbind(phHolder, webElem$getElementText()[[1]])

        ## k
        tempK <- paste0(
            "//*[@id='reportInner']/div/div[3]/div/div[2]/div[2]/table/tbody/tr[",
            3+i, "]/td[3]")
        webElem <- remDr$findElement('xpath', tempK)
        condHolder <- rbind(condHolder, webElem$getElementText()[[1]])

        ## pH
        tempTurb <- paste0(
            "//*[@id='reportInner']/div/div[3]/div/div[2]/div[2]/table/tbody/tr[",
            3+i, "]/td[4]")
        webElem <- remDr$findElement('xpath', tempTurb)
        turbHolder <- rbind(turbHolder, webElem$getElementText()[[1]])
    }

    browser()

    ## Make a data frame
    ds <- data.frame(dt=as.POSIXct(dateHolder), pH=as.numeric(phHolder),
                     k=as.numeric(condHolder), turb=as.numeric(turbHolder))

    ds <- ds[order(ds$dt),]


    ## Log out
    webElem <- remDr$findElement('xpath',
                                 "/html/body/section/div[1]/div/div/div/div[1]/form[1]/button")
    webElem$clickElement()

    ## Reset URL
    remDr$navigate("http://www.hydrometcloud.com/hydrometcloud/")
    ##remDr$close()
    return(ds)
}







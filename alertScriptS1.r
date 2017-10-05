######################### CLEAR STUFF #######################################
rm(list=ls()); graphics.off()
suppressPackageStartupMessages(library("dataRetrieval"))
suppressPackageStartupMessages(library("dplyr"))
suppressPackageStartupMessages(library("gmailr"))
suppressPackageStartupMessages(library("RSelenium"))

## Set dir for script while in batch mode, load gmail credentials
setwd("c:/Users/95218/Documents/R/public/iddeAlert")
use_secret_file('idde-alert.json')

## Source Rselenium file
source("c:/Users/95218/Documents/R/public/iddeAlert/selFun.r")

#############################################################################
## Flow
QParameterCd <- "00065" ## stage, feet
startTime <- Sys.Date()-1 ## yesterday

## Pull most recent data
recentQ <- readNWISuv(siteNumbers="02146409", # litte sugar
                             parameterCd=QParameterCd,
                             startDate=startTime, tz="America/New_York")

## Subset out last hours worth
rQ <- filter(recentQ, dateTime>Sys.time()-3600)

#############################################################################
## Precip
PParameterCd <- "00045" ## rainfall inches

## Pull most recent data
recentP <- readNWISuv(siteNumbers="351229080480145", ## CRN 66
                             parameterCd=PParameterCd,
                             startDate=startTime, tz="America/New_York")

## Subset out last TWO hours worth
rP <- filter(recentP, dateTime>Sys.time()-7200)

## Pull most recent data
recentP2 <- readNWISuv(siteNumbers="351320080502645", ## CRN 15
                             parameterCd=PParameterCd,
                             startDate=startTime, tz="America/New_York")

## Subset out last TWO hours worth
rP2 <- filter(recentP2, dateTime>Sys.time()-7200)

#############################################################################
## CMANN
cmann <- pullCmann()


#############################################################################
## Print to log file
print("########")
print(Sys.time())
print(rQ[,4])
print(rP[,4])
print(rP2[,4])


#############################################################################
## Assess data, send email if conditions met

## The if statement below is the bulk of the action.
## Here, if in last hour, stage jumped more than X &
##   precip in the 2 hour window is less than .15", Alert!

if (max(diff(rQ[,4], lag=2)) >= 0.02 & ## configure...
    sum(rP[,4]) < 0.10 &
    sum(rP2[,4]) < 0.10){ ## configure..

    ## Create email via gmailr
    testEmail <- mime() %>%
        to("joel.nipper@charlottenc.gov") %>%
        from("idde.alert@gmail.com") %>%
        subject("Alert!") %>%
        ## This needs work, e.g., include how much it jumped.
        html_body("<html>
                 <p><b>This is an automated alert.</b></p>
                 <p>The Little Sugar USGS gage has increased unexpectedly.</p>
                 <p><a href='https://waterdata.usgs.gov/nwis/uv?site_no=02146409'>Little Sugar Gage</a></p>
                 <p><a href='https://waterdata.usgs.gov/nwis/uv?site_no=351320080502645'>CRN 15 (Uptown)</a></p>
               </html>")

    ## Send email
    send_message(testEmail)
    print("!!!!!!######!!!!!ALERT SENT!!!!!######!!!!!!")
}

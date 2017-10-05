library(taskscheduleR)
library(RSelenium)

## load docker, run: docker run -d -p 4445:4444 selenium/standalone-firefox

## load RSelenium
remDr <<- remoteDriver(remoteServerAddr = "192.168.99.100",
                      port = 4445L,
                      browserName = "chrome")  ## not sure if chrome is reaaly needed

## Opens connection or somehting to server
##remDr$open()

## Run every minute
taskscheduler_create(taskname="usgsSeleniumTest",
                     rscript='C:\\Users\\95218\\Documents\\R\\public\\iddeAlert\\alertScriptS1.r',
                     schedule="MINUTE", modifier=15, ## run it every 2 minutes
                     starttime=format(Sys.time(), "%H:%M"), ## starting in 6 seconds....
                     startdate=format(Sys.Date(),"%m/%d/%Y")) ## this needed for date formatting


## Get a data.frame of all tasks
tasks <- taskscheduler_ls()
str(tasks)

## To delete the task
taskscheduler_delete(taskname = "usgsTest")

## to kill dockers : docker rm -f $(docker ps -a -q)







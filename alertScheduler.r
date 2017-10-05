library(taskscheduleR)

## Run every minute
taskscheduler_create(taskname="usgsTest",
                     rscript='C:\\Users\\95218\\Documents\\R\\public\\iddeAlert\\alertScript.r',
                     schedule="MINUTE", modifier=15, ## run it every 2 minutes
                     starttime=format(Sys.time(), "%H:%M"), ## starting in 6 seconds....
                     startdate=format(Sys.Date(),"%m/%d/%Y")) ## this needed for date formatting


## Get a data.frame of all tasks
tasks <- taskscheduler_ls()
str(tasks)

## To delete the task
taskscheduler_delete(taskname = "usgsTest")







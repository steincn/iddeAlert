######################### CLEAR STUFF #######################################
rm(list=ls()); graphics.off()
suppressPackageStartupMessages(library("dataRetrieval"))
suppressPackageStartupMessages(library("dplyr"))
suppressPackageStartupMessages(library("gmailr"))
suppressPackageStartupMessages(library("ggplot2"))
suppressPackageStartupMessages(library("gridExtra"))

## Set dir for script while in batch mode, load gmail credentials
#setwd("c:/Users/95218/Documents/R/public/iddeAlert") #jn directory
setwd("C:/Users/andreca/Documents/IDDEAlerts") #cb directory
use_secret_file('idde-alert.json')

#############################################################################
## Flow
QParameterCd <- "00065" ## stage, feet
startTime <- Sys.Date()-1 ## yesterday

#####################################################################
## Upper Irwin Watershed
recentQ <- readNWISuv(siteNumbers="02146285", # stewart @ morehead
                      parameterCd=QParameterCd,
                      startDate=startTime, tz="America/New_York")
recentQ$site<- rep("2Stewart@Morehead",nrow(recentQ)) #add site name

##upstream site
recentQ2 <- readNWISuv(siteNumbers="0214627970", # stewart @ state
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ2$site<- rep("1Stewart@State",nrow(recentQ2)) #add site name

##downstream site
recentQ3 <- readNWISuv(siteNumbers="02146211", # #irwin@statesville
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ3$site<- rep("3IrwinStatesville",nrow(recentQ3)) #add site name

##downstream site
recentQ4 <- readNWISuv(siteNumbers="02146300", # #irwin@mc22a
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ4$site<- rep("4IrwinWWTP",nrow(recentQ4)) #add site name

table<-Reduce(function(x, y) merge(x, y, all=TRUE), list(recentQ, recentQ2, recentQ3, recentQ4))
colnames(table)[colnames(table)=="X_00065_00000"] <- "stageFT"
p1<-ggplot(aes(x = dateTime, y = stageFT, colour=site, group=site), data = table) + geom_line() + ggtitle ("UpperIrwin")
###########################################################################
##Steele+Sugar Watershed
##upstreamsite
recentQ2 <- readNWISuv(siteNumbers="0214678175", # #steele@carowinds
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ2$site<- rep("1Steele@carowinds",nrow(recentQ2)) #add site name

##tributary
recentQ <- readNWISuv(siteNumbers="02146315", # taggart@West
                      parameterCd=QParameterCd,
                      startDate=startTime, tz="America/New_York")
recentQ$site<- rep("2taggart@West",nrow(recentQ)) #add site name

##tributary
recentQ3 <- readNWISuv(siteNumbers="02146348", #coffey@49
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ3$site<- rep("3coffey@49",nrow(recentQ3)) #add site name

##downstream site
recentQ4 <- readNWISuv(siteNumbers="02146330", # sugar@arrowwood
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ4$site<- rep("4sugar@arrowwood",nrow(recentQ4)) #add site name

##downstream site
recentQ5 <- readNWISuv(siteNumbers="02146381", # #sugar@51
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ5$site<- rep("5sugar@51",nrow(recentQ5)) #add site name

table<-Reduce(function(x, y) merge(x, y, all=TRUE), list(recentQ, recentQ2, recentQ3, recentQ4, recentQ5))
colnames(table)[colnames(table)=="X_00065_00000"] <- "stageFT"

p2<-ggplot(aes(x = dateTime, y = stageFT, colour=site, group=site), data = table) + geom_line() + ggtitle ("Sugar")


###############################################################################
##Upper Briar Watershed
recentQ <- readNWISuv(siteNumbers="0214643770", #briar@74
                      parameterCd=QParameterCd,
                      startDate=startTime, tz="America/New_York")
recentQ$site<- rep("2Briar@74",nrow(recentQ)) #add site name

##upstream site
recentQ2 <- readNWISuv(siteNumbers="0214642825", # briar @ shamrock
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ2$site<- rep("1Briar@Shamrock",nrow(recentQ2)) #add site name

##downstream site
recentQ3 <- readNWISuv(siteNumbers="0214643860", #briar@chantilly
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ3$site<- rep("4briar@chantilly",nrow(recentQ3)) #add site name

##tributary
recentQ4 <- readNWISuv(siteNumbers="0214643820", #edwards@sheffield
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ4$site<- rep("3edwards@sheff",nrow(recentQ4)) #add site name

##downstream site
recentQ5 <- readNWISuv(siteNumbers="02146449", #briar@providence
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ5$site<- rep("5briar@providence",nrow(recentQ5)) #add site name


table<-Reduce(function(x, y) merge(x, y, all=TRUE), list(recentQ, recentQ2, recentQ3,recentQ4,recentQ5))
colnames(table)[colnames(table)=="X_00065_00000"] <- "stageFT"

p3<-ggplot(aes(x = dateTime, y = stageFT, colour=site, group=site), data = table) + geom_line() + ggtitle ("Upper Briar Creek.")

#####################################################################

##Upper LSC watershed
## Pull most recent data
recentQ <- readNWISuv(siteNumbers="02146409", # little sugar
                             parameterCd=QParameterCd,
                             startDate=startTime, tz="America/New_York")

recentQ$site<- rep("2LSC@Morehead",nrow(recentQ)) #add site name

##upstream site
## Pull most recent data
recentQ36 <- readNWISuv(siteNumbers="0214640410", # #lsc@36th
                        parameterCd=QParameterCd,
                        startDate=startTime, tz="America/New_York")
recentQ36$site<- rep("1LSC@36th",nrow(recentQ36)) #add site name

##downstream site
## Pull most recent data
recentQhill <- readNWISuv(siteNumbers="02146420", # #lsc@hillside
                          parameterCd=QParameterCd,
                          startDate=startTime, tz="America/New_York")
recentQhill$site<- rep("3LSC@hillside",nrow(recentQhill)) #add site name


table<-Reduce(function(x, y) merge(x, y, all=TRUE), list(recentQ, recentQ36, recentQhill))
colnames(table)[colnames(table)=="X_00065_00000"] <- "stageFT"

p4<-ggplot(aes(x = dateTime, y = stageFT, colour=site, group=site), data = table) + geom_line() + ggtitle ("UpperLSC")

######################################################################
#Lower LSC/Briar
recentQ2 <- readNWISuv(siteNumbers="0214645075", #tribBriar@Colony
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ2$site<- rep("2tribBriar@Colony",nrow(recentQ2)) #add site name

##downstream site
## Pull most recent data
recentQ4 <- readNWISuv(siteNumbers="0214645080", #tribBriar@Runnymede
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ4$site<- rep("3tribBriar@Runnymede",nrow(recentQ4)) #add site name

##downstream site
## Pull most recent data
recentQ3 <- readNWISuv(siteNumbers="02146507", #LSC@archdale
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ3$site<- rep("4LSC@archdale",nrow(recentQ3)) #add site name

##downstream site
## Pull most recent data
recentQ5 <- readNWISuv(siteNumbers="02146530", #LSC@51
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ5$site<- rep("5LSC@51",nrow(recentQ5)) #add site name

table<-Reduce(function(x, y) merge(x, y, all=TRUE), list(recentQ2, recentQ3,recentQ4,recentQ5))
colnames(table)[colnames(table)=="X_00065_00000"] <- "stageFT"

p5<-ggplot(aes(x = dateTime, y = stageFT, colour=site, group=site), data = table) + geom_line() + ggtitle ("LSC")
#####################################################################################
#Upper McAlpine Watershed
recentQ <- readNWISuv(siteNumbers="02146562", #campbell@idewild
                      parameterCd=QParameterCd,
                      startDate=startTime, tz="America/New_York")
recentQ$site<- rep("1campbell@idewild",nrow(recentQ)) #add site name


recentQ2 <- readNWISuv(siteNumbers="0214655255", #mcalpine@idewild
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ2$site<- rep("2mcalpine@idewild",nrow(recentQ2)) #add site name

recentQ3 <- readNWISuv(siteNumbers="0214657975", #irvins@samnewell
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ3$site<- rep("3irvins@samnewell",nrow(recentQ3)) #add site name

recentQ4 <- readNWISuv(siteNumbers="02146600", #mcalpine@sardis
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ4$site<- rep("4mcalpine@sardis",nrow(recentQ4)) #add site name


recentQ5 <- readNWISuv(siteNumbers="02146614", #mcalpine@colony
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ5$site<- rep("5mcalpine@colony",nrow(recentQ5)) #add site name



table<-Reduce(function(x, y) merge(x, y, all=TRUE), list(recentQ, recentQ2, recentQ3,recentQ4,recentQ5))
colnames(table)[colnames(table)=="X_00065_00000"] <- "stageFT"

p6<-ggplot(aes(x = dateTime, y = stageFT, colour=site, group=site), data = table) + geom_line() + ggtitle ("Upper Mcalpine.")
###############################################################################
#Lower McAlpine
recentQ <- readNWISuv(siteNumbers="0214668150", #mcmullen@lincrest
                      parameterCd=QParameterCd,
                      startDate=startTime, tz="America/New_York")
recentQ$site<- rep("1mcmullen@lincrest",nrow(recentQ)) #add site name


recentQ2 <- readNWISuv(siteNumbers="02146700", #mcmullen@sharonview
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ2$site<- rep("2mcmullen@sharonview",nrow(recentQ2)) #add site name


recentQ4 <- readNWISuv(siteNumbers="02146614", #mcalpine@colony
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ4$site<- rep("4mcalpine@colony",nrow(recentQ4)) #add site name

recentQ5 <- readNWISuv(siteNumbers="02146750", #mcalpine@WWTP
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ5$site<- rep("5mcalpine@WWTP",nrow(recentQ5)) #add site name


table<-Reduce(function(x, y) merge(x, y, all=TRUE), list(recentQ, recentQ2, recentQ4,recentQ5))
colnames(table)[colnames(table)=="X_00065_00000"] <- "stageFT"

p7<-ggplot(aes(x = dateTime, y = stageFT, colour=site, group=site), data = table) + geom_line() + ggtitle ("Lower Mcalpine.")
###############################################################################
#Misc Other Watersheds - Catawba
recentQ <- readNWISuv(siteNumbers="02142900", #Long@Oakdale
                      parameterCd=QParameterCd,
                      startDate=startTime, tz="America/New_York")
recentQ$site<- rep("1Long@Oakdale",nrow(recentQ)) #add site name


recentQ2 <- readNWISuv(siteNumbers="02142914", #gumbranch
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ2$site<- rep("2gumbranch",nrow(recentQ2)) #add site name

recentQ3 <- readNWISuv(siteNumbers="0214291555", #long@MC14A
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ3$site<- rep("3long@MC14A",nrow(recentQ3)) #add site name


recentQ4 <- readNWISuv(siteNumbers="0214295600", #paw@74
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ4$site<- rep("4paw@74",nrow(recentQ4)) #add site name

recentQ5 <- readNWISuv(siteNumbers="0214297160", #beaverdam@windygap
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ5$site<- rep("5beaverdam@windygap",nrow(recentQ5)) #add site name


table<-Reduce(function(x, y) merge(x, y, all=TRUE), list(recentQ, recentQ2, recentQ3,recentQ4,recentQ5))
colnames(table)[colnames(table)=="X_00065_00000"] <- "stageFT"

p8<-ggplot(aes(x = dateTime, y = stageFT, colour=site, group=site), data = table) + geom_line() + ggtitle ("Long&Paw&Beaverdam")
###############################################################
##Yadkin streams + six mile

recentQ2 <- readNWISuv(siteNumbers="02124269", #back@caldwell
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ2$site<- rep("2back@caldwell",nrow(recentQ2)) #add site name

recentQ3 <- readNWISuv(siteNumbers="0212427947", #reedy@plaza
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ3$site<- rep("3reedy@plaza",nrow(recentQ3)) #add site name


recentQ4 <- readNWISuv(siteNumbers="0212430293", #reedy@reedycreekrd
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ4$site<- rep("4reedy@reedycreekrd",nrow(recentQ4)) #add site name

recentQ5 <- readNWISuv(siteNumbers="0212430653", #McKee@reedycreekrd
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ5$site<- rep("5McKee@reedycreekrd",nrow(recentQ5)) #add site name

recentQ6 <- readNWISuv(siteNumbers="0214685800", #SixMile@Marvin
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ6$site<- rep("6SixMile@Marvin",nrow(recentQ6)) #add site name


table<-Reduce(function(x, y) merge(x, y, all=TRUE), list(recentQ2, recentQ3,recentQ4,recentQ5,recentQ6))
colnames(table)[colnames(table)=="X_00065_00000"] <- "stageFT"

p9<-ggplot(aes(x = dateTime, y = stageFT, colour=site, group=site), data = table) + geom_line() + ggtitle ("Yadkin&SixMile")
#################################################################################
##stage gages that didn't fit well in other graphs.
recentQ3 <- readNWISuv(siteNumbers="02146670", #4mile@elm
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ3$site<- rep("3-4mile@elm",nrow(recentQ3)) #add site name

recentQ <- readNWISuv(siteNumbers="0212414900", #mallard@pavillion
                      parameterCd=QParameterCd,
                      startDate=startTime, tz="America/New_York")
recentQ$site<- rep("1mallard@pavillion",nrow(recentQ)) #add site name

recentQ2 <- readNWISuv(siteNumbers="02146470", #LHope@Seneca
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ2$site<- rep("2LHope@Seneca",nrow(recentQ2)) #add site name

recentQ6 <- readNWISuv(siteNumbers="0214645022", #briar@colony
                       parameterCd=QParameterCd,
                       startDate=startTime, tz="America/New_York")
recentQ6$site<- rep("6briar@colony",nrow(recentQ6)) #add site name

table<-Reduce(function(x, y) merge(x, y, all=TRUE), list(recentQ2, recentQ3,recentQ, recentQ6))
colnames(table)[colnames(table)=="X_00065_00000"] <- "stageFT"

p10<-ggplot(aes(x = dateTime, y = stageFT, colour=site, group=site), data = table) + geom_line() + ggtitle ("HighStageGraphs")
#############################################################################

compile<-grid.arrange(p1, p2, p3, p4, p5, p6, p7, p8, p9,p10, ncol=1 ,nrow = 10) # compile all phase1 graphs
ggsave('Phase1DailyGraph.png', plot = compile, width=11.5, height=24)

#############################################################################

    testEmail <- mime() %>%
        to("caroline.burgett@mecknc.gov") %>%
        from("idde.alert@gmail.com") %>%
        subject("Daily Stage Graphs") %>%
        
        html_body("Daily Message")->html_msg

html_msg %>%
  subject("DailyPhase1Graph") %>%
  attach_file("Phase1DailyGraph.png") -> file_attachment

    ## Send email
    send_message(file_attachment)
    
    
  ######################################################
  ######################################################
    
    
    recentQ <- readNWISuv(siteNumbers="0214265808", #torrence@bradford
                          parameterCd=QParameterCd,
                          startDate=startTime, tz="America/New_York")
    recentQ$site<- rep("1torrence@bradford",nrow(recentQ)) #add site name
    
    
    recentQ2 <- readNWISuv(siteNumbers="02142654", #McDowell@Gilead
                           parameterCd=QParameterCd,
                           startDate=startTime, tz="America/New_York")
    recentQ2$site<- rep("2McDowell@Gilead",nrow(recentQ2)) #add site name
    
    
    recentQ3 <- readNWISuv(siteNumbers="0214265828", #MC5
                           parameterCd=QParameterCd,
                           startDate=startTime, tz="America/New_York")
    recentQ3$site<- rep("3MC5",nrow(recentQ3)) #add site name
    
    
    recentQ4 <- readNWISuv(siteNumbers="0214266000", #McDowell@BeattiesFord
                           parameterCd=QParameterCd,
                           startDate=startTime, tz="America/New_York")
    recentQ4$site<- rep("4McDowell@BeattiesFord",nrow(recentQ4)) #add site name
    
    recentQ5 <- readNWISuv(siteNumbers="0214266080", #Gar@BeattiesFord
                           parameterCd=QParameterCd,
                           startDate=startTime, tz="America/New_York")
    recentQ5$site<- rep("5Gar@BeattiesFord",nrow(recentQ5)) #add site name
    
    table<-Reduce(function(x, y) merge(x, y, all=TRUE), list(recentQ, recentQ2, recentQ3,recentQ4,recentQ5))
    colnames(table)[colnames(table)=="X_00065_00000"] <- "stageFT"
    
    C1<-ggplot(aes(x = dateTime, y = stageFT, colour=site, group=site), data = table) + geom_line() + ggtitle ("McDowell&Gar")
    ####################################################################
    recentQ <- readNWISuv(siteNumbers="0212393300", #MY1B
                          parameterCd=QParameterCd,
                          startDate=startTime, tz="America/New_York")
    recentQ$site<- rep("1MY1B",nrow(recentQ)) #add site name
    
    
    recentQ2 <- readNWISuv(siteNumbers="02124080", #MY10
                           parameterCd=QParameterCd,
                           startDate=startTime, tz="America/New_York")
    recentQ2$site<- rep("2MY10",nrow(recentQ2)) #add site name
    
    
    recentQ3 <- readNWISuv(siteNumbers="0212466000", #MY8
                           parameterCd=QParameterCd,
                           startDate=startTime, tz="America/New_York")
    recentQ3$site<- rep("3MY8",nrow(recentQ3)) #add site name
    
    
    recentQ4 <- readNWISuv(siteNumbers="0212467451", #MY9
                           parameterCd=QParameterCd,
                           startDate=startTime, tz="America/New_York")
    recentQ4$site<- rep("4MY9",nrow(recentQ4)) #add site name
    
    recentQ5 <- readNWISuv(siteNumbers="0212467595", #Goose@MillGrove
                           parameterCd=QParameterCd,
                           startDate=startTime, tz="America/New_York")
    recentQ5$site<- rep("5Goose@MillGrove",nrow(recentQ5)) #add site name
    
    table<-Reduce(function(x, y) merge(x, y, all=TRUE), list(recentQ, recentQ2, recentQ3,recentQ4,recentQ5))
    colnames(table)[colnames(table)=="X_00065_00000"] <- "stageFT"
    
    C2<-ggplot(aes(x = dateTime, y = stageFT, colour=site, group=site), data = table) + geom_line() + ggtitle ("Yadkin")
    
    compile<-grid.arrange(C1,C2, ncol=1,nrow =2)
    ggsave('Phase2DailyGraph.png', plot = compile, width=11.5)
    
    
    testEmail <- mime() %>%
      to("caroline.burgett@mecknc.gov") %>%
      from("idde.alert@gmail.com") %>%
      
      html_body("Daily Message") -> html_msg
    
    
    html_msg %>%
      subject("DailyPhase2Graph") %>%
      attach_file("Phase2DailyGraph.png") -> file_attachment2
    
    ## Send email
    send_message(file_attachment2)
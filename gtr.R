setwd("/Users/juanmateos-garcia/Desktop/2015 core/Technation/code/")

#Packages
source("/Users/juanmateos-garcia/Desktop/Practical/Tools & apps/R/rpackages.R")

#Directories
if(!file.exists("gtr-data")) {dir.create("gtr-data")}
if(!file.exists("gtr-figures")) {dir.create("gtr-figures")}

#Functions
source("utility-Functions.R")
source("gtr-Functions.R")

#What do we want to do here? E.g. extract information
        #for a tech area: 
        #Projects linked to organisations liked to locations.

#Lets trial this with the term "big data".
myDataTest <- GetGtrData(term="\"big data\"",field="project")

#Convert relevant data into a dataframe
myDataDf <- ldply(myDataTest,ExtractGtrData)

#Loop over unique organisation IDs to get their
        #addresses
gtrOrgs <- myDataDf$orgUrl[!duplicated(myDataDf$org)]

myOrgsDf <- ldply(gtrOrgs,GetOrganisationAddress)

#with the BBC
bbcTest <- GetGtrData(term="bbc",field="project")
bbcDf <- ldply(bbcTest,ExtractGtrData)

bbcOrgs <- bbcDf$orgUrl[!duplicated(bbcDf$org)]

bbcOrgsDf <- ldply(bbcOrgs,GetOrganisationAddress)




myDataDf$orgUrl[[2]]




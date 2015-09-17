setwd("/Users/juanmateos-garcia/Desktop/2015 core/Technation/code/")

#Packages
source("/Users/juanmateos-garcia/Desktop/Practical/Tools & apps/R/rpackages.R")

#Directories
if(!file.exists("adZuna-data")) {dir.create("adZuna-data")}
if(!file.exists("adZuna-figures")) {dir.create("adZuna-figures")}

#Functions
source("utility-Functions")
source("adZuna-Functions.R")


#API credentials
myID <- "3f1ac4ef"
myKey <- "211e2210c7ac4850cfcbf8caca9300a1"    

#Construct call for categories
categoriesUrl <- paste0("http://api.adzuna.com:80/v1/api/jobs/gb/categories?app_id=",
                        myID,
                        "&app_key=",myKey)
categoriesParsed <- GetParseData(categoriesUrl)

#Construct call for it-jobs
jobsUrl <- paste0("http://api.adzuna.com:80/v1/api/jobs/gb/search/1?app_id="
                  ,myID,
                  "&app_key=",myKey,"&category=",sectorCategory)

#Get data
itJobs <- GetAdZunaData("it-jobs") #NB need to change
                #the threshold in the function.

#Extract data from JSON
first100ocs <- ldply(itJobs, ExtractAdZUnaData)

#Write data out
WriteDataOut(first100ocs)






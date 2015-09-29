#Script to extract data about AngelList startups/users by ecosystem from the 
        #AngelList API

#Packages
library(httr)
library(stringr)
library(XML)
library(RCurl)

#Utility functions
source("utility-Functions.R")

#Credentials obtained via https://angel.co/api
myToken <- "bb212a1d13911cbf22e8e2e262a514c25e16fbf80a05a0c5"
myTokenForUrl <- paste0("access_token=",myToken)

#API endpoint
endPoint <- "https://api.angel.co/1/"

#Strategy:
#Get the tag for a location, and then extract all information for that tag.

#GetPlaceData.AList function.
#Arguments: the name of a location, the type of objects we want to obtain
        #(startups or users)
#Returns: A list of objects of that type in that location

GetPlaceData.Alist <- function(x,type="startups") {
        
        #Construct URL for tag
        myTagUrl <- paste0(endPoint,
                        "/search/slugs?query=",x,"&",
                        myTokenForUrl)
        
        #Extract tag information from AngelList
        tagData <- GetParseData(myTagUrl)
        if (tagData$type != "LocationTag") {
                stop("it's not a location")
        } else {
                placeTag <- tagData$id
        }

        #Construct URL to get startup/user info
        myEntityUrl <- paste0(endPoint,
                              "tags/",placeTag,
                              "/",type,
                              "?",myTokenForUrl)
        
        #Extract the data (NB includes information about results at the end of the object)
        resultsReturned <- GetParseData(myEntityUrl)
        
        #Extract results and number of calls needed
        results <- resultsReturned[[1]]
        numberCalls <- resultsReturned$last_page
        
        #Loop to extract the rest of the data
        for (i in 2:numberCalls) {
                newUrl <- paste0(myEntityUrl,"&page=",i)
                newResults <- GetParseData(newUrl)
                results <- c(results, newResults[[1]])
        }
        return(results)
}

birmingham.startups <- GetPlaceData.Alist("birmingham")





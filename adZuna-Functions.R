#Function to get AdZuna data:
#Argument = a sector category.
#Returns = a JSON object with AdZuna data about job ads for the occupation

GetAdZunaData <- function(sectorCategory) {
        page <- 1
        url <- paste0("http://api.adzuna.com:80/v1/api/jobs/gb/search/",
                      page,
                      "?app_id=",myID,
                      "&app_key=",myKEY,
                      "&category=") 
        myUrl <- paste0(url,sectorCategory)
        myHtml.parsed <- GetParseData(myUrl)
        results <- myHtml.parsed$results
        #We need to make several API calls
        if (myHtml.parsed$count > 10) {
                #callNumber <- ceiling(myHtml.parsed$count/10)
                callIndex <- 1
                while (callIndex <= 10) { #Need to change this
                        callIndex <- callIndex + 1
                        page <- callIndex
                        newUrl <- gsub("search/1",paste0("search/",callIndex),
                                       myUrl)
                        myHtml.parsed <- GetParseData(newUrl)
                        results <- c(results,myHtml.parsed$results)
                }
        }
        return(results)
}


#Function to extract occupation data
ExtractAdZunaData <- function(x) {
        #Extract the data
        myDf <- data.frame(
                id = CheckNulls(x$id),
                title = CheckNulls(x$title),
                location = CheckNulls(x$location$display_name),
                lon = CheckNulls(x$longitude),
                lat = CheckNulls(x$latitude),
                salary.max = CheckNulls(x$salary_max),
                salary.min = CheckNulls(x$salary_min),
                salary.is_predicted = CheckNulls(x$salary_is_predicted),
                description = CheckNulls(x$description),
                contract.type = CheckNulls(x$contract_type))
        #Additional variables: mean salary
        myDf$salary.mean <- mean(myDf$salary.max,myDf$salary.min)
        
        #Another additional variable: company display name (if available)
        if ("display_name" %in% (names(x$company))) {
                myDf$company <- x$company["display_name"]
        } else {myDf$company <- NA
        }
        return(myDf)
}
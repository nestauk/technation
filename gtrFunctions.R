#Extract GTR data function
#Arguments: a search term we are interested in, and the field
        #where we want to search
#Returns: a JSON object we can then extract data from

GetGtrData <- function(term,field) {
        #Space the requests
        Sys.sleep(sample(seq(0,1,0.1),1))
        
        cleanTerm <- tolower(gsub(" ","+",term))
        gtrUrl <- paste0("http://gtr.rcuk.ac.uk/search/",
                        field,".json?term=",
                         cleanTerm)
        gtrRequest <- GET(gtrUrl)
        
        #Get the JSON object
        gtrResults <- content(gtrRequest)[["results"]]

        #Number of pages to loop over from the header in the API result
        nPages <- as.numeric(gtrRequest$headers["link-pages"])
        
        #While Loop to get the rest of the data
        index <- 1
        while(index < nPages) {
                Sys.sleep(sample(seq(0,1,0.1),1))
                
                index <- index + 1
                newGtrUrl <- paste0(gtrUrl,
                                    "&page=",index)
                newGtrResults <- content(GET(newGtrUrl))
                gtrResults <- c(gtrResults,newGtrResults$results)
        }
        return(gtrResults)
}
        
#ExtractGtrData function to put the data into a data.frame
#Arguments: A list of JSON objects with information on RC-funded projects
#Returns a data-frame with that same data.

ExtractGtrData <- function(x) {
        #Create new, smaller objects to make it easier to read below
        project <- x$projectComposition$project
        org <- x$projectComposition$leadResearchOrganisation
        person <- x$projectComposition$personRole
        
        myDf <- data.frame(
                id = CheckNulls(project$url),
                title=CheckNulls(project$title),
                value = CheckNulls(project$fund$valuePounds),
                start.date = CheckNulls(project$fund$start),
                end.date = CheckNulls(project$fund$end),
                funder = CheckNulls(project$fund$funder$name),
                org = CheckNulls(org$name),
                orgUrl = CheckNulls(org$url))
        
        return(myDf)
}



                
                
        

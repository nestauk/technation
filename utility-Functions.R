#Utility function to get and parse JSON data from APIs
#Argument: a url
#Returns the parsed JSON object
GetParseData <- function(x) {
        return(fromJSON(getURL(x)))
        Sys.sleep(sample(seq(1,1.5,0.1),1))
}


#Utility function to check for nulls in JSON.
#Arguments: a JSON field
#Returns the value if it isn't NULL, NA otherwise.

CheckNulls <- function(x) {
        if(is.null(x)==TRUE) {
                return(NA)
        } else {
                return(x)
        }
}
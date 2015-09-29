
#GetParseData function to get and parse JSON data from APIs
#Argument: a url and a delay
#Returns the parsed JSON object
GetParseData <- function(x,y=1) {
        insertDelay(y)
        return(fromJSON(getURL(x)))
}

#GetParseHtml function
#Arguments: a URL and the delay to introduce
#Returns a parsed html, after a delay
GetParseHtml <- function(x,y=1) {
        return(htmlParse(getURL(x)))
}


#insertDelay utility function.
#Arguments: the top length to delay for
#returns a delay.
insertDelay <- function(x) {
        Sys.sleep(sample(seq(0,x,0.1),1))
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
#Getting some startup data for Elina et al from the Built in London
        #website

#Download
if(!file.exists("bultInLondon-data")) {dir.create("builtInLondon-data")}

url <- "http://www.builtinlondon.com"
webpage <- GetParse(url)

#Parse and extract names
startupLinks <- xpathSApply(webpage,"//div[@class='all-startups']/ul/li/a",
                            xmlGetAttr,"href")

#GetStartupData function:
#Arguments: a url in the Built in London site.
#Returns some meta-data about the company.
GetStartupData <- function(x) {
        myUrl <- paste0(url,x)
        startupPage <- GetParse(myUrl)
        
        metaData <- xpathApply(startupPage,
                               "//div[@class='company-meta']/p",xmlValue)
        myDf.pre <- as.data.frame(t(sapply(metaData[-6],str_trim)))
        myDf <- cbind(gsub("/","",x),myDf.pre)
        names(myDf) <- c("startup","founder","address","size","url","twitter")
        return(myDf)
}

#Create dataframe
allStartupData <- ldply(startupLinks,GetStartupData)

#Write out data
write.csv(allStartupData,"builtInLondon-data/startupData.csv",
          row.names=F)




